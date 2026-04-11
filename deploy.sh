#!/usr/bin/env bash
set -euo pipefail

# deploy-rs at home

LOCAL="$HOME/server"
REMOTE="madeline@gpg.pet:/home/madeline/server"
HOST="madeline@gpg.pet"

echo "==> syncing $LOCAL to $REMOTE..."
rsync -av --delete "$LOCAL/" "$REMOTE/"

echo "==> running nixos-rebuild switch on remote..."
ssh "$HOST" "sudo nixos-rebuild switch --flake /home/madeline/server"

echo "==> done."
