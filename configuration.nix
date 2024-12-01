{ pkgs-unstable, ... }:

{
    imports = [
        ./hardware-configuration.nix # include the results of the hardware scan
    ];

    # grub bootloader
    boot.loader.grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
    };

    # networking
    networking = {
        hostName = "frankenstein";
        networkmanager.enable = true;
    };

    # bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
                Experimental = true;
            };
        };
    };
    services.blueman.enable = true;
    environment.etc = {
        "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
            bluez_monitor.properties = {
                ["bluez5.enable-sbc-xq"] = true,
                ["bluez5.enable-msbc"] = true,
                ["bluez5.enable-hw-volume"] = true,
                ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
        '';
    };

    # timezone
    time.timeZone = "Asia/Kolkata";

    # internationalisation and locale
    i18n = {
        defaultLocale = "en_IN";
        extraLocaleSettings = {
            LC_ADDRESS = "en_IN";
            LC_IDENTIFICATION = "en_IN";
            LC_MEASUREMENT = "en_IN";
            LC_MONETARY = "en_IN";
            LC_NAME = "en_IN";
            LC_NUMERIC = "en_IN";
            LC_PAPER = "en_IN";
            LC_TELEPHONE = "en_IN";
            LC_TIME = "en_IN";
        };
    };

    # services
    services = {
        # layout in x11
        xserver.xkb = {
            layout = "us";
            variant = "";
        };

        # gvfs for nautilus
        gvfs.enable = true;
    };

    # user config & packages
    users.users.frankenstein = {
        isNormalUser = true;
        description = "frankenstein";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs-unstable; [
            firefox # browser

            kitty # terminal

            waybar # top bar
            (waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                })
            )

            dunst # notification daemon
            libnotify

            rofi-wayland # app launcher

            easyeffects # ui for audio devices

            nautilus # file manager
            dconf-editor # gsettings editor
            glib # gsettings cli
            adwaita-icon-theme # icon theme
            eog # image viewer
            gnome-calculator # calculator

            polkit # privileged access manager
            lxqt.lxqt-policykit # dialogues for authentication

            brightnessctl # brightness controls

            git
            gcc

            networkmanagerapplet # network applet

            bluez # bluetooth manager
            blueman # fixed battery notifications

            zoxide # fuzzy search cd

            gitui # git ui

            gnumake # for make

            xdg-utils # mime-type support

            playerctl # play/pause/next/etc through mpris

            hyprlock # lockscreen
            hypridle # idle daemon

            ripgrep # fuzzy finder for neovim

            starship # prompt

            ruff # linter/formatter for python
            ruff-lsp
            pyright # LSP for python

            taplo # LSP toolkit for toml

            lua-language-server # LSP for lua
            stylua # formatter for lua

            nil # language server for nix

            nodePackages.typescript-language-server # LSP for typescript
            vscode-langservers-extracted # LSP for html, css, eslint
            prettierd # formatter for html, js, ts, json, etc.
            tailwindcss-language-server # lsp for tailwind

            wl-clipboard # clipboard support

            fzf # fuzzy search

            stow # symlinking dotfiles

            jq # JSON processor

            grimblast # screenshot util

            yaml-language-server # lsp for yaml

            vlc # media player

            sleek # SQL formatter

            obsidian # markdown notes

            gimp # image editor
        ];
    };

    # system packages
    environment.systemPackages = with pkgs-unstable; [
        neovim # editor
        tmux # terminal multiplexer
    ];

    # set neovim as default editor
    environment.variables.EDITOR = "nvim";

    # hyprland
    programs.hyprland = {
        enable = true;
    };

    # polkit
    security.polkit.enable = true;

    # xdg portals
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs-unstable; [
            xdg-desktop-portal-gtk
        ];
    };

    # docker setup
    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # systemd services
    systemd.user.services = {
        # service for media controls from bluetooth devices
        custom-mpris-proxy = with pkgs-unstable; {
            description = "custom-mpris-proxy";
            after = [ "network.target" "sound.target" ];
            wantedBy = [ "default.target" ];
            serviceConfig.ExecStart = "${bluez}/bin/mpris-proxy";
        };
    };

    fonts.packages = with pkgs-unstable; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji

        fira-code
        fira-code-symbols
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    # unfree packages
    nixpkgs.config.allowUnfree = true;

    # enable nix command and flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
}
