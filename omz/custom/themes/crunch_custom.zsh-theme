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

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$CRUNCH_BRACKET_COLOR:$CRUNCH_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $CRUNCH_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $CRUNCH_GIT_DIRTY_COLOR✗"

# Checking local admin
ADMIN_YES_COLOR="%{$fg[green]%}"
ADMIN_NO_COLOR="%{$fg[white]%}"
function checkAdmin() {
  TESTADMIN=$(command id -Gn $(whoami) | grep -w admin)
  if [[ -n ${TESTADMIN} ]]; then
    echo "$ADMIN_YES"
  else
    echo "$ADMIN_NO"
  fi
}
ADMIN_YES="$ADMIN_YES_COLOR➭"
ADMIN_NO="$ADMIN_NO_COLOR➭"
ADMIN_PROMPT='$(checkAdmin)'

# '[%D{%L:%M:%S %p}]'
# Our elements:
CRUNCH_TIME_="$CRUNCH_TIME_COLOR%D{%d|%H:%M:%S}%{$reset_color%}"

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
CRUNCH_NUM=$CRUNCH_HIST_COLOR'$CMDCOUNT'                # notice the single(!) tics

# hostname
# CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
if [[ $(hostname -s) == sbaxter-Civis-Mac ]]; then
    CRUNCH_HOST_COLOR="%{$fg[cyan]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'Civis'
    HOST='Civis' # HOST var sets oh-my-zsh window title hostname (test with 'print -P %n@%m')
    # prompt expansion http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
elif [[ $(hostname -s) == navi ]]; then
    CRUNCH_HOST_COLOR="%{$fg[cyan]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
elif [[ $(hostname -s) == macpro ]]; then
    CRUNCH_HOST_COLOR="%{$fg[white]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
elif [[ $(hostname -s) == euclid ]]; then
    CRUNCH_HOST_COLOR="%{$fg[yellow]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
elif [[ $(hostname -s) =~ [test] ]]; then
    CRUNCH_HOST_COLOR="%{$fg[green]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
else
    CRUNCH_HOST_COLOR="%{$fg[red]%}"
    CRUNCH_HOST="${CRUNCH_HOST_COLOR}"'$(hostname -s)'
fi

# system load
export OS_TYPE="$(uname -s)"
  # MacOS = Darwin
  # Linux = Linux
if [ "$OS_TYPE" = Darwin ]; then
  LOAD_NOW="$LOAD_COLOR"'$(uptime | sed -e "s/.*load averages: \(.*\...\) \(.*\...\) \(.*\...\)/\1/" -e "s/ //g")'
elif [ "$OS_TYPE" = Linux ]; then
  LOAD_NOW="$LOAD_COLOR"'$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\)/\1/" -e "s/ //g")'
fi

# Realtime Prompt refresh
# TMOUT=1
# TRAPALRM() {zle reset-prompt}

# aws sts assume-role timeout
function checkSTS() {
if [[ -n $AWS_STS_EXPIRATION && $AWS_STS_TIMEOUT -ge $(date +%s) ]]; then
    AWS_STS_MINUTES_REMAINING=$(( $(( AWS_STS_TIMEOUT - $(date -u +%s) )) / 60 ))
    echo "$(echo ${AWS_ACCOUNT_NAME} | sed 's/^.\{6\}//g')|$AWS_STS_MINUTES_REMAINING"
elif [[ $AWS_STS_TIMEOUT -le $(date +%s) ]]; then
  unset AWS_STS_EXPIRATION
fi
}
STS_PROMPT="$STS_COLOR"'$(checkSTS)'

# Put it all together!
PROMPT="$CRUNCH_TIME_ $LOAD_NOW $CRUNCH_NUM $CRUNCH_HOST $STS_PROMPT $CRUNCH_DIR_$ADMIN_PROMPT %{$reset_color%}"

# specifically for shellcheck linting, set this file to sh
# vim: ft=sh:
