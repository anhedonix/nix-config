#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
USERNAME="${1:-amagaji}"
HOSTNAME="${2:-amagaji-mac}"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "error: switch-mac.sh must be run on macOS (Darwin)." >&2
  exit 1
fi

export PRIMARY_USER="$USERNAME"
FLAKE_REF="${REPO_ROOT}#${HOSTNAME}"

echo "Switching macOS configuration"
echo "  user:  ${USERNAME}"
echo "  host:  ${HOSTNAME}"
echo "  flake: ${FLAKE_REF}"

sudo exec darwin-rebuild switch --impure --flake "${FLAKE_REF}"
