# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

### Global general configuration (valid for all systems)

# aliases
alias ls='ls --color --group-directories-first'
alias gist='git status -uno'

# Set preferred editor
export EDITOR=vim

## Configure prompt (PS1)
function set_ps1 {
    # Configure bash's prompt $PS1.
    #
    # Arguments:
    # $1 -- full path to local `git-prompt.sh`. Optional, will try to download
    #       local copy if not provided.
   
    # Find or get git-prompt.sh, source it
    local prompt_script=''
    if [ ${1##*/} == 'git-prompt.sh' ] && [ -f $1 ]; then
        # If $1 is a path with filename "git-prompt.sh" and it's readable, use
        prompt_script=$1
    else
        # Otherwise use ~/.git-prompt.sh, download if needed
        # WARNING/TODO: git-prompt.sh may require git-completion.bash. 
        #   If so, use this:
        #   $ curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
        #   source ~/.git-completion.bash
        if [ ! -f ~/.git-prompt.sh ]; then
            echo "[BASHRC]: Downloading ~/.git-prompt.sh..."
            curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
            echo "[BASHRC]: Downloaded ~/.git-prompt.sh with status " $?
        fi
        prompt_script=~/.git-prompt.sh
    fi
    source $prompt_script

    # Customize the prompt using features added by git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1    # Show unstaged(*) and staged(+) changes
    export GIT_PS1_SHOWUPSTREAM="auto" # Upstream status
                                       #    <  behind
                                       #    >  ahead
                                       #    <> diverged
                                       #    =  up-to-date
    export GIT_PS1_STATESEPARATOR='|'
    export PS1='[\u@\h \W]\[\e[1;34m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
}

## Research and code configuration

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

# Populate PYTHONPATH with any available python package directories
if [ -d "${CODEBASE}/kepler/python_scripts" ]; then
    export PYTHONPATH=${CODEBASE}/kepler/python_scripts:${PYTHONPATH}
fi

### xrb configuration
if [ `hostname` = "xrb.pa.msu.edu" ]; then
   set_ps1 "/usr/share/git-core/contrib/completion/git-prompt.sh"
   
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
   export PYTHONPATH=/opt/skynet/lib:${HOME}/Research/Projects/XRB/Sensitivity/analysis/flow/Keek:${PYTHONPATH}
  
   export OMP_NUM_THREADS=6  #Number of cores is a decent value to use,
                             #note xrb has 6 physical cores, 12 logical

   #Make RubyGems available, for Jekyll
   export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
   export GEM_HOME=$(ruby -e 'print Gem.user_dir')

   #nvim's on xrb, so use it
   export EDITOR=nvim
fi

### iCER / HPCC configuration
if [[ `hostname` = gateway-* ]]; then
   # Custom prompt
   #    From Mike: prompt -- this gets the git branch in the prompt
   #    we also use some coloring.  Note that we need to put the 
   #    coloring escape codes inside \[ \], otherwise, bash will include
   #    them in the line length calculation and things will be messed up.
   # If you can't find an install of git-prompt.sh, you can get it with e.g.
   #    $ curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
   source ~/.git-prompt.sh
   export GIT_PS1_SHOWDIRTYSTATE=1
   export PS1='[\u@\h \W]\[\e[1;34m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
   # Similar for bash autocomplete:
   #    $ curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
   source ~/.git-completion.bash
fi
