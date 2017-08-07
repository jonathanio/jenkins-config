#!/usr/bin/env bash -ex

cd private/new
for PKG in *.pkg.tar.xz
do
  if [[ -e "../${PKG}" ]]; then
    mv "${PKG}" "../${PKG}"
    # Forcefully update and override existing version
    ( cd .. && repo-add -R private.db.tar.gz "${PKG}" )
  else
    mv "${PKG}" "../${PKG}"
    # Upgrade current version
    ( cd .. && repo-add -n -R private.db.tar.gz "${PKG}" )
  fi
done

