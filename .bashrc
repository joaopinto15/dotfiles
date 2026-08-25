# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# /etc/omarchy.conf is written by omarchy-dev-link. When absent, force the
# package default instead of preserving a stale inherited dev-link value before
# we decide which rc file to source.
if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
else
  export OMARCHY_PATH=/usr/share/omarchy
fi
source "$OMARCHY_PATH/default/bash/rc"

# Reload bash
r() {
  source ~/.bashrc
}
# Neovim aliases
alias zed=zeditor
alias vim=nvim

# Development aliases
alias task='go-task' # task script language
alias y=yadm         # yadm dotfiles manager
alias k='kubectl'    # kubectl tool for kubernetes


# Search tools
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# f [pattern] - pick a file, open it
f() {
  local file
  file=$(fd --type f --hidden --exclude .git "${1:-}" |
    fzf --preview 'bat --style=numbers --color=always {}') && $EDITOR "$file"
}

# s <pattern> - pick a matching line, open the file there
s() {
  local hit
  hit=$(rg --line-number --no-heading --color=always --smart-case "$@" |
    fzf --ansi --delimiter : --nth 3.. \
      --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
      --preview-window '+{2}/2') || return
  # ponytail: +line assumes a vim-family $EDITOR, which is the omarchy default
  local file=${hit%%:*} rest=${hit#*:}
  $EDITOR "+${rest%%:*}" "$file"
}
