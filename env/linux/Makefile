include ../lib.mk

.ONESHELL:

.PHONY: all clone update worktree package dev

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

define create_worktree
	if [ ! -d $(BASEDIR)/${1} ]; then
		cd $(LINUXDIR)
		git worktree add $(BASEDIR)/${1} -b ${1} ${2}
	fi
endef

worktree: update
	$(call create_worktree,net-next,net-next/main)
	$(call create_worktree,net,net/main)

package:
	sudo dnf install -y bison elfutils-devel flex gcc ncurses-devel openssl-devel zlib-devel
	$(MAKE) -C pahole

dev: worktree package
