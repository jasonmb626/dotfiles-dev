# .bashrc

if [[ -x ~/.bin/tpm/scripts/install_plugins.sh ]]; then
    ~/.bin/tpm/scripts/install_plugins.sh | grep -v 'Already installed'
fi

if [[ "$(whoami)" == "app" ]]; then #assume we're in Docker
  if [[ -f /home/app/.config/nvim/lua/config/options.lua ]]; then
    sed -i 's^--vim.g.python3_host_prog = "/home/app/.venvs/app/bin/python"^vim.g.python3_host_prog = "/home/app/.venvs/app/bin/python"^' /home/app/.config/nvim/lua/config/options.lua
  fi
  if [[ -x /usr/sbin/sshd && -f /home/app/.wantdockerssh ]]; then
    SSHD_PID=$(ps aux | grep sshd | grep -v grep | awk '{print $2}')
    if [[ -z $SSHD_PID ]]; then
      exec sudo /usr/sbin/sshd -D -e "$@" 2>/dev/null &
    fi
  fi
fi

#Start tmux automatically, 
if [ -z "$TMUX" ]; then
  if [[ -f ~/.want_alt_tmux_prefix ]]; then
    #if alt file present change prefix (this is assuming we're running in Docker and have TMUX on our main machine and also within Docker)
    sed -i 's/set -g prefix C-a/set -g prefix C-x/' ~/.config/tmux/tmux.conf
    sed -i 's/bind-key C-a send-prefix/bind-key C-x send-prefix/' ~/.config/tmux/tmux.conf
  fi
  tmux -u attach -t TMUX || tmux -u new -s TMUX
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/.bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/.bin:$PATH"
fi
PATH=$HOME/.dotfiles/bin:$PATH
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

if [[ "$(whoami)" == "app" ]]; then #assume we're in Docker
  if [[ -f /home/app/.venvs/app/bin/activate ]]; then
    source /home/app/.venvs/app/bin/activate
  fi
fi

if [[ -x $(which oh-my-posh) ]]; then
    if [[ -f ~/.themes/dracula.omp.json ]]; then
        eval "$(oh-my-posh init bash --config ~/.themes/dracula.omp.json)"
    else
        eval "$(oh-my-posh init bash)"
    fi
fi
