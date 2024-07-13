ARCH := $(shell uname -m)

LKMISCDIR := $(shell echo $$PWD)
BASEDIR := $$HOME/kernel
TOOLSDIR := $(BASEDIR)/tools

define create_basedir
	@if [ ! $(BASEDIR) ]; then
		echo "BASEDIR is not defined"
		exit 1
	fi

	mkdir -p $(TOOLSDIR)
endef

define check_dir
	$(call create_basedir)

	if [ -d ${1} ]; then
		exit
	fi
endef

LDCONFDIR := /etc/ld.so.conf.d
LDCONFIG := $(LDCONFDIR)/lkmisc.conf

define update_ldconfig
	sudo mkdir -p $(LDCONFDIR)
	sudo touch $(LDCONFIG)

	if ! grep -E "^${1}$$" $(LDCONFIG); then
		echo ${1} | sudo tee -a $(LDCONFIG)
		sudo ldconfig
	fi
endef
