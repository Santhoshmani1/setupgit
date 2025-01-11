#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Define key-value pairs for editors using an associative array
declare -A editors=( 
  ["Atom"]="atom --wait"
  ["BBEdit (macOS)"]="bbedit -w"
  ["Emacs"]="emacs"
  ["Gedit (Linux)"]="gedit --wait --new-window"
  ["Gvim (Windows)"]="'C:\Program Files\Vim\vim72\gvim.exe' --nofork '%*'"
  ["Helix"]="hx"
  ["Kate (Linux)"]="kate --block"
  ["Nano"]="nano -w"
  ["Neovim"]="nvim"
  ["Notepad (Windows)"]="notepad"
  ["Notepad++ (Windows)"]="'C:\Program Files\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
  ["Scratch (Linux)"]="scratch-text-editor"
  ["Sublime Text (macOS)"]="/Applications/Sublime\\ Text.app/Contents/SharedSupport/bin/subl --new-window --wait"
  ["Sublime Text (Windows)"]="'C:\Program Files\Sublime Text 3\sublime_text.exe' -w"
  ["TextEdit (macOS)"]="open --wait-apps --new -e"
  ["Textmate"]="mate -w"
  ["Textpad (Windows)"]="'C:\Program Files\TextPad 5\TextPad.exe' -m"
  ["UltraEdit (Windows)"]="Uedit32"
  ["Vim"]="vim --nofork"
  ["Visual Studio Code"]="code --wait"
  ["VSCodium (Open Source VSCode)"]="codium --wait"
  ["WordPad (Windows)"]="'C:\Program Files\Windows NT\Accessories\wordpad.exe'"
  ["Xi"]="xi --wait"
)

# Prompt for username
echo -e "${CYAN}Enter Username:${NC}"
read username

# Prompt for email address
echo -e "${CYAN}Enter Email Address:${NC}"
read email_address

# Display editor options in two alphabetically sorted columns
echo -e "${GREEN}Select your favorite editor by entering the corresponding number:${NC}"
sorted_editors=($(for editor_name in "${!editors[@]}"; do echo "$editor_name"; done | sort))
i=1
declare -A editor_keys

# Calculate column widths for alignment
left_column_width=$(for editor_name in "${sorted_editors[@]}"; do echo "${#editor_name}"; done | sort -nr | head -1)
((left_column_width+=4)) # Add padding

# Display editors in two columns
for editor_name in "${sorted_editors[@]}"; do
  printf "  ${YELLOW}%2d.${NC} %-*s" $i $left_column_width "$editor_name"
  editor_keys[$i]="$editor_name"
  ((i++))
  # Print a new line after every two entries
  if ((i % 2 == 1)); then
    echo
  fi
done
# Ensure a trailing newline if the last row is incomplete
if ((i % 2 == 0)); then
  echo
fi

# Read user input
read -p "$(echo -e "${CYAN}Enter your choice:${NC}") " editor_choice

# Validate choice and set the editor
if [[ ${editor_keys[$editor_choice]} ]]; then
  selected_editor="${editor_keys[$editor_choice]}"
  editor="${editors[$selected_editor]}"
else
  echo -e "${RED}Invalid choice. Defaulting to Nano.${NC}"
  editor="nano -w"
fi

# Configure Git user details
git config --global user.name "$username"
git config --global user.email "$email_address"

# Configure Git editor
git config --global core.editor "$editor"

# Auto-correct for mistyped commands
git config --global help.autocorrect 1

# Default branch for new repositories
git config --global init.defaultBranch main

# Default behavior for pull
git config --global pull.rebase false

# Git aliases
# General
git config --global alias.cl "clone"
git config --global alias.st "status"

# Branches
git config --global alias.newbr "switch -c"    # Create a new branch
git config --global alias.rmbr "branch -d"     # Delete a branch
git config --global alias.rmfbr "branch -D"    # Permanently delete a branch
git config --global alias.lastbr "switch -"    # Switch to the previously checked-out branch

# Commits
git config --global alias.last "log -1 HEAD"   # View the last commit
git config --global alias.glog "log --oneline --decorate --graph" # Great log view
git config --global alias.fixlc "commit --amend" # Amend the last commit

# GPG signing commits and tags
git config --global commit.gpgsign true
git config --global tag.gpgsign true

# Completion message
echo -e "${GREEN}Git configuration is complete!${NC}"
echo -e "${BLUE}Use 'git config -l' to view your Git configuration.${NC}"

