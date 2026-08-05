#!/bin/bash
set -euo pipefail

EMACS_DIR="${HOME}/.config/emacs"

if [ -e "$EMACS_DIR" ]; then
  echo "Doom Emacs already present at $EMACS_DIR; skipping install."
  exit 0
fi

if ! command -v emacs >/dev/null 2>&1; then
  echo "emacs not found on PATH; install Emacs first, then re-run." >&2
  exit 1
fi

git clone --depth 1 https://github.com/doomemacs/core "$EMACS_DIR"
"$EMACS_DIR/bin/doom" install --force
