ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install-nvim:
	mkdir -p ~/.config/nvim
	ln -sf ${ROOT_DIR}/lua	~/.config/nvim
	ln -sf ${ROOT_DIR}/ftplugin ~/.config/nvim
	ln -sf ${ROOT_DIR}/init.lua	~/.config/nvim/
