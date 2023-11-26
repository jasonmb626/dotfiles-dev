# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"

# Source manjaro-zsh-configuration
if [[ -e ~/.config/zsh/manjaro-zsh-config ]]; then
  source ~/.config/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e ~/.config/zsh/manjaro-zsh-prompt ]]; then
  source ~/.config/zsh/manjaro-zsh-prompt
fi

# Created by newuser for 5.8
source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -e ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

fpath=(~/.config/zsh/completion $fpath)
autoload -Uz compinit && compinit -i

#tab-completion menu
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

HISTFILE="$HOME/.config/zsh/zsh_history"
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt interactivecomments

alias ls="ls --color=auto"
alias dcr='docker compose run --rm --build'
