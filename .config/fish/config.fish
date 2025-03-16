if status is-interactive
    # Commands to run in interactive sessions can go here
end

# disable fish greeting message
set -g fish_greeting

set -gx VISUAL vim
set -gx EDITOR $VISUAL

#fish_add_path -g ~/.local/bin

alias l='ls'
alias lla='ls -lA'

# fuzzy cd
alias c='cd $(fd -td -H -d1 | fzf)'


# tere
# https://github.com/mgunyho/tere
function tere
    set --local custom_args --gap-search-anywhere --filter-search
    set --local result (command tere $argv $custom_args)
    [ -n "$result" ] && cd -- "$result"
end

# tere for keybinding
function __tere
    tere
    commandline -f repaint
end

# keybindings
function fish_user_key_bindings
    bind \ec __tere
end
