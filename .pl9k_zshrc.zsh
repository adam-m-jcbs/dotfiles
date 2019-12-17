# PowerLevel9k ZSH Theme/prompt customization goes here

#COLORS!!! This is witchcraft, but with xfce and a few others, you can get so
#many colors that are consistent across terminals by going here:
# https://mayccoll.github.io/Gogh/
# in xfce4 and some other terminals, you can just do:
# `bash -c  "$(wget -qO- https://git.io/vQgMr)"`
#just go there to choose color schemes for now
#   some faves:
#       one half black 120

#The following started as a copypasta from https://github.com/Powerlevel9k/powerlevel9k/wiki/Show-Off-Your-Config#letientai299s-configuration

POWERLEVEL9K_MODE='nerdfont-complete'

#fish-(and vim-)like shortening /usr/share/bin --> /u/s/bin
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

#POWERLEVEL9K_MODE='awesome-patched'
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# TODO according to font git repo, using codepoints (\u0x##) like this can break
#   over time.  They're not standardized like that.  Font wizards will know what
#   you're supposed to do
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{black} `date +%T`  %f%k%F{white}%f "
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{black} `cat ~/.clock_log/state | awk '{$1=$1;print}'` %f%k%F{white}%f "
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{black} (dir) %f%k%F{white}%f "

#You can hack in a custom element somewhat easily with PL9K:
POWERLEVEL9K_CUSTOM_CLOCK_STAT='~/.local/bin/clp_state.zsh'
POWERLEVEL9K_CUSTOM_CLOCK_STAT_BACKGROUND='white'
POWERLEVEL9K_CUSTOM_CLOCK_STAT_FOREGROUND='black'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode root_indicator context virtualenv anaconda dir dir_writable vcs newline custom_clock_stat)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status background_jobs time)

###Customize L and R prompt elements in Powerlevel9k
#   SEGMENTS REFERENCE of key segments I want to explore
#   SYSTEM STATUS
#       background_jobs
#       context (username, host, and ssh info?)
#       date
#       dir
#       dir_writable
#       host
#       public_ip
#       load (machine load averages)
#       os_icon (cosmetic, but cute to know about)
#       ram (free RAM)
#       root_indicator
#       status (return code of prev command)
#       time
#       vi_mode
#       ssh (indicates if you're in ssh session, does context give this?)
#   VCS (git)
#       vcs
#   PYTHON
#       virtualenv
#       anaconda
#       pyenv
#
