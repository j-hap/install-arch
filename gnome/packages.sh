#! /bin/bash

install=(
  vim
  zsh
  keepassxc
  libreoffice-draw
  libreoffice-calc
  libreoffice-writer
)

remove=(
  nano
)

sudo dnf --assumeyes install ${install[@]}
sudo dnf --assumeyes remove ${remove[@]}
