TARGETS = $(HOME)/.zshrc $(HOME)/.oh-my-zsh
SHELL = /bin/bash
CWD = $(shell pwd)

define check_file
	@if [[ -e $1 && "$(OVERWRITE)" != "1" ]]; then \
		echo "make install won't overwrite $1"; \
		echo "1) remove it yourself or 2) use 'make install OVERWRITE=1'"; \
		false \
	else true; \
	fi
endef

all:
	@echo type make install.

$(HOME)/.%: %
	$(call check_file,$@)
	ln -fs $(PWD)/$< $@

$(HOME)/.oh-my-zsh:
	ln -fs $(PWD) $@

install: $(TARGETS)
	git submodule update --init
	chsh -s `which zsh`

update:
	git pull
	git submodule sync
	git submodule update --init

.PHONY: install update
