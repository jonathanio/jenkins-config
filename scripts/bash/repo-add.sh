#!/usr/bin/env bash -ex

PKG_DIR=${JOB_BASE_NAME}
REPO=$(pwd)/private

cd ${REPO}/new/${PKG_DIR//-auto/}

echo "Loading packages in ${PKG_DIR//-auto}:"
find \
  -maxdepth 1 \
      -iname '*.pkg.tar.zstd' \
  -or -iname '*.pkg.tar.xz' \
  -type f -printf '%f\n' | \
while read PKG
do
  ADD_OPTIONS="-R"

  echo "Loading package ${PKG}"

  if [[ ! -e "${REPO}/${PKG}" ]]
  then
    # Upgrade current version, not just override existing
    ADD_OPTIONS+=" -n"
  fi

  mv "${PKG}" "${REPO}/${PKG}"
  ( cd "${REPO}" && \
    set -x && \
    repo-add ${ADD_OPTIONS} private.db.tar.gz "${PKG}" )
done

# Delete anything that hasn't been moved and added
rm -f *
