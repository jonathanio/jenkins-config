#!/bin/bash -ex

sudo pacman -Syu --noconfirm --noprogressbar

makepkg --nosign --syncdeps --rmdeps --noconfirm --noprogressbar
