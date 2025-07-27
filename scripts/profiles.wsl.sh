#!/bin/bash

rm -rf ~/git && ln -s /mnt/c/Users/Meow/git ~/git

# --- .bashrc content ---
read -r -d '' bashrc_content <<'EOF'
# Custom Aliases
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dpsa="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias cls="clear"
alias dev="cd ~/git"
EOF

# --- Append to ~/.bashrc ---
if ! grep -q "alias dps=" ~/.bashrc 2>/dev/null; then
    echo "$bashrc_content" >> ~/.bashrc
    echo "Custom aliases appended to ~/.bashrc."
fi
