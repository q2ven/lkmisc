include ../lib.mk

.ONESHELL:

.PHONY: all clone update

all: update

LINUXDIR := $(BASEDIR)/linux

clone:
	$(call check_dir,$(LINUXDIR))

	cd $(BASEDIR)
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

	cd $(LINUXDIR)
	git remote add net-next git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
	git remote add net git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
	git remote add bpf-next git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
	git remote add bpf git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
	git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

update: clone
	cd $(LINUXDIR)
	git fetch --all
