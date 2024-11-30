alias code="code-insiders"

# Colorful Bash Prompt
# Set the prompt to include username, hostname, current directory, and git branch
PS1='\[\e[1;36m\]root@arch \[\e[0;37m\]\w\[\e[0m\]\$ '
# Enable Git Branch in Prompt
# Install git-prompt.sh if not already present
if [ -f /usr/share/git/git-prompt.sh ]; then
    . /usr/share/git/git-prompt.sh
fi

# Set colors for ls command
alias ls='ls --color=auto'
alias ll='ls -la'
alias l='ls -l'

# Customizing terminal appearance
# Enable colorful man pages
export MANPAGER="less -R"
# Use vim as the default editor
export EDITOR='nvim'
