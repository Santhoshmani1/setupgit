# Setupgit

This project provides a Bash script to simplify the process of configuring Git. It guides users through setting up Git with personalized details, selecting a preferred text editor, and applying useful aliases and settings for an enhanced Git experience.

## Features
- User-Friendly Prompts: Easily input your Git username and email address.
- Editor Selection: Choose your favorite text editor from a wide range of options, displayed in an organized, two-column format.
- Automatic Git Configuration: 
    - Establishes helpful Git aliases for common commands.
    - Lets the default branch name to main.
    - Enables autocorrection for mistyped commands.
    - Ensures commits and tags are signed with GPG by default.

## Installation

1. Clone the repository
git clone https://github.com/Santhoshmani1/setupgit.git

2. Make sure git is avaialable on your system 
```bash
git --version
```
- if this throws an error, you can download the latest version of git for your operating system at https://git-scm.com/downloads


3. verify the script and make any modifications if required suitable to your choice and run the script
```bash
bash setupgit.sh
```


## Git Aliases supported

### General
git cl → git clone
git st → git status

### Branches
git newbr → Create a new branch (git switch -c)
git rmbr → Delete a branch (git branch -d)
git rmfbr → Force delete a branch (git branch -D)
git lastbr → Switch to the previously checked-out branch (git switch -)

### Commits
git last → View the last commit (git log -1 HEAD)
git glog → Display a graphical commit log (git log --oneline --decorate --graph)
git fixlc → Amend the last commit (git commit --amend)


## Resources

> If you want to learn more about git, checkout progit https://git-scm.com/book/en/v2  It's amazing.

## LICENSE
MIT
