.PHONY: clang linux dev

clang:
	$(MAKE) -C clang

linux:
	$(MAKE) -C linux

dev: clang
	$(MAKE) -C linux dev
	$(MAKE) -C dev
