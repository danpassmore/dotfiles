# User dependent .bashrc file

# If not running interactively, don't do anything
#[[ "$-" != *i* ]] && return

# Aliases
#
# Some people use a different file for aliases
 if [ -f "${HOME}/.shell_aliases" ]; then
   source "${HOME}/.shell_aliases"
 fi

export LS_COLORS="no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"

# Set the prompt
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '

# Perforce setting
export P4DIFF='nvim -d'

export PYTHONBIN=/pkg/qct/software/ubuntu/python/2.7.5/bin
export PYTHONPATH=/prj/qct/asw/qctss/linux/bin

export P4CONFIG=.p4config

#export DISPLAY="$(echo $SSH_CLIENT | awk '{print $1}'):0.0"

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

#setup fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
