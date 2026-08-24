#!/bin/bash
# YubiKey setup: FIDO2 auth for sudo/polkit, SSH resident keys, touch
# notifications. Enrolls two keys, a main one and a backup you keep elsewhere,
# so a lost key is an inconvenience and not a lockout.
#
# Run once per machine, it asks for each key in turn. Safe to re-run.
#
# One-time step this script does NOT do (do it for both keys first):
#   ykman fido access change-pin
set -euo pipefail

readonly link_script=/usr/local/bin/yubikey-ssh-link
readonly udev_rules=/etc/udev/rules.d/70-yubikey-ssh.rules
readonly touch_unit=~/.config/systemd/user/yubikey-touch-detector.service
readonly authfile=/etc/fido2/fido2

step() { echo "==> $*"; }

key_file() { echo ~/.ssh/id_yubikey_"$1"; }

read_serial() { ykman info 2>/dev/null | sed -n 's/^Serial number:[[:space:]]*//p'; }

# Prints the serial of the key the user plugged in. Prompts go to stderr so the
# serial is the only thing on stdout. $2, when given, is a serial to refuse, so
# the backup round cannot silently re-enroll the key that is already in.
wait_for_key() {
  local label=$1 reject=${2:-} serial

  while true; do
    read -rsp "    Plug in your $label YubiKey and press Enter..." </dev/tty >&2
    echo >&2
    serial=$(read_serial)

    if [[ -z $serial ]]; then
      echo "    No YubiKey detected." >&2
    elif [[ -n $reject && $serial == "$reject" ]]; then
      echo "    That is the same key (serial $serial), swap it for the other one." >&2
    else
      echo "    Found YubiKey $serial" >&2
      echo "$serial"
      return
    fi
  done
}

install_packages() {
  step "Installing YubiKey packages"
  omarchy-pkg-add \
    yubikey-manager \
    libfido2 \
    pam-u2f \
    pcsclite \
    ccid \
    yubikey-touch-detector
  omarchy-pkg-aur-add yubico-authenticator-bin

  step "Enabling the smart-card daemon"
  sudo systemctl enable --now pcscd.socket
}

# ~/.ssh/id_yubikey follows whichever key is plugged in, so ssh and git signing
# keep working with either key without touching any config.
install_udev_hook() {
  step "Installing the udev hook that tracks the plugged-in key"

  sudo tee "$link_script" >/dev/null <<EOF
#!/bin/bash
# Point ~/.ssh/id_yubikey at the serial-specific key file of whichever YubiKey
# is currently plugged in. Driven by $udev_rules.
set -euo pipefail

user=$USER
home=$HOME
link=\$home/.ssh/id_yubikey

case "\${1:-}" in
add)
  serial=\$(/usr/bin/ykman info 2>/dev/null | /usr/bin/sed -n 's/^Serial number:[[:space:]]*//p') || true
  [ -z "\$serial" ] && exit 0

  priv=\$home/.ssh/id_yubikey_\$serial
  [ -f "\$priv" ] || exit 0

  ln -sf "\$priv" "\$link"
  ln -sf "\$priv.pub" "\$link.pub"
  chown -h "\$user:\$user" "\$link" "\$link.pub"
  ;;
remove)
  rm -f "\$link" "\$link.pub"
  ;;
esac
EOF
  sudo chmod +x "$link_script"

  sudo tee "$udev_rules" >/dev/null <<EOF
# Yubico vendor ID 1050. ENV{} not ATTR{} so the match still works on remove,
# where sysfs is already gone but the udev database still has the properties.
ACTION=="add",    SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="1050", RUN+="$link_script add"
ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="1050", RUN+="$link_script remove"
EOF
  sudo udevadm control --reload
}

generate_ssh_key() {
  local key
  key=$(key_file "$1")

  if [[ -f $key ]]; then
    echo "    SSH key for $1 already exists"
  else
    # Resident so the key can be recovered onto another machine with
    # `ssh-keygen -K`. Asks for the FIDO2 PIN, then a touch.
    ssh-keygen -t ed25519-sk -O resident -f "$key"
  fi
}

# Touch instead of a password; if no key answers, PAM falls through to the
# normal password prompt, so a lost key never locks you out.
register_main_key() {
  step "Registering the main key for sudo and polkit"
  omarchy-setup-security-fido2
}

# pam_u2f keeps every device of a user on one line, ":" separated, so the
# backup is appended to the existing line rather than written as a new one.
register_backup_key() {
  step "Registering the backup key for sudo and polkit"

  if [[ $(awk -F: 'NR == 1 { print NF - 1 }' "$authfile") -ge 2 ]]; then
    echo "    A second key is already registered in $authfile"
    return
  fi

  echo "    Touch the backup key when it lights up..."
  local entry
  entry=$(pamu2fcfg -n)
  sudo sed -i "1s|\$|:${entry#:}|" "$authfile"
}

configure_ssh() {
  step "Pointing ssh at the key"

  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  # A symlink here is a home-manager leftover that dies with /nix, so replace it
  # even while it still resolves to the right content.
  if [[ ! -L ~/.ssh/config ]] && rg -q '^\s*IdentityFile ~/.ssh/id_yubikey$' ~/.ssh/config 2>/dev/null; then
    return
  fi

  rm -f ~/.ssh/config
  cat >~/.ssh/config <<'EOF'
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_yubikey
EOF
  chmod 600 ~/.ssh/config
}

enable_touch_notifications() {
  step "Enabling the touch notification service"

  mkdir -p "$(dirname "$touch_unit")"
  rm -f "$touch_unit" # may be a dangling home-manager symlink
  cat >"$touch_unit" <<'EOF'
[Unit]
Description=Desktop notification when the YubiKey is waiting for a touch
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/yubikey-touch-detector -libnotify

[Install]
WantedBy=graphical-session.target
EOF
  systemctl --user daemon-reload
  systemctl --user enable --now yubikey-touch-detector.service
}

main() {
  install_packages
  install_udev_hook
  configure_ssh
  enable_touch_notifications

  step "Enrolling the main key"
  local main_serial backup_serial
  main_serial=$(wait_for_key "MAIN")
  generate_ssh_key "$main_serial"
  register_main_key

  step "Enrolling the backup key"
  echo "    Unplug the main key first, keep the backup somewhere else afterwards."
  backup_serial=$(wait_for_key "BACKUP" "$main_serial")
  generate_ssh_key "$backup_serial"
  register_backup_key

  step "Enrolled both keys. Plug the main one back in."
  echo "    Then register them with GitHub: $(dirname "$0")/setup-github-keys.sh"
}

main "$@"
