# dotfiles/bash/aliases.sh
# sourced by both .zshrc and .bashrc, so keep it bash compatible

alias dotfiles="$DOTFILES/bootstrap.sh"
alias _="sudo"
alias untar="tar -zxvf "
alias reload="exec $SHELL"

# paths and dirs
alias ..='cd ..'
alias ....='cd ../..'
alias cd..='cd ..'
alias dirs="dirs -v"                  # default to vert, use -l for list
alias l="ls -l"

# function-type aliases
alias publicip="curl icanhazip.com"

# default flags for programs
alias df="df -h"
alias ln="ln -v"
alias rsync="rsync -hP --exclude-from=$HOME/.cvsignore"
alias wget="wget --no-check-certificate"

# tmux
alias remux="if tmux has 2>/dev/null; then tmux attach; else tmux new $SHELL; fi"
alias demux="tmux detach"

# quick edits
alias evars="e $BASH_DOTFILES/vars.sh"
alias epaths="e $BASH_DOTFILES/paths.sh"
alias ealiases="e $BASH_DOTFILES/aliases.sh"
alias efunctions="e $BASH_DOTFILES/functions.sh"
alias evimrc="e ~/.vimrc"
alias egvimrc="e ~/.gvimrc"
alias ebashrc="e ~/.bashrc"
alias elbashrc="e ~/.bashrc.local"

# probably don't need this with the ghost gem
alias ehosts="e /etc/hosts"

# php
alias ephpini="e $PHP_INI"

# server
alias rapache="sudo apachectl -k restart"
alias pyserve="python -m SimpleHTTPServer"

# apache
alias apacheerrors="tail /var/log/apache2/error_log"

##
# os specific
case "$OSTYPE" in
  darwin*)  source "$BASH_DOTFILES/aliases-osx.sh"
            ;;
  linux*)   source "$BASH_DOTFILES/aliases-linux.sh"
            ;;
esac