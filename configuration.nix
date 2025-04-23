{pkgs-unstable, ...}: {
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
    supportedLocales = [
      "en_IN/UTF-8"
      "en_GB.UTF-8/UTF-8" # needed in waybar to start calendar week on monday instead of sunday
    ];
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
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs-unstable; [
      firefox # browser

      kitty # terminal

      waybar # top bar
      (
        waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
      )

      dunst # notification daemon
      libnotify

      rofi-wayland # app launcher

      easyeffects # ui for audio devices

      nautilus # file manager
      eog # image viewer
      gnome-calculator # calculator

      brightnessctl # brightness controls

      git
      gcc

      networkmanagerapplet # network applet

      bluez # bluetooth manager
      blueman # fixed battery notifications

      zoxide # fuzzy search cd

      gitui

      gnumake # for make

      xdg-utils # mime-type support

      playerctl # play/pause/next/etc through mpris

      polkit # privileged access manager

      hyprlock # lockscreen
      hypridle # idle daemon
      hyprpaper # wallpaper util
      hyprpolkitagent # polkit agent

      ripgrep # fuzzy finder for neovim

      starship # shell prompt

      ruff # linter/formatter for python
      basedpyright # LSP for python

      taplo # LSP toolkit for toml

      lua-language-server # LSP for lua
      stylua # formatter for lua

      nil # language server for nix
      alejandra # formatter for nix

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

      bibata-cursors # cursor theme
      papirus-icon-theme # icon theme
      gnome-themes-extra # for adwaita theme

      vscode-fhs

      qt5.qtwayland # qt 5 support
      libsForQt5.qt5ct # qt 5 theme manager
      adwaita-qt # theme for qt apps

      kdePackages.kdenlive # video editor
      libsForQt5.mlt
      ffmpeg

      alsa-utils # `aplay` for playing sounds
    ];
  };

  # periodic gc & nix store optimization
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # system packages
  environment.systemPackages = with pkgs-unstable; [
    neovim # editor
    tmux # terminal multiplexer
  ];

  # set neovim as default editor
  environment.variables = {
    EDITOR = "nvim";
  };

  # set XDG variables
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";
    QT_QPA_PLATFORM = "wayland";
  };

  # hyprland
  programs.hyprland = {
    enable = true;
  };

  # qt setup
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };

  # gtk dark theme setup
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = "Adwaita";
            color-scheme = "prefer-dark";
            cursor-theme = "Bibata-Modern-Ice";
            icon-theme = "Papirus-Dark";
          };
        };
      }
    ];
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
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig.ExecStart = "${bluez}/bin/mpris-proxy";
    };
  };

  fonts.packages = with pkgs-unstable; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];

  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable nix command and flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
