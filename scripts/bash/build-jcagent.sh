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
./build --nosign --syncdeps --rmdeps --noconfirm

# Clean up any downloaded packages
sudo pacman -Scc --noconfirm
