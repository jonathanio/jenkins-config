#!/usr/bin/env bash -ex

echo -n ":: Checking for DB lock release..."
while [[ -f /var/lib/pacman/db.lck ]]
do
  sleep 30
  echo -n "."
done
echo "released"

# Make sure the system is up-to-date
sudo pacman -Syu --noconfirm --noprogressbar

# Build the package, as required
makepkg --nosign --syncdeps --rmdeps --noconfirm

# Clean up any downloaded packages
sudo pacman -Scc --noconfirm

# This is a hack to handle Zoom packages which are also .pkg.tar.xz files
rm -f *_orig_*.pkg.tar.xz
