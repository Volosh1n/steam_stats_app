# ~/.bashrc

PROMPT_COMMAND="history -a"
HISTFILE=$HOME/app/log/.bash_history

set -o emacs

shopt -s autocd
shopt -s cdspell
shopt -s globstar
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export HISTIGNORE=":#[0-9]*:&:ls:[bf]g:exit:[ ]*:ssh:history"
