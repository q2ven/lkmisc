include ../../lib.mk

.ONESHELL:

.PHONY: all clone update package build install

all: install

PAHOLEDIR := $(TOOLSDIR)/pahole
BUILDDIR := $(PAHOLEDIR)/build

clone:
	$(call check_dir,$(PAHOLEDIR))

	cd $(TOOLSDIR)
	git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git

update: clone
	cd $(PAHOLEDIR)
	git pull
	git submodule update --init --recursive

package:
	sudo dnf install -y cmake

build: update package
	mkdir -p $(BUILDDIR)
	cd $(BUILDDIR)
	cmake ../
	make -j $(shell nproc)

install: build
	cd $(BUILDDIR)
	sudo make -j $(shell nproc) install
	$(call update_ldconfig,/usr/local/)
