#!/bin/bash

set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit "${2:-1}"; }

# No args
if ! [ "$#" -eq 1 ]; then
    die "Usage: ./log_audit file_name" 2
fi

# File does not exist
if ! [ -d "$1" ]; then
    die "${1} does not exist or is not a directory" 3
fi

flagged=0
scanned=0

shopt -s nullglob
for file in "$1"/*; do
    errors=$(grep -c "ERROR" "$file" || true)
    log "${file}: ${errors} errors"

    if [ "$errors" -gt 10 ]; then
        mkdir -p "review"
        cp "$file" "review/$(basename "$file")"
        flagged=$((flagged+1))
    fi

    scanned=$((scanned+1))
done

log "scanned:${scanned}"
log "flagged:${flagged}"

if [ "$flagged" -gt 0 ]; then
    exit 1
fi