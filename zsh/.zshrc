#Set the directory we want to store antidote and plugins
#First part of value does parameter expansion. Second part is done if the first one has value null. Third appends stuff to the end. 
ANTIDOTE_HOME="${HOME}/.config/antidote/antidote.git"


#Download antidote, if its not there yet
#This makes sure that this zshrc carries over to any new machine we run this on
if [ ! -d "$ANTIDOTE_HOME" ]; then 
  mkdir -p "$(dirname $ANTIDOTE_HOME)"
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME"
fi

#Source/Load antidote
source "${ANTIDOTE_HOME}/antidote.zsh"
#Initialize plugins statically for antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
antidote load
autoload -U compinit && compinit

#Shell integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

#Aliases
alias v='nvim'
alias c='clear'
alias ..='cd ..'
alias ....='cd ../..'
alias lg='lazygit'
#ls aliases for file exploring
alias ls='eza -lh --group-directories-last --icons --git --color-scale'
alias ld='eza -lhD --icons --git --color-scale'
alias lsa='eza -alh --group-directories-last --icons --git --color-scale'
alias tree='eza -T --icons'
alias atree='eza -aT --icons'



#Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Historyuff
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups

#Completion Styling 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


