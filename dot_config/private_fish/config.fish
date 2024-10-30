if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_greeting ""


# Abbreviations
abbr -a ls 'exa --icons --group-directories-first'
abbr -a lst 'exa --icons --group-directories-first -T'
abbr -a lsa 'exa --icons --group-directories-first -a'
abbr -a ll 'exa --icons --group-directories-first -lh'
abbr -a lla 'exa --icons --group-directories-first -lha'
abbr -a q exit
abbr -a r ranger
abbr -a tm tmux
abbr -a zl zellij
abbr -a ff fastfetch
abbr -a zlc 'zellij -l compact'

# starship init fish | source
