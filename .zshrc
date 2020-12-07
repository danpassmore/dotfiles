# Created by newuser for 5.0.2
#!/bin/zsh

# Completion
autoload -U compinit
compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Correction
setopt correctall

# Prompt
autoload -U promptinit
promptinit
#prompt gentoo

export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space



# ---- Added by dpassmor ---- 

PS1=$'%{\e]0;%d\a%}\n%F{green}%n@%m %F{yellow}%d%f\n%# '

# source common aliases
source $HOME/.shell_aliases

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

#python settings
export PYTHONBIN=/pkg/qct/software/ubuntu/python/2.7.5/bin
export PYTHONPATH=/prj/qct/asw/qctss/linux/bin

# use zsh-autosuggestions plugin from https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#use zsh-history-substring-search from https://github.com/zsh-users/zsh-history-substring-search 
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------  needs to be at the end of this file --------------------
# Enable syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- End Added by dpassmor ---- 
