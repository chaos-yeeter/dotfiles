ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

nixos-switch:
	sudo nixos-rebuild switch --flake ${ROOT_DIR}/nixos

nixos-test:
	sudo nixos-rebuild test --flake ${ROOT_DIR}/nixos
