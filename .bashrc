# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Load optional machine/user-specific config files
[[ -f ~/.bashrc.work ]] && source ~/.bashrc.work
[[ -f ~/.bashrc.personal ]] && source ~/.bashrc.personal
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/pinto/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
