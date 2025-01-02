#!/bin/sh

date=$(date +%Y.%m)

branch_r() {
  r="${1:-0}"
  if git show-ref --tags "${date}.${r}" --quiet; then
    branch_r $(( $r + 1 ))
  else
    echo $r
  fi
}

branch="release/${date}.$(branch_r)"

git checkout origin/staging -b "${branch}"
