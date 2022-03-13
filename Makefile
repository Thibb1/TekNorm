##
## EPITECH PROJECT, 2022
## TekNorm
## File description:
## Makefile
##

DIR		=	$(shell pwd)
NAME	=	$(DIR)/TekNorm.pl
DEST 	=	/usr/local/bin
OUT 	=	teknorm

all:
	@echo "Use 'make install' to install TekNorm or 'make uninstall' to remove it"

install:
	@mkdir -p $(DEST)
	@chmod +x $(NAME)
	@ln -s $(NAME) $(DEST)/$(OUT)
	@echo "TekNorm installed in $(DEST)"

uninstall:
	rm -f $(DEST)/$(OUT)
	@echo "TekNorm removed"

.PHONY: all installe uninstall
