#!/usr/bin/env bash

set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit "${2:-1}"; }

if [ "$#" -ne 2 ]; then
    die "Invalid number of arguments"
fi

archive_dir=$1
log_dir=$2

if ! [ -d "$log_dir" ]; then
    die "${log_dir} does not exist or is not a directory"
fi

count=0
mkdir -p "$archive_dir"

shopt -s nullglob
for f in "$log_dir"/*.log; do
  age=$(find "$f" -mtime +7)
  if [ "$age" ]; then
    mv "$f" "$archive_dir/"
    count=$((count+1))
  fi
done

echo "Archived $count files"