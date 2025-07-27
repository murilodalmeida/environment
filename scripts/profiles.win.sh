#!/bin/bash

# --- Generate SSH Key if not exists ---
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo "Generating new SSH key (ed25519)..."
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -f "$SSH_KEY" -C "git"
fi

# --- .bashrc content ---
read -r -d '' bashrc_content <<'EOF'
alias vs='/c/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/devenv.exe *.sln &'
alias gits='git status'
alias gita='git add .'
alias gitka='gitk --all &'
alias dps="wsl docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dpsa="wsl docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias pn="pnpm"
alias cls="clear"
alias dev="cd ~/git"

# SSH Agent Automation
env=~/.ssh/agent.env
agent_load_env () {
    test -f "$env" && . "$env" >| /dev/null
}
agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null
}
agent_load_env
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/id_ed25519
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/id_ed25519
fi
unset env
# END SSH Agent Automation
EOF

# --- .gitconfig content ---
read -r -d '' gitconfig_content <<'EOF'
[user]
	name = Murilo Almeida
	email = murilo@fwkslabs.com
[alias]
	ci = commit
	co = checkout
EOF

# --- .wslconfig content ---
read -r -d '' wslconfig_content <<'EOF'
[wsl2]
memory=8GB
processors=4
swap=2GB
EOF

# --- Write files if they don't exist ---
[[ ! -f ~/.bashrc ]] && echo "$bashrc_content" > ~/.bashrc && echo "~/.bashrc created."
[[ ! -f ~/.gitconfig ]] && echo "$gitconfig_content" > ~/.gitconfig && echo "~/.gitconfig created."
[[ ! -f ~/.wslconfig ]] && echo "$wslconfig_content" > ~/.wslconfig && echo "~/.wslconfig created."
