BASEDIR := $$HOME/kernel

define create_basedir
	@if [ ! $(BASEDIR) ]; then
		echo "BASEDIR is not defined"
		exit 1
	fi

	mkdir -p $(BASEDIR)
endef

define check_dir
	$(call create_basedir)

	if [ -d ${1} ]; then
		exit
	fi
endef
