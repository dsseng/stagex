#!/bin/sh

set -eux

if ! git status --porcelain;
  echo 'Unclean tree! Aborting!'
  exit 1
fi

date=$(date +%Y.%m)

branch_r() {
  r="${1:-0}"
  if git show-ref --tags "${date}.${r}" --quiet; then
    branch_r $(( $r + 1 ))
  else
    echo $r
  fi
}

release="$(branch_r)"

branch="release/${date}.${release}"

git fetch origin/staging
git checkout origin/staging

gitroot="$(git rev-parse --show-toplevel)"

if test -d "${gitroot}/out/"
  rm -rfi "${gitroot}/out/"
fi

make
make digests

git switch "${branch}"
git add "${gitroot}/digests/"
git commit -m "Update digests for ${date}.${release}"
git push origin "${branch}"
