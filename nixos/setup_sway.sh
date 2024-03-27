#!/usr/bin/env bash
swayidle -w \
    timeout 300 'swaylock -f --config ~/projects/dotfiles/nixos/swaylock.config' \
    before-sleep 'swaylock -f --config ~/projects/dotfiles/nixos/swaylock.config' &

swaylock -f --config ~/projects/dotfiles/nixos/swaylock.config &
