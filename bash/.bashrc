# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
set -o vi

##-----------------------------------------------------
## synth-shell-greeter.sh
if [ -f /home/jason/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/jason/.config/synth-shell/synth-shell-greeter.sh
fi

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/jason/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/jason/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## better-ls
#if [ -f /home/jason/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then
#	source /home/jason/.config/synth-shell/better-ls.sh
#fi

##-----------------------------------------------------
## alias
if [ -f /home/jason/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/jason/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /home/jason/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/jason/.config/synth-shell/better-history.sh
fi
#Aliases

#Git
alias gP="git push"
alias gp="git pull"
alias gc="git commit -m"
alias ga="git add ."
alias gadog='PAGER="less -F -X" git adog'
alias glog='PAGER="less -F -X" git log'

#Tmux
alias tkill="tmux kill-session -t"
alias tlist="tmux list-sessions"
alias tattach="tmux attach"

#Docker
alias dcr="docker compose run --rm --build --service-ports"

#general
alias vim="nvim"
