.PHONY: clang linux qemu dev

clang:
	$(MAKE) -C clang

linux:
	$(MAKE) -C linux

qemu:
	$(MAKE) -C qemu

dev: clang qemu
	$(MAKE) -C linux dev
	$(MAKE) -C dev
