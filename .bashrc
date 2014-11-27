##########################################
# Edvinas Jurevicius aka zatan ~/.bashrc #
##########################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -lh --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
###########
# ALIASES #
########### 
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -l'
# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'
alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack-grep --color-filename=yellow --color-lineno=green --color-match=red --ignore-dir=static --ignore-dir=migrations --ignore-dir=.git --ignore-dir=media  --ignore-dir=whoosh --ignore-dir=xapian --ignore-file=is:requirements.txt --ignore-file=is:pylint.report --type-set=DUMB="*.pyc" --nobreak --noenv -i -Q'
# Password generator
alias passwdgen='dd if=/dev/random bs=16 count=1 2>/dev/null | base64 | sed 's/=//g''
# SpeedTest
alias speedtest='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias shell='./manage.py shell_plus --settings=settings.local'
alias runserver='./manage.py runserver 192.168.1.29:8000 --settings=settings.local'
alias collectstatic='./manage.py collectstatic --settings=settings.local'

# Alias to translate google
# https://github.com/soimort/google-translate-cli
alias tra="translate {en=lt}"

# Use cat with colors pyhton-pygmentize should be installed.
alias catc='pygmentize -g '

# Delete all pyc
alias removepyc='find . -name "*.pyc" -exec rm -rf {} \;'

# Run SimpleHttpServer
alias simpleserver='python -m SimpleHTTPServer 8070'

# Display sizes
alias doh='du -h|sort -hr'



###########
# EXPORTS #
###########
# Exporting editor vim
export EDITOR=vim
# Virtualenvwrapper Home dir
export WORKON_HOME=/var/envs/
# Projects home 
export PROJECT_HOME=/var/www
# Grep options
export GREP_OPTIONS='--exclude-dir=.git --exclude-dir=xapian --exclude-dir=media --exclude-dir=static --exclude-dir=whoosh --exclude=*.pyc --exclude=*.swp'
# Virtualenvwrapper bin directory
export VIRTUALENVWRAPPER_HOOK_DIR=/var/envs/bin
# To use 256 colors
export TERM=xterm-256color

# Enable bash completion       
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

###########
# SOURCES #
###########
# Source to be able to user viritualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh > /dev/null 2>&1 || true
# To work with git display branch status
source /etc/bash_completion.d/git-prompt

color_prompt=yes
GIT_PS1_SHOWDIRTYSTATE='1'
GIT_PS1_SHOWSTASHSTATE='1'
GIT_PS1_SHOWUNTRACKEDFILES='1'
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM="auto"

HOSTNAME=$(hostname)

PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\e[36mzatan\[\033[01;32m\] -> \[\033[0;37m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '

HOSTNAME=$(hostname)
echo $HOSTNAME
if [ $HOSTNAME != "edvinas-pc" ] && [ $HOSTNAME != "ed" ]; then
    # Bold for servers
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;31m\]\u@Linode742584\[\033[01;32m\]:\[\033[0;37m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '
fi
