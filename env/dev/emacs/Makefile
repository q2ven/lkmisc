.ONESHELL:

.PHONY: all package config

all: config

package:
	sudo dnf install -y emacs

EMACSDIR := $$HOME/.emacs.d
EMACSCFG := $(EMACSDIR)/init.el

config: package
	mkdir -p $(EMACSDIR)
	touch $(EMACSCFG)

	sed -i "/;; lkmisc start ;;/,/;; lkmisc end ;;/c\\" $(EMACSCFG)
	echo -e ";; lkmisc start ;;\n" >> $(EMACSCFG)
	cat ./init.el >> $(EMACSCFG)
	echo -e "\n;; lkmisc end ;;" >> $(EMACSCFG)
