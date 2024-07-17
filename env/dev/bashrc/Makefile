.ONESHELL:

.PHONY: all install

TARGET := $$HOME/.bashrc

all: install

install:
	sed -i "/### lkmisc start ###/,/### lkmisc end ###/c\\" $(TARGET)

	echo -e "### lkmisc start ###\n\n" >> $(TARGET)

	for f in ./snippet/*
	do
		echo -e "# $$(basename $$f .sh)\n" >> $(TARGET)
		cat $$f >> $(TARGET)
		echo -e "\n" >> $(TARGET)
	done

	echo "### lkmisc end ###" >> $(TARGET)
