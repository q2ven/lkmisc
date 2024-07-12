include ../lib.mk

.ONESHELL:

.PHONY: all clone update package build install

all: install

BUILDDIR := $(TOOLSDIR)/qemu

clone:
	$(call check_dir,$(BUILDDIR))

	cd $(TOOLSDIR)
	git clone https://gitlab.com/qemu-project/qemu.git

update: clone
	cd $(BUILDDIR)
	git pull
	git submodule init
	git submodule update --recursive

package:
	sudo dnf install -y bison flex gcc python3-pip
	pip3 install tomli
	$(MAKE) -C libslirp

build: update package
	cd $(BUILDDIR)
	./configure --enable-slirp
	make -j $(shell nproc)

install: build
	cd $(BUILDDIR)
	sudo make -j $(shell nproc) install
