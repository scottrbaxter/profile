# specifically for shellcheck linting, set this file to sh
# vim: ft=sh:

# CRUNCH - created from Steve Eley's cat waxing.
# Initially hacked from the Dallas theme. Thanks, Dallas Reedy.
#
# This theme assumes you do most of your oh-my-zsh'ed "colorful" work at a single machine,
# and eschews the standard space-consuming user and hostname info.  Instead, only the
# things that vary in my own workflow are shown:
#
# * The time (not the date)
# * The RVM version and gemset (omitting the 'ruby' name if it's MRI)
# * The current directory
# * The Git branch and its 'dirty' state
#
# Colors are at the top so you can mess with those separately if you like.
# For the most part I stuck with Dallas's.

CRUNCH_BRACKET_COLOR="%{$fg[white]%}"
CRUNCH_TIME_COLOR="%{$fg[blue]%}"
#CRUNCH_TIME_COLOR="%{$fg[yellow]%}"
CRUNCH_RVM_COLOR="%{$fg[magenta]%}"
CRUNCH_DIR_COLOR="%{$fg[blue]%}"
#CRUNCH_DIR_COLOR="%{$fg[cyan]%}"
CRUNCH_GIT_BRANCH_COLOR="%{$fg[green]%}"
CRUNCH_GIT_CLEAN_COLOR="%{$fg[green]%}"
CRUNCH_GIT_DIRTY_COLOR="%{$fg[red]%}"
CRUNCH_HIST_COLOR="%{$fg[red]%}"
LOAD_COLOR="%{$fg[magenta]%}"
STS_COLOR="%{$fg[white]%}"
OP_COLOR="%{$fg[blue]%}"

# time
NOW(){
    date -u +%s
}

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$CRUNCH_BRACKET_COLOR:$CRUNCH_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $CRUNCH_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $CRUNCH_GIT_DIRTY_COLOR✗"

# Checking local admin
ADMIN_YES_COLOR="%{$fg[green]%}"
ADMIN_NO_COLOR="%{$fg[white]%}"
checkAdmin() {
  TESTADMIN=$(command id -Gn $(whoami) | grep -w admin)
  if [[ -n ${TESTADMIN} ]]; then
    echo "$ADMIN_YES"
  else
    echo "$ADMIN_NO"
  fi
}
ADMIN_YES="$ADMIN_YES_COLOR➭"
ADMIN_NO="$ADMIN_NO_COLOR➭"
ADMIN_='$(checkAdmin)'

# '[%D{%L:%M:%S %p}]'
# Our elements:
CRUNCH_TIME_="$CRUNCH_TIME_COLOR%D{%d|%H:%M:%S}%{$reset_color%} "

# According to the zshmisc man page there are several % codes for date and time, eg:
# Examples to set the time
# %D     The date in yy-mm-dd format.
# %T     Current time of day, in 24-hour format.
# %t %@  Current time of day, in 12-hour, am/pm format.
# %*     Current time of day in 24-hour format, with seconds.
# %w     The date in day-dd format.
# %W     The date in mm/dd/yy format.
# %D{strftime-format} # man strftime

# if [ -e ~/.rvm/bin/rvm-prompt ]; then
#   CRUNCH_RVM_="$CRUNCH_BRACKET_COLOR"["$CRUNCH_RVM_COLOR\${\$(~/.rvm/bin/rvm-prompt i v g)#ruby-}$CRUNCH_BRACKET_COLOR"]"%{$reset_color%}"
# else
#   if which rbenv &> /dev/null; then
#     CRUNCH_RVM_="$CRUNCH_BRACKET_COLOR"["$CRUNCH_RVM_COLOR\${\$(rbenv version | sed -e 's/ (set.*$//' -e 's/^ruby-//')}$CRUNCH_BRACKET_COLOR"]"%{$reset_color%}"
#   fi
# fi

CRUNCH_DIR_="$CRUNCH_DIR_COLOR%~\$(git_prompt_info) "
CRUNCH_HIST="$CRUNCH_HIST_COLOR%!"

setopt PROMPT_SUBST
[[ $CMDCOUNT -ge 1 ]] || CMDCOUNT=1
preexec() { ((CMDCOUNT++)) }
NUM_=$CRUNCH_HIST_COLOR'$CMDCOUNT '                # notice the single(!) tics

# hostname
# CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
    CRUNCH_HOST_COLOR="%{$fg[cyan]%}"
if [[ $(hostname -s) == neptune ]]; then
    HOST_="${CRUNCH_HOST_COLOR}"'$(hostname -s) '
    # prompt expansion http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
elif [[ $(hostname -s) == terra ]]; then
    CRUNCH_HOST_COLOR="%{$fg[green]%}"
    HOST_="${CRUNCH_HOST_COLOR}"'$(hostname -s) '
elif [[ $(hostname -s) == jupiter ]]; then
    CRUNCH_HOST_COLOR="%{$fg[red]%}"
    HOST_="${CRUNCH_HOST_COLOR}"'$(hostname -s) '
elif [[ $(hostname -s) == saturn ]]; then
    CRUNCH_HOST_COLOR="%{$fg[yellow]%}"
    HOST_="${CRUNCH_HOST_COLOR}"'$(hostname -s) '
else
    CRUNCH_HOST_COLOR="%{$fg[white]%}"
    HOST_="${CRUNCH_HOST_COLOR}"'$(hostname -s) '
fi

# system load
if [ "$OS_TYPE" = Darwin ]; then # MacOS
  LOAD_="$LOAD_COLOR"'$(uptime | sed -e "s/.*load averages: \(.*\...\) \(.*\...\) \(.*\...\)/\1/" -e "s/ //g") '
elif [ "$OS_TYPE" = Linux ]; then # Linux
  LOAD_="$LOAD_COLOR"'$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g") '
fi

# Realtime Prompt refresh
# TMOUT=1
# TRAPALRM() {zle reset-prompt}

# aws sts assume-role timeout
checkSTS() {
    if [[ ! $AWS_STS_EXPIRATION ]]; then
        return
    elif [[ -n $AWS_STS_EXPIRATION && $AWS_STS_TIMEOUT -ge $(NOW) ]]; then
        AWS_STS_MINUTES_REMAINING=$(( $(( AWS_STS_TIMEOUT - $(NOW) )) / 60 ))
        echo "$(echo ${AWS_ACCOUNT_NAME})|$AWS_STS_MINUTES_REMAINING "
    elif [[ $AWS_STS_TIMEOUT -le $(NOW) ]]; then
      unset AWS_STS_EXPIRATION
    fi
}
STS_="$STS_COLOR"'$(checkSTS)'

# check if op is logged in
checkOP() {
    if [[ ! $OP_EXPIRATION ]]; then
        return
    else
        OP_MINUTES_REMAINING=$(( $(( OP_EXPIRATION - $(NOW) )) / 60 ))
        echo "P|$OP_MINUTES_REMAINING "
    fi
}
OP_="$OP_COLOR"'$(checkOP)'

check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT="%{$fg_bold[red]%}E|$LAST_EXIT_CODE%{$reset_color%} "
    echo "$EXIT_CODE_PROMPT"
  fi
}
EXIT_='$(check_last_exit_code)'

# Put it all together!
PROMPT="$CRUNCH_TIME_$EXIT_$LOAD_$OP_$STS_$NUM_$HOST_$STS_PROMPT_$CRUNCH_DIR_$ADMIN_ %{$reset_color%}"
