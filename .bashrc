##########################################
# Edvinas Jurevicius aka zatan ~/.bashrc #
##########################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth:ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

function vim(){
    if [ -f "$VIRTUAL_ENV/bin/python3.5" ] || [ -f "$VIRTUAL_ENV/bin/python3.6" ]; then
        vim.athena "$@"
    else
        /usr/bin/vim "$@"
    fi
}

alias la='ls -A'
alias l='ls -CF'
alias ll='ls -l'
# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'

alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack-grep --color-filename=yellow --color-lineno=green --color-match=red --ignore-dir=requirements --ignore-dir=bower_components --ignore-dir=migrations --ignore-dir=.git --ignore-dir=media --ignore-dir=reports --ignore-dir=staticfiles --ignore-dir=locale --ignore-dir=whoosh --ignore-dir=htmlcov --ignore-file="match:.coverage" --ignore-file="match:coverage.xml" --ignore-dir=xapian --ignore-dir=static --ignore-dir=docs --ignore-dir=.tox --ignore-file=is:requirements.txt --ignore-file=ext:sql --ignore-file=ext:dump --ignore-file=is:pylint.report --type-set=DUMB="*.pyc" --nobreak --noenv -i -Q'

# Password generator
alias passwdgen='dd if=/dev/random bs=16 count=1 2>/dev/null | base64 | sed 's/=//g''
# SpeedTest

alias speedtest='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

alias shell='./manage.py shell_plus --settings=settings.local'

alias collectstatic='./manage.py collectstatic --settings=settings.local'

# Alias to translate google
# https://github.com/soimort/google-translate-cli
alias tra="trans en:lt"

# Use cat with colors pyhton-pygmentize should be installed.
alias catc='pygmentize -g '

# Delete all pyc
alias removepyc='find . -name "*.pyc" -exec rm -rf {} \; && find -name "__pycache__" -prune -exec rm -rf {} \;'

# Run SimpleHttpServer
server_http() {
    if [ -z $1 ]; then
        python -m SimpleHTTPServer 8070;
    else
        python -m SimpleHTTPServer $1;
    fi
}


# Display sizes
alias duh='du -h|sort -hr'

# Switch to www-data user
alias www-data='sudo su - www-data'

# Switch to any user
alias suweb='sudo su - '

# Heroku backup
alias heroku_backup='curl -o latest.dump `heroku pg:backups public-url`'

# Stats
alias stats='dstat --cpu --io --mem --net --load --fs --vm --disk-util --disk-tps --freespace --swap --top-io --top-bio-adv'

# Remove PYC
alias remove-pyc='find . -name "*.pyc" -exec rm -rf {} \;'

# Deploy changes
alias fab='/var/envs/fabfile/bin/fab'

# Copy something pbcopy < ~/.ssh/id_rsa.pub or curl -Ss icanhazip.com | pbcopy
alias pbcopy='xclip -selection clipboard'

# Paste something pbpaste > main.go, append pbpaste >> main.go  or convert to base64 pbpaste | base64
alias pbpaste='xclip -selection clipboard -o'

###########
# EXPORTS #
###########

# Exporting editor vim
export EDITOR=vim

# Virtualenvwrapper Home dir
export WORKON_HOME=/var/envs/

# Projects home
export PROJECT_HOME=/var/www

export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--python=/usr/bin/python3.5"
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

# To work with git display branch status for Ubuntu 12.04 or less
# /etc/bash_completion.d/git
source /etc/bash_completion.d/git-prompt

color_prompt=yes
GIT_PS1_SHOWDIRTYSTATE='1'
GIT_PS1_SHOWSTASHSTATE='1'
GIT_PS1_SHOWUNTRACKEDFILES='1'
GIT_PS1_SHOWCOLORHINTS='1'
GIT_PS1_SHOWCOLORHINTS='1'
GIT_PS1_SHOWUPSTREAM="auto"


# Export display if it's not set.
if ! [ "$DISPLAY" ]
then
    export export DISPLAY=localhost:0.0
fi


# Function to open google-search from terminal with passed argument.
function chrome-search(){
 google-chrome http://www.google.co.uk/search?q="$1"
}

function git-remove-cache(){
    git rm -r --cached .
    git add .
}

# Default django settings moduke
export DJANGO_SETTINGS_MODULE=''


function suweb(){
    sudo -u "$1" -i /home/edvinas/switcher.sh
}


function runserver(){
    if [ "$1" ]; then
        ./manage.py runserver $1
    else
        ./manage.py runserver 127.0.0.1:8000
    fi

}

# Get backup from server
function get_backup(){
    ssh -C $1 sudo -u postgres pg_dump --no-owner $2 > $2.dump
}

function re_create_database(){
    dropdb --if-exists $1
    createdb $1
    psql $1 < $2
}


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:$HOME/bins"

RED_BOLD='\[\033[1;31m\]'
WHITE_BOLD='\[\033[1;37m\]'
YELLOW_BOLD='\[\033[1;33m\]'
WHITE='\[\033[0;37m\]'
GREEN_BOLD='\[\033[38;5;28m\]'
GREY_COLOR='\[\033[00m\]'
CYAN='\[\033[0;36m\]'
LIGHT_GREEN='\[\033[38;5;119m\]'
LIGHT_RED='\[\033[38;5;210m\]'
CYAN='\[\e[0;36m\]'

function set_prompt() {

    # Set virtualenv automatically.
    if [ -e "/var/envs" ]; then
        current_directory=$(pwd -P)
        regex='(\/var\/www\/(\w+))'

        if [[ $current_directory =~ $regex ]]
        then
            project_name=${BASH_REMATCH[2]}
        else
            project_name=''
        fi

        if [ $project_name ]
        then
            virtualenv_directory='/var/envs/'$project_name

            if [[ -d $virtualenv_directory ]]; then

                # Check to see if already activated to avoid redundant activating
                if [ "$VIRTUAL_ENV" != virtualenv_directory ]; then
                    _VENV_NAME=$(basename `pwd`)
                    source $virtualenv_directory/bin/activate > /dev/null 2>&1
                    source $virtualenv_directory/bin/postactivate > /dev/null 2>&1
                fi
            fi
        fi
    fi


    # Virtualenv
    if [[ $VIRTUAL_ENV != "" ]]
    then
        venv="${WHITE}(${VIRTUAL_ENV##*/}) "
    else
        venv=''
    fi

    if [[ $NODE_VIRTUAL_ENV != "" ]]
    then
        nenv="${WHITE}(${NODE_VIRTUAL_ENV##*/}) "
    else
        nenv=''
    fi

    # Branch colour
    gitcheck_branch="$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "yes"; else echo "no"; fi)"
    if [ $gitcheck_branch == "yes" ];
        then
            # If we are in a git repo, then check to see if there are uncommitted files
            gitcheck_status="$(git status | grep "nothing to commit" > /dev/null 2>&1; if [ $? -eq 0 ]; then echo "clean"; else echo "unclean"; fi)"

    if [ $gitcheck_status == "clean" ];
        then
            # If there are no uncommitted files, then set the color of the git branch name to green
            git_prompt=${LIGHT_GREEN}'$(__git_ps1)'
        else
            # If there are uncommitted files, set it to red.
            # git_prompt='\[\033[0;37m\]$(__git_ps1)'
            git_prompt=${LIGHT_RED}'$(__git_ps1)'
        fi
    else
            # If we're not in a git repo, then display nothing
        git_prompt=""
    fi


    user="${RED_BOLD}\u ${WHITE_BOLD}at "
    hostname="${RED_BOLD}\h ${WHITE_BOLD}in "
    current_dir="${GREEN_BOLD}\w"
    prompt="\n${CYAN}└─${WHITE_BOLD}[\A]$ ${GREY_COLOR}"
    title='\[\033]0;${PWD/$HOME/~}\007\]'
    VTE_PWD_THING="$(__vte_osc7)"
    export PS1="${title}${CYAN}┌─${venv}${nenv}${user}${hostname}${current_dir}${git_prompt}${prompt}${VTE_PWD_THING}"

}

# Disable virtualenv prompt as I set myself.
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Share your immediate bash history across multiple sessions
shopt -s histappend

GREP_OPTIONS='--exclude-dir=.git --exclude-dir=node_modules --exclude-dir=logs --exclude-dir=xapian --exclude-dir=media --exclude-dir=whoosh --exclude=*.pyc --exclude=*.swp'
alias grep="/bin/grep $GREP_OPTIONS"


# Install https://github.com/Anthony25/gnome-terminal-colors-solarized
eval `dircolors ~/.dir_colors/dircolors`

export NVM_DIR="/home/edvinas/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# Color Terminal Man page.
man() {
    LESS_TERMCAP_mb=$'\e'"[1;31m" \
    LESS_TERMCAP_md=$'\e'"[1;31m" \
    LESS_TERMCAP_me=$'\e'"[0m" \
    LESS_TERMCAP_se=$'\e'"[0m" \
    LESS_TERMCAP_so=$'\e'"[1;44;33m" \
    LESS_TERMCAP_ue=$'\e'"[0m" \
    LESS_TERMCAP_us=$'\e'"[1;32m" \
    command man "$@"
}

if [ -f "$HOME/bins/django_bash_completion" ]
    then
       . "$HOME/bins/django_bash_completion";
fi

# Enables i-search for reverse-search
stty -ixon

# The current directory nevert reported to VTE terminix source vte.sh if it
# doesn't exist ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte-2.91.sh
fi


# Override this one from /etc/profile.d/vte-2.91.sh to escape colours bevause it causes overwriting.
__vte_osc7 () {
  printf "\[\033]7;file://%s%s\007\]" "${HOSTNAME:-}" "$(__vte_urlencode "${PWD}")"
}

export PROMPT_COMMAND=set_prompt
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
