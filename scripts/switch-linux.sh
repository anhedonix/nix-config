#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
USERNAME="${1:-amagaji}"
HOSTNAME="${2:-tp14s}"

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "error: switch-linux.sh must be run on Linux." >&2
  exit 1
fi

export PRIMARY_USER="$USERNAME"
FLAKE_REF="${REPO_ROOT}#${HOSTNAME}"

echo "Switching NixOS configuration"
echo "  user:  ${USERNAME}"
echo "  host:  ${HOSTNAME}"
echo "  flake: ${FLAKE_REF}"

sudo exec sudo nixos-rebuild switch --impure --flake "${FLAKE_REF}"
