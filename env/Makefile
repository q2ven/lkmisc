.PHONY: clang linux qemu syzkaller dev $(SYZ)

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

SYZ := kmsan kasan

$(SYZ):
	$(MAKE) -C linux NAME=$@ REMOTE=net-next syz
	$(MAKE) -C syzkaller NAME=$@ REMOTE=net-next syz
