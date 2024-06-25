ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

nixos-hardware-file-check:
	# exit when current hardware-configuration is different from default hardware-configuration in /etc/nixos
	@if [ -n "$(cmp ${ROOT_DIR}/hardware-configuration.nix /etc/nixos/hardware-configuration.nix)" ]; then \
		echo '/etc/nixos/hardware-configuration.nix and ${ROOT_DIR}/hardware-configuration.nix are different'; \
		echo 'this can cause issues. check following diff and try again'; \
		diff /etc/nixos/hardware-configuration.nix ${ROOT_DIR}/hardware-configuration.nix; \
		exit 1; \
	fi

nixos-switch:
	make --no-print-directory nixos-hardware-file-check
	sudo nixos-rebuild switch --flake ${ROOT_DIR}

nixos-test:
	make --no-print-directory nixos-hardware-file-check
	sudo nixos-rebuild test --flake ${ROOT_DIR}

stow:
	stow dotfiles -t ~ -vv
