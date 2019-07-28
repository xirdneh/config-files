#export WORKON_HOME=~/.virtualenvs
#source /usr/bin/virtualenvwrapper.sh
if [[ $OSTYPE == "linux-gnu" ]]; then
    export LS_OPTIONS='--color=auto'
fi

if [[ $OSTYPE == "linux-gnu" ]]; then
    source /usr/share/git/completion/git-prompt.sh 
    source /usr/share/git/completion/git-completion.bash 
else
    source /usr/local/etc/bash_completion.d/git-prompt.sh 
    source /usr/local/etc/bash_completion.d/git-completion.bash 
fi

# /etc/bash.bashrc
#
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
#shopt -s checkwinsize

# Enable history appending instead of overwriting.
#shopt -s histappend

# fortune is a simple program that displays a pseudorandom message
# from a database of quotations at logon and/or logout.
# If you wish to use it, please install "fortune-mod" from the
# official repositories, then uncomment the following line:

# [[ "$PS1" ]] && /usr/bin/fortune

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS. Try to use the external file
# first to take advantage of user additions. Use internal bash
# globbing instead of external grep binary.

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose git"
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWCOLORHINTS=1

set_prompt () {
    lastcmd=$?

    ## REGULAR COLORS
    if [ $(tput colors) -ne "256" ]; then
        Blue='\[\033[01;34m\]'
        White='\[\033[01;37m\]'
        Red='\[\033[01;31m\]'
        Green='\[\033[01;32m\]'
        Yellow='\[\033[01;33m\]'
        Orange='\[\033[01;37m\]' #Which is actually gray, look away.
    else
        ## 256 less intense colors.
        Blue='\[\033[38;5;27m\]'
        White='\[\033[01;37m\]'
        Red='\[\033[38;5;160m\]'
        RedBold='\[\033[1;38;5;160m\]'
        Green='\[\033[38;5;28m\]'
        GreenBold='\[\033[1;38;5;28m\]'
        Yellow='\[\033[38;5;214m\]'
        Orange='\[\033[38;5;202m\]'
    fi
    Reset='\[\033[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'
    gitps1=`__git_ps1`
    
    MPWD=`pwd`
    THOME=${HOME//\//\\\/}
    REPWD=${MPWD/#$THOME/\~}
    OIFS=$IFS
    IFS="/"
    read -a PARR <<< "$REPWD";
    
    IFS=$OIFS
    RPWD=""
    if [ "${#PARR[@]}" -gt 5 ]; 
    then
        PLEN="${#PARR[@]}"
        RPWD="${PARR[0]}/${PARR[1]}/[...]/${PARR[$(expr $PLEN - 2)]}/${PARR[$(expr $PLEN - 1)]}"
    else
        RPWD=$REPWD
    fi

    PS1="$Orange\u$Reset";
    #Checking for VIM
    if [ -z $VIM ]; then
        PS1+=""; 
    else
        PS1+="$Red[v]$Reset"
    fi
    #Checking if root
    if [[ ${EUID} == 0 ]]; then
        PS1+="$Green\h"
    else 
        PS1+="$Green@\h";
    fi

    if [ -z "${gitps1}" ]; then
        PS1+=" $Yellow$RPWD ";
    else
        PS1+=" $Yellow$RPWD$Reset$gitps1 ";
    fi
    
    if [[ $lastcmd == 0 ]]; then
        PS1+="$Green$Checkmark "
    else
        PS1+="$Red$FancyX "
    fi

    PS1+="$Blue \\$ $Reset"

## TO SET VIRTUALENV NAME
    if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ] ; then

        if [ "$VIRTUAL_ENV" != "" ]; then

            PS1="{`basename \"$VIRTUAL_ENV\"`}$PS1"
        fi

    fi 
}

# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
	
	# we have colors :-)
  
	# Enable colors for ls, etc. Prefer ~/.dir_colors

    if [[ $OSTYPE == "linux-gnu" ]]; then
        if type -P dircolors >/dev/null ; then
            if [[ -f ~/.dir_colors ]] ; then
                eval $(dircolors -b ~/.dir_colors)
            elif [[ -f /etc/DIR_COLORS ]] ; then
                eval $(dircolors -b /etc/DIR_COLORS)
            fi
        fi
    fi
        
    PROMPT_COMMAND='set_prompt'

    if [[ $OSTYPE == "linux-gnu" ]]; then
        alias ls="ls --color=auto"
        alias dir="dir --color=auto"
        alias grep="grep --color=auto"
        alias dmesg='dmesg --color'
    else
        alias ls="ls -FHG"
    fi
    alias setdock='eval "$(docker-machine env dev)"'
	# Uncomment the "Color" line in /etc/pacman.conf instead of uncommenting the following line...!

	# alias pacman="pacman --color=auto"

else

	# show root@ when we do not have colors

	PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "

fi

PS2="> "
PS3="> "
PS4="+ "


# Try to keep environment pollution down, EPA loves us.
unset safe_term match_lhs

# Try to enable the auto-completion (type: "pacman -S bash-completion" to install it). **** ONLY FOR ARCH ****
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Try to enable the "Command not found" hook ("pacman -S pkgfile" to install it).  **** ONLY FOR ARCH *****
# See also: https://wiki.archlinux.org/index.php/Bash#The_.22command_not_found.22_hook
[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash

#Agave setup
export PATH=$PATH:/Users/xirdneh/projects/agave/foundation-cli/bin:~/.npm-global/bin:/usr/local/opt/python/libexec/bin:/Users/xirdneh/Library/Python/3.7/bin:/Users/xirdneh/Library/Python/2.7/bin
export AGAVE_CACHE_DIR=$HOME/.agave/current
alias agv-ds='ln -Ffhs $HOME/.agave/designsafe $HOME/.agave/current'
alias agv-dsjs='ln -Ffhs $HOME/.agave/designsafe-jc $HOME/.agave/current'
alias agv-dswma='ln -Ffhs $HOME/.agave/designsafe-wma_prtl $HOME/.agave/current'
alias agv-dsenv='ln -Ffhs $HOME/.agave/designsafe-envision $HOME/.agave/current'
alias agv-arp='ln -Ffhs $HOME/.agave/araport $HOME/.agave/current'
alias agv-tacc='ln -Ffhs $HOME/.agave/tacc $HOME/.agave/current'
alias agv-tacc-digrocks='ln -Ffhs $HOME/.agave/tacc-digrocks $HOME/.agave/current'
alias agv-tacc-wma='ln -Ffhs $HOME/.agave/tacc-wma_prtl $HOME/.agave/current'
alias agv-portals-wma='ln -Ffhs $HOME/.agave/portals-wma_prtl $HOME/.agave/current'

alias op-rel='curl https://opbeat.com/api/v1/organizations/<organization-id>/apps/<app-id>/releases/ \
                -H "Authorization: Bearer <secret-token>" \
                -d rev=`git log -n 1 --pretty=format:%H` \
                -d branch=`git rev-parse --abbrev-ref HEAD` \
                -d status=completed'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

alias ds-build-frontend='curl https://jenkins01.tacc.utexas.edu/job/DesignSafeCI_Portal_Frontend/build?token=2cc9d810-47c9-4aec-87f4-2f585778fab4'
alias ds-build-portal='curl https://jenkins01.tacc.utexas.edu/job/DesignSafeCI_Portal/build?token=c3807270-e3e4-11e6-bf01-fe55135034f3'

ds-dc-dev() {
    docker-compose -f /Users/xirdneh/projects/designsafe/portal/conf/docker/docker-compose-dev.all.debug.yml "$@" | ~/projects/misc_scripts/awk/colorized/django/docker_django.sh 
}

cep-dc-dev() {
    docker-compose -f /Users/xirdneh/projects/cep/server/conf/docker/docker-compose-dev.all.debug.yml "$@" | ~/projects/misc_scripts/awk/colorized/django/docker_django.sh 
}

#PYTHONPATH
DS_TOKEN=c04fcdc18d7502ff52b6970c285773d
JEKYLL_GITHUB_TOKEN=a852c61cc70520c9aa1bfc4dd591d8e2ef20f010

branches-between-tags() {
commits=($( git --no-pager log --format="%H" "$@" ))

inbetween=()
for commit in "${commits[@]}"
do
    contains=($( git --no-pager branch --contains "$commit" | grep -v '\* master'))
    inbetween+=( "${contains[@]}" )
done
unique=($(for r in "${inbetween[@]}"; do echo "$r"; done | sort -du))

for out in "${unique[@]}"
do 
    echo "$out"
done
}

branch-in-tag() {
commit=$(git show --format="%H" $1| head -n 1)
tag=$(git tag --contains "$commit" | grep "$2")
echo "$tag"
}
export GPG_TTY=$(tty)

# added by travis gem
[ -f /Users/xirdneh/.travis/travis.sh ] && source /Users/xirdneh/.travis/travis.sh
