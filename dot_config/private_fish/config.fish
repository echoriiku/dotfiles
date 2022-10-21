if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source
navi widget fish | source
starship init fish | source
set fish_greeting
set EDITOR "hx"
set BROWSER "firefox"
set PAGER "bat --color=always"
set fzf_preview_dir_cmd "exa -a"
export XDG_CONFIG_HOME=$HOME/.config

# FUNCTIONS

#backup
function backup --argument filename
    cp $filename $filename.bak
end

#restore
function restore --argument file
    mv $file (echo $file | sed s/.bak//)
end


#abbrs
    abbr -a bk                        'backup'
    abbr -a re                        'restore'
    abbr -a mc                        'mkdir-cd'
    abbr -a cat                       'bat'
    abbr -a dnfi                      'sudo dnf install'
    abbr -a dnfr                      'sudo dnf remove'
    abbr -a dnfs                      'dnf search'
    abbr -a dnfu                      'sudo dnf update'
    abbr -a flup                      'flatpak update'
    abbr -a gu                        'gitui'
    abbr -a lg                        'lazygit'
    abbr -a ls                        'exa --icons --group-directories-first'
    abbr -a lst                       'exa --icons --group-directories-first -T'
    abbr -a lsa                       'exa --icons --group-directories-first -a'
    abbr -a ll                        'exa --icons --group-directories-first -lh'
    abbr -a lla                       'exa --icons --group-directories-first -lha'
    abbr -a rm                        'trash'
    abbr -a q                         'exit'
    abbr -a r                         'ranger'
    abbr -a tm                        'tmux'
    abbr -a zl                        'zellij'
    abbr -a xp                        'xplr'
    abbr -a js                        'joshuto'
    abbr -a cargup                    'cargo install-update -a'
    abbr -a tarc                      'tar -cvf'
    abbr -a tard                      'tar -xvf'
    abbr -a tb                        'nc termbin.com 9999'
    abbr -a cha                       'chezmoi add'
    abbr -a chs                       'chezmoi status'
    abbr -a chc                       'chezmoi cd'
    abbr -a chd                       'chezmoi diff | delta'

#autostart fetch script
cutefetch $(printf '\t-k\n-b\n-p' | shuf -n 1) $(shuf -i 1-13 -n 1)

