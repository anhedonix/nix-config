#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOSTNAME="${1:-amagaji-mac}"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "error: switch-mac.sh must be run on macOS (Darwin)." >&2
  exit 1
fi

FLAKE_REF="${REPO_ROOT}/darwin#${HOSTNAME}"

# Home Manager requires a profiles dir before it can link home files. Determinate
# Nix often does not create /nix/var/nix/profiles/per-user/$USER.
mkdir -p "${HOME}/.local/state/nix/profiles"

echo "Switching macOS configuration"
echo "  host:  ${HOSTNAME}"
echo "  flake: ${FLAKE_REF}"

exec sudo darwin-rebuild switch --flake "${FLAKE_REF}"
