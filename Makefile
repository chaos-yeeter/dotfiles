update:
	sudo pacman -Sy --needed archlinux-keyring
	sudo pacman -Syu --needed \
		man-db man-pages \
		bash starship zoxide fzf \
		neovim wl-clipboard xdg-utils ripgrep \
		tmux \
		git gitui \
		base-devel gcc make stow jq \
		ttf-firacode-nerd noto-fonts noto-fonts-extra noto-fonts-emoji \
		niri hyprpaper hypridle hyprlock xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
		waybar \
		rofi-wayland dunst libnotify \
		pipewire pipewire-pulse wireplumber calf alsa-utils \
		brightnessctl playerctl \
		network-manager-applet bluez blueman \
		polkit polkit-gnome \
		gsettings-desktop-schemas \
		nautilus gvfs gnome-disk-utility gnome-system-monitor eog gnome-calculator \
		papirus-icon-theme gnome-themes-extra \
		qt5-wayland qt5ct qt6-wayland qt6ct \
		uv \
		ruff \
		taplo \
		lua-language-server stylua \
		prettier \
		clang cmake ninja \
		vlc \
		gimp \
		obsidian \
		kdenlive ffmpeg mlt \
		qbittorrent \
		flatpak \
		yazi poppler fd resvg 7zip

	yay -Sy --needed --aur yay
	yay -Sy --clean --needed --aur --answerdiff ALL \
		basedpyright \
		sql-formatter \
		bibata-cursor-theme \
		adwaita-qt5 adwaita-qt6 \
		visual-studio-code-bin

	flatpak remote-add --user --if-not-exists \
		flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install --or-update --user \
		app.zen_browser.zen

config:
	stow dotfiles -t ~ -vv 2>&1
