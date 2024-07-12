include ../lib.mk

.ONESHELL:

.PHONY: all clone update package build install

all: install

LLVMDIR := $(TOOLSDIR)/llvm-project
BUILDDIR := $(LLVMDIR)/build

clone:
	$(call check_dir,$(LLVMDIR))

	cd $(TOOLSDIR)
	git clone https://github.com/llvm/llvm-project.git

update: clone
	cd $(LLVMDIR)
	git pull

package:
	sudo dnf install -y cmake gcc gcc-c++ libedit-devel libxml2-devel zlib-devel

build: update package
	mkdir -p $(BUILDDIR)
	cd $(BUILDDIR)
	cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm
	make -j $(shell nproc)

install: build
	cd $(BUILDDIR)
	sudo make -j $(shell nproc) install
