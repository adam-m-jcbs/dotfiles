# A zshrc built from scratch by me (Adam Jacobs).
# 
# My shell rc's are designed to be deployed on multiple machines.  Thus, we have
# global options I always like or expect to work robustly on many machines.  I
# then tailor any specifics per-host.  As of now it's all in this file.  Could
# be nice to refactor into subfiles

## Global general configuration (valid for all systems)

#Enable fzf search/completion
# NOTE: !!!MUST be before vi bindings are turned on!!!!
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
fi

# Some things pay attention to this, set language:
export LANG="en_US.UTF-8"

# Set preferred editor, pager
export EDITOR=vim
export PAGER=less

# Make local/user binaries, scripts available
typeset -U PATH path #Makes it so only unique items are added to PATH env variable or path array (which mirrors env var)
path=("$HOME/.local/bin" "$path[@]")
export PATH
# Old bash way of doing it, for reference:
#export PATH=${PATH}:${HOME}/.local/bin

### zsh init code
#basic completion and prompt system
autoload -Uz compinit promptinit
compinit
promptinit

#enables history search with key bindings as in bash (zsh needs magic for this because it uses ZLE instead of readline... I think)
# NOTE: only works if you bind keys like Up, Down, Home, etc
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

# init the antibody zsh plugin manager
#   NOTE: you can easily install antibody with something like
#       $ curl -sfL git.io/antibody | sh -s - -b ${HOME}/.local/bin
#   NOTE: This dynamically loads, which fits your workflow.  But if zsh is slow
#       for some reason, static loading could be faster
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

### Configure non-default keybindings
export KEYTIMEOUT=2.5 # Default is 4=0.4 s, reducing it makes switching vi modes nicer, but might interfere with other bindings, so be careful
bindkey -v  # use vi bindings for CLI
bindkey '^ ' autosuggest-accept # CTRL + SPACE will complete autosuggestions (tabs are for completion)

### aliases
alias ls='ls --color --group-directories-first'
alias gist='git status -uno'
alias mypubip='dig +short myip.opendns.com @resolver1.opendns.com'

### Research and code configuration

# Set the root directory for codes associated with my research/teaching/work
export CODEBASE=${HOME}/Codebase

# AMReX (https://amrex-codes.github.io)
# and Starkiller (https://github.com/starkiller-astro/) codes
export AMREX_HOME=${CODEBASE}/AMReX
export MICROPHYSICS_HOME=${CODEBASE}/Microphysics
export MAESTRO_HOME=${CODEBASE}/MAESTRO
export CASTRO_HOME=${CODEBASE}/Castro
export ASTRODEV_DIR=${CODEBASE}/AstroDev

# Kepler (https://2sn.org/kepler/doc/)
export KEPLER_PATH=${CODEBASE}/kepler
export KEPLER_DATA=$KEPLER_PATH/local_data/
# Mongo is used for Kepler visualization/plotting
MONGO_VERSION='mongo'
MONGO_PATH=$KEPLER_PATH/$MONGO_VERSION
export HELPFILE=$MONGO_PATH/help.dat
export MONGOPS=$MONGO_PATH/postscript/
export FONTDAT=$MONGO_PATH/fonts.dat
export FONTNEW=$MONGO_PATH/fonts.vis
if [ -d "${CODEBASE}/kepler/python_scripts" ]; then
    # Populate PYTHONPATH with Kepler python scripts, if available
    export PYTHONPATH=${CODEBASE}/kepler/python_scripts:${PYTHONPATH}
fi

# pynucastro
if [ -d "${CODEBASE}/pynucastro" ]; then
    export PYTHONPATH=${CODEBASE}/pynucastro:${PYTHONPATH}
fi

### Configure zsh prompts

# This will set the default prompt to the adam2 theme
#prompt adam2
source $HOME/.pl9k_zshrc.zsh

### zsh completion tweaks
zstyle ':completion:*' menu select    # gives arrow-driven completion menu
setopt COMPLETE_ALIASES

### zsh one-liners
AUTO_LS_COMMANDS=(ls) #requires auto-ls plugin, can add custom

### Add bindings to keys that bash gets for free because it uses readline (I think)
# This comes from Arch Wiki on Zsh config

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
# TODO: Move this to the key binding section?  I'm not confident enough yet in
#       how order impacts things in a zshrc to want to try it
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

### Enable history searching with up, down keys
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

### Initialize Ruby gems for Jekyll
function init_gems {
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
}

##Host-by-host customizations
case `hostname` in
### xrb configuration
"xrb.pa.msu.edu")
    #set_ps1 "/usr/share/git-core/contrib/completion/git-prompt.sh"
    init_gems
    
    # Expose CUDA binaries
    export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
    #I don't think I need these, but for reference I'm commenting out:
    #export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/lib64/stubs:${LD_LIBRARY_PATH}
    #export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/NVIDIA_CUDA-8.0_Samples/common/inc
    
    # Expose PGI installation
    export PGI=/opt/pgi
    export LM_LICENSE_FILE=$LM_LICENSE_FILE:/opt/pgi/license.dat
    export PATH=/opt/pgi/linux86-64/17.4/bin:$PATH
    export MANPATH=$MANPATH:/opt/pgi/linux86-64/17.4/man
    
    # Make packages available in python
    export PYTHONPATH=${PYTHONPATH}:/opt/skynet/lib:${HOME}/Research/Projects/XRB/Sensitivity/analysis/flow/Keek
  
    export OMP_NUM_THREADS=6  #Number of cores is a decent value to use,
                              #note xrb has 6 physical cores, 12 logical

    #nvim's on xrb, so use it
    export EDITOR=nvim

    #annoyingly, vim doesn't come with clipboard, so alias to Fedora's vimx
    alias vim=vimx
    ;;
### siona, my laptop
"siona")
    #set_ps1 "/usr/share/git/completion/git-prompt.sh"
    init_gems

    # Get the right sound card
    export ALSA_CARD=PCH

    # Make sure Emacs and others know we have 256 color
    export TERM=xterm-256color
    
    # nvim's available, let's use it!
    export EDITOR=nvim
    alias vim=nvim

    export OMP_NUM_THREADS=4

    # Try this on siona, maybe make global later
    alias cat="bat"
    alias ls="exa --group-directories-first"

    # For insight
    source /home/ajacobs/.profile
    ;;
### iCER / HPCC configuration
"gateway-*" | "dev-intel16-k80" | "dev-intel16" | "dev-intel14" | "dev-intel14-phi" |  "dev-intel14-k20" )
    #set_ps1

    # Make local/user python packages available
    #export PYTHONPATH=${HOME}/.local/lib/python3.3/site-packages:${PYTHONPATH}
   
    # Initiate python virtual environment (easier way to get yt going on iCER)
    source ${HOME}/PyVE/bin/activate
    # The interactions between modules and python environment can cause some odd
    # errors.  One of those is that the PyVE `pip` gets overridden in PATH. I
    # tried some solutions, but only one I can get to work at the moment is to
    # alias
    alias pip=${HOME}/PyVE/bin/pip
    
    #annoyingly, default vim build doesn't come with clipboard, so alias to vimx
    alias vim=vimx

    # Make SLURM's default info reporting better
    export SACCT_FORMAT="jobid%15,jobname%15,partition,allocnodes,alloccpus,ntasks,state,elapsed,timelimit,start,nodelist"

    ;;
### iCER / HPCC configuration
"comet-*")
    #set_ps1

    # Make local/user python packages available
    #export PYTHONPATH=${HOME}/.local/lib/python3.3/site-packages:${PYTHONPATH}
   
    # Initiate python virtual environment (easier way to get yt going on iCER)
    #source ${HOME}/PyVE/bin/activate
    # The interactions between modules and python environment can cause some odd
    # errors.  One of those is that the PyVE `pip` gets overridden in PATH. I
    # tried some solutions, but only one I can get to work at the moment is to
    # alias
    #alias pip=${HOME}/PyVE/bin/pip
    
    #annoyingly, default vim build doesn't come with clipboard, so alias to vimx
    #alias vim=vimx

    # Make SLURM's default info reporting better
    export SACCT_FORMAT="jobid%15,jobname%15,partition,allocnodes,alloccpus,ntasks,state,elapsed,timelimit,start,nodelist"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/ajacobs/builds/Miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/ajacobs/builds/Miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/ajacobs/builds/Miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/ajacobs/builds/Miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    ;;

## default configuration
*)
    #set_ps1
    ;;
esac


#Enable Arch Linux's install of the fish-inspired syntax highlighting zsh package (this may slow things)
# NOTE: MUST BE LAST
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
