set -euo pipefail

KEY="${HOME}/.ssh/id_ed25519_github_signing"
PUBKEY="${KEY}.pub"
MARKER="${KEY}.github"
EMAIL="anhedonix@gmail.com"
TITLE="Git signing ($(uname -n))"

mkdir -p "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"

if [[ ! -f "${KEY}" ]]; then
  echo "Generating SSH commit-signing key at ${KEY}"
  ssh-keygen -t ed25519 -f "${KEY}" -N "" -C "git-signing:${EMAIL}"
fi

ensure_gh_auth() {
  if gh ssh-key list >/dev/null 2>&1; then
    return 0
  fi

  echo "GitHub CLI is not authenticated (or lacks admin:public_key). Starting web login..."
  gh auth login -h github.com -p https -w -c -s admin:public_key
}

ensure_gh_auth

pubkey_body="$(awk '{print $1" "$2}' "${PUBKEY}")"

if gh ssh-key list | grep -F "${pubkey_body}" >/dev/null 2>&1; then
  echo "Signing key already registered on GitHub"
else
  echo "Uploading signing key to GitHub..."
  gh ssh-key add --type signing -t "${TITLE}" "${PUBKEY}"
fi

touch "${MARKER}"
echo "Git SSH commit signing is ready (${KEY})"
