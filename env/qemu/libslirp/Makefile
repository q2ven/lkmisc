include ../../lib.mk

.ONESHELL:

.PHONY: all clone update package install

all: install

BUILDDIR := $(TOOLSDIR)/libslirp

clone:
	$(call check_dir,$(BUILDDIR))

	cd $(TOOLSDIR)
	git clone https://gitlab.freedesktop.org/slirp/libslirp.git

update: clone
	cd $(BUILDDIR)
	git pull

package:
	sudo dnf install -y glib2-devel meson ninja-build

install: update package
	cd $(BUILDDIR)
	meson build
	sudo ninja -C build install
	$(call update_ldconfig,/usr/local/lib64/)
