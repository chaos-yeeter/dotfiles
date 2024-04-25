#!/usr/bin/env bash
swayidle -w \
    timeout 300 'swaylock -f --config ~/projects/dotfiles/setup/swaylock.config' \
    before-sleep 'swaylock -f --config ~/projects/dotfiles/setup/swaylock.config' &

swaylock -f --config ~/projects/dotfiles/setup/swaylock.config &
