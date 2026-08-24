#!/bin/bash
# Registers every YubiKey public key in ~/.ssh with GitHub, both as a signing
# key (so the commits signed by ~/.gitconfig show as Verified) and as an
# authentication key (git over ssh). Safe to re-run.
set -euo pipefail

if ! gh auth status &>/dev/null; then
  echo "gh is not logged in, run: gh auth login" >&2
  exit 1
fi

# Managing keys needs two scopes the default login does not ask for, one per
# list: admin:ssh_signing_key for signing, admin:public_key for authentication.
gh auth status 2>&1 | rg -q 'admin:ssh_signing_key.*admin:public_key|admin:public_key.*admin:ssh_signing_key' ||
  gh auth refresh -h github.com -s admin:ssh_signing_key -s admin:public_key

shopt -s nullglob
pubs=(~/.ssh/id_yubikey_*.pub)
(("${#pubs[@]}")) || { echo "No ~/.ssh/id_yubikey_*.pub found, run setup-yubikey.sh first" >&2; exit 1; }

for pub in "${pubs[@]}"; do
  serial=${pub##*/id_yubikey_}
  serial=${serial%.pub}

  # GitHub keeps the two uses in separate lists, so the same public key has to
  # be registered twice.
  for type in signing authentication; do
    echo "==> Adding yubikey-$serial as $type"
    gh ssh-key add "$pub" --type "$type" --title "yubikey-$serial" ||
      echo "    not added, it is probably already there"
  done
done
