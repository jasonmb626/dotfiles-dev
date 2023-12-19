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

XDG_DATA_DIR=$(echo $XDG_DATA_DIRS | awk -f: '{print $1}')

# Lines configured by zsh-newuser-install
HISTFILE=$XDG_DATA_DIR/zsh/.histfile
HISTSIZE=11000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
