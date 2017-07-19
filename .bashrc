# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

### Global definitions (valid for all systems)

# aliases
alias ls='ls --color --group-directories-first'
alias gist='git status -uno'

# Paths and configuration used by research codes
# ASSUMPTION: Codes are put in $HOME/Codebase
export CODEBASE=${HOME}/Codebase
export AMREX_HOME=${CODEBASE}/AMReX
export MICROPHYSICS_HOME=${CODEBASE}/Microphysics
export MAESTRO_HOME=${CODEBASE}/MAESTRO
export CASTRO_HOME=${CODEBASE}/Castro
export ASTRODEV_DIR=${CODEBASE}/AstroDev

# Set preferred editor
export EDITOR=vim

### xrb configuration
if [ `hostname` = "xrb.pa.msu.edu" ]; then
   # Custom prompt
   #    From Mike: prompt -- this gets the git branch in the prompt
   #    we also use some coloring.  Note that we need to put the 
   #    coloring escape codes inside \[ \], otherwise, bash will include
   #    them in the line length calculation and things will be messed up.
   source /usr/share/git-core/contrib/completion/git-prompt.sh
   export GIT_PS1_SHOWDIRTYSTATE=1
   export PS1='[\u@\h \W]\[\e[1;34m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
   
   # Expose CUDA binaries
   export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
   #This should only be needed with runfile install, not rpm
   #export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:${LD_LIBRARY_PATH}
   
   # Expose PGI installation
   export PGI=/opt/pgi
   export LM_LICENSE_FILE=$LM_LICENSE_FILE:/opt/pgi/license.dat
   export PATH=/opt/pgi/linux86-64/17.4/bin:$PATH
   export MANPATH=$MANPATH:/opt/pgi/linux86-64/17.4/man
   
   # Make SkyNet and Kepler packages available in python
   export PYTHONPATH=/opt/skynet/lib:${CODEBASE}/kepler/python_scripts:${PYTHONPATH}
   
   # Initialize Kepler environment variables
   export KEPLER_PATH=${CODEBASE}/kepler
   export KEPLER_DATA=$KEPLER_PATH/local_data/
   # Mongo is used for Kepler visualization/plotting
   MONGO_VERSION='mongo'
   MONGO_PATH=$KEPLER_PATH/$MONGO_VERSION
   export HELPFILE=$MONGO_PATH/help.dat
   export MONGOPS=$MONGO_PATH/postscript/
   export FONTDAT=$MONGO_PATH/fonts.dat
   export FONTNEW=$MONGO_PATH/fonts.vis

   export OMP_NUM_THREADS=6  #Number of cores is a decent value to use,
                             #note xrb has 6 physical cores, 12 logical

   #nvim's on xrb, so use it
   export EDITOR=nvim
fi