#Start tmux automatically
if [ -z "$TMUX" ]; then
   tmux attach -t TMUX || tmux new -s TMUX
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh//.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load local rcs if they exist
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc" 
[ -f "${ZDOTDIR}/optionrc" ] && source "${ZDOTDIR}/optionrc" 
[ -f "${ZDOTDIR}/pluginrc" ] && source "${ZDOTDIR}/pluginrc"

# tab completion
fpath=(~/.local/share/zsh/completions $fpath)                                     # Add to function path (used for autocompletion)
zstyle ':completion:*:*:docker:*' option-stacking yes                             # Add stacking options so can do autocomplete even after -it flags
zstyle ':completion:*:*:docker-*:*' option-stacking yes                           # Add stacking options so can do autocomplete even after -it flags
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)--color=auto}"                        # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                                                # automatically find new executables in path
zstyle ':completion:*' menu select                                                # Highlight menu selection

# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/.histfile
HISTSIZE=11000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.config/zsh/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

bindkey -M viins "^[[A" history-substring-search-up
bindkey -M viins "^[[B" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

PATH="$PATH:/home/jason/.local/bin"
mkdir -p /home/jason/.local/share/tmux/plugins/
if [[ "$(ls -1 /home/jason/.local/share/tmux/plugins/ | grep -v tpm | wc -l )" -eq 0 ]]; then
    if [[ -x /home/jason/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh && \
      "$(which tmux)" != "" ]]; then
      /home/jason/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh
      tmux source ~/.config/tmux/tmux.conf
    fi
fi

if [[ ! -x /home/jason/.local/share/nvim/lazy/nvim-treesitter/parser/markdown.so ]]; then
    if [[ -x /home/jason/.config/nvim/if_docker/auto_install_dependencies.sh && \
      "$(which nvim)" != "" ]]; then
        /home/jason/.config/nvim/if_docker/auto_install_dependencies.sh >/dev/null 2>&1
        echo "Neovim packages are installing in the background. Please wait before starting up neovim."
        echo "This usually happens only on a fresh install."
        echo "Sleeping 30 seconds."
        sleep 30
        PID=$(ps aux | grep 'nvim --headless -c TSInstall! markdown' | grep -v grep | awk '{print $2}')
        kill $PID
        echo "You may now start neovim. Additional LSPs, formatters, and linters may install on startup."
        echo "Once there is no longer feedback that new tools are installing, we recommend restarting neovim one more time."
    fi
fi
