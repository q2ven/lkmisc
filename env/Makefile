.PHONY: clang linux qemu syzkaller dev

clang:
	$(MAKE) -C clang

linux:
	$(MAKE) -C linux

qemu:
	$(MAKE) -C qemu

syzkaller:
	$(MAKE) -C syzkaller

dev: clang qemu
	$(MAKE) -C syzkaller dev
	$(MAKE) -C linux dev
	$(MAKE) -C dev
