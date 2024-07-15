include ../lib.mk

.ONESHELL:

.PHONY: all clone update __docker docker build install

all: install

BUILDDIR := $(TOOLSDIR)/syzkaller

clone:
	$(call check_dir,$(BUILDDIR))

	cd $(TOOLSDIR)
	git clone https://github.com/google/syzkaller.git

	cd $(BUILDDIR)
	cp -r $(LKMISCDIR)/patch ./
	git am --3way patch/*

update: clone
	cd $(BUILDDIR)
	git pull --rebase

__docker:
	sudo dnf install -y docker
	sudo systemctl enable docker
	sudo systemctl start docker
	sudo usermod -aG docker $(shell whoami)

docker:
	@if ! id | grep docker ; then
		$(MAKE) __docker

		echo "#######################################################"
		echo "#                                                     #"
		echo "# Please logout once, and run 'make syzkaller' again. #"
		echo "#                                                     #"
		echo "#######################################################"

		exit 1
	fi

build: update docker
	cd $(BUILDDIR)
	mkdir -p $$HOME/.cache

	if [[ $(ARCH) =~ "aarch64" ]]; then
		sudo dnf install -y go
		make -j $(shell nproc) clean
		make -j $(shell nproc)
	else
		./tools/syz-env make -j $(shell nproc) clean
		./tools/syz-env make -j $(shell nproc)

	fi

install: build
	if [[ $(ARCH) =~ "aarch64" ]]; then
		ARCHDIR=linux_arm64
	else
		ARCHDIR=linux_amd64
	fi

	sudo mkdir -p /usr/local/bin/$$ARCHDIR
	sudo install -m 755 $(BUILDDIR)/bin/$$ARCHDIR/syz* /usr/local/bin/$$ARCHDIR
	sudo install -m 755 $(BUILDDIR)/bin/syz* /usr/local/bin/
