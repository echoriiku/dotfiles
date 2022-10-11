# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end

# The following snippet is meant to be used like this in your fish config:
#
# if status is-interactive
#     # Configure auto-attach/exit to your likings (default is off).
    # set ZELLIJ_AUTO_ATTACH true
    # set ZELLIJ_AUTO_EXIT true
    # eval (zellij setup --generate-auto-start fish | string collect)
# end
# if not set -q ZELLIJ
#     if test "$ZELLIJ_AUTO_ATTACH" = "true"
#         zellij attach -c
#     else
#         zellij
#     end

#     if test "$ZELLIJ_AUTO_EXIT" = "true"
#         kill $fish_pid
#     end
# end


zoxide init fish | source
starship init fish | source
set fish_greeting
set EDITOR "hx"
set BROWSER "firefox"
set fzf_preview_dir_cmd "lsd -a"
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
    abbr -a ls                        'lsd --group-directories-first'
    abbr -a lsa                       'lsd --group-directories-first -a'
    abbr -a ll                        'lsd --group-directories-first -l'
    abbr -a lla                       'lsd --group-directories-first -la'
    abbr -a rm                        'trash'
    abbr -a q                         'exit'
    abbr -a tm                        'tmux'
    abbr -a zl                        'zellij'
    abbr -a xp                        'xplr'
    abbr -a cargup                    'cargo install-update -a'


#autostart fetch script
cutefetch $(printf '\t-k\n-b\n-p' | shuf -n 1) $(shuf -i 1-13 -n 1)

