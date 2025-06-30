update:
	sudo pacman -Sy --needed archlinux-keyring
	sudo pacman -Syu --needed \
		bash starship zoxide fzf \
		neovim wl-clipboard xdg-utils ripgrep \
		tmux \
		git gitui \
		base-devel gcc make stow jq \
		ttf-firacode-nerd noto-fonts noto-fonts-extra noto-fonts-emoji \
		hyprland hyprlock hypridle hyprpaper xdg-desktop-portal-gtk \
		waybar \
		rofi-wayland dunst libnotify \
		pipewire pipewire-pulse wireplumber easyeffects calf alsa-utils \
		brightnessctl playerctl \
		network-manager-applet bluez blueman \
		polkit polkit-gnome \
		nautilus gvfs gnome-disk-utility gnome-system-monitor eog \
		papirus-icon-theme gnome-themes-extra \
		qt5-wayland qt5ct \
		ruff \
		taplo \
		lua-language-server stylua \
		typescript-language-server tailwindcss-language-server yaml-language-server \
		vlc \
		gimp \
		obsidian \
		kdenlive ffmpeg mlt

	yay -Sy --needed \
		zen-browser-bin \
		basedpyright \
		vscode-langservers-extracted prettierd \
		grimblast-git \
		sleek \
		bibata-cursor-theme \
		adwaita-qt-git

	unused_packages="$(pacman -Qdtq)"
	@if [[ -n "$$unused_packages" ]]; then \
		sudo pacman -Rsup "$$unused_packages"; \
	fi

config:
	stow dotfiles -t ~ -vv 2>&1
