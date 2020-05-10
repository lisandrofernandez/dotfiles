#
# Aliases, functions and configurations
#


export VISUAL=vim
export EDITOR="$VISUAL"


# cp aliases
alias cp='cp -i' # prompt before overwrite

# mv aliases
alias mv='mv -i' # prompt before overwrite

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# grep aliases
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# rsync aliases
alias rsync='rsync -h' # output numbers in a human-readable format

# VIM with no plugins and no .vimrc
alias vimplain='vim -u NONE'

# xclip aliases
alias xcopy='xclip -selection clipboard' # copy to clipboard
alias xpaste='xclip -selection clipboard -o' # paste from clipboard

# pacman aliases
alias pacu='sudo pacman -Syyu' # refresh the package database and update
alias pacr='sudo pacman -Rnsu' # remove a package and its no longer required dependencies
alias pacol='pacman -Qdt' # list orphans
alias pacor='pacr $(pacman -Qdtq)' # remove orphans

# yay aliases
alias yayu='yay -Syu'

# make Midnight Commander exit to its current directory
alias mc='. /usr/lib/mc/mc-wrapper.sh'

# make ranger exit to its current directory
alias ranger='ranger-cd'


# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases
# enable history appending instead of overwriting
shopt -s histappend


# cd smart complete only in directories
complete -d cd
# enable auto-complete after sudo and man
complete -cf sudo
complete -cf man


if [ -f /usr/share/git/completion/git-completion.bash ]; then
  . /usr/share/git/completion/git-completion.bash
fi

#if [ -f /usr/share/git/git-prompt.sh ]; then
#  . /usr/share/git/git-prompt.sh
#  export GIT_PS1_SHOWCOLORHINTS=1
#  export GIT_PS1_SHOWDIRTYSTATE=1
#  export GIT_PS1_SHOWSTASHSTATE=1
#  export GIT_PS1_SHOWUNTRACKEDFILES=1
#  export GIT_PS1_SHOWUPSTREAM="verbose"
#  PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \w\[\033[01;32m\]]\[\033[01;31m\]$(__git_ps1)\[\033[01;32m\] \$\n »\[\033[00m\] '
#else
#  PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\n »\[\033[00m\] '
#fi


# fzf
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_OPTS='--reverse'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # requires fd (https://github.com/sharkdp/fd)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger="${1:-ranger}"
    test -z "$1" || shift
    "$ranger" --choosedir="$tempfile" "${@:-$(pwd)}"
    returnvalue=$?
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
    return $returnvalue
}
