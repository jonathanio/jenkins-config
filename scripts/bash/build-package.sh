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

sudo pacman -Syu --noconfirm --noprogressbar

makepkg --nosign --syncdeps --rmdeps --noconfirm

sudo pacman -Scc --noconfirm
