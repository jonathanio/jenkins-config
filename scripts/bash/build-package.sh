#!/usr/bin/env bash -ex

LOCK="/var/lib/pacman/db.lck"

sleep $((RANDOM%11+2))

if [[ -f "${LOCK}" ]]
then
  echo ":: Waiting for database lock file to be removed..."
  echo -n "   "
  while [[ ! -f /var/lib/pacman/db.lck ]]
  do
    sleep 30
    echo -n "."
  done
  echo
fi

# Make sure the system is up-to-date
sudo pacman -Syu --noconfirm --noprogressbar

# Build the package, as required
makepkg --nosign --syncdeps --rmdeps --noconfirm

# Clean up any downloaded packages
sudo pacman -Scc --noconfirm

# This is a hack to handle Zoom packages which are also .pkg.tar.xz files
rm *_orig_*.pkg.tar.xz
