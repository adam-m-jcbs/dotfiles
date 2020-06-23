#!/bin/bash
#
# ~/.bash_profile
#


# Titan login shell preferences 
if [ `expr match "$HOSTNAME" 'titan'` -gt 0 ] 
then
    echo ".bash_profile: Executing titan login shell preferences"

    #Load my preferred modules for titan
    module load git
    #module load gcc # Needed to run some gnu-compiled binaries
    module swap PrgEnv-pgi PrgEnv-cray
    module load cray-hdf5
    module load python
    module load python_numpy/1.9.2
    module load python_scipy
    module load python_matplotlib
    module load python_ipython
    module load python_zmq
    module load vim
fi

# OLCF dtn (data transfer nodes) preferences
if [ `expr match "$HOSTNAME" 'dtn'` -gt 0 ] 
then
    echo ".bash_profile: Executing dtn login shell preferences"

    #Load my preferred modules for dtn
    module load globus
    module load vim
fi

# OLCF rhea preferences
if [ `expr match "$HOSTNAME" 'rhea'` -gt 0 ] 
then
    echo ".bash_profile: Executing rhea login shell preferences"

    #Load my preferred modules for lens
    module load git
    module load gcc
    module load hdf5
    module swap PE-intel PE-gnu
    module load python
    module load python_numpy
    module load python_matplotlib
    module load python_scipy
    module load python_mpi4py
    module load python_cython
    module load python_h5py
    module load python_yt
    module load vim
fi

# OLCF summitdev preferences
if [ `expr match "$HOSTNAME" 'summitdev'` -gt 0 ] 
then
    echo ".bash_profile: Executing summitdev login shell preferences"

    #Load my preferred modules
    module load pgi/17.4
    module load vim
fi

# iCER/HPCC login shell preferences 
if  [ `expr match "$HOSTNAME" 'dev-intel16-k80'` -gt 0 ] || 
    [ `expr match "$HOSTNAME" 'dev-intel16'` -gt 0 ] || 
    [ `expr match "$HOSTNAME" 'dev-intel14-phi'` -gt 0 ] || 
    [ `expr match "$HOSTNAME" 'dev-intel14-k20'` -gt 0 ] || 
    [ `expr match "$HOSTNAME" 'dev-intel14'` -gt 0 ]
then
    echo ".bash_profile: Executing HPCC login shell preferences"

    #Load my preferred modules
    #    NOTE: some modules are loaded as required according to
    #    `module spider <module>`. This seems to defeat purpose of modules
    module purge #very stupidly, I have to unload modules that iCER loaded for me by default.  Otherwise, my modules break.  Again, isn't this what lmod's for?
    module load GNU/7.3.0-2.30 # req'd for Python/3.7.0
    module load OpenMPI/3.1.1 # req'd for Python/3.7.0
    module load Python/3.7.0  # Pre-transition version: Python3/3.5.0
    module load git
    module load powertools
fi

if  [ `expr match "$HOSTNAME" 'comet'` -gt 0 ]
then
    echo ".bash_profile: Executing Comet login shell preferences"

    #NOTE: I'm trying out miniconda3 as a way to get a compatible, non-ancient version
    #of Python instead of modules (they only have up to 3.5, which my code won't
    #run on).  I'm keeping the below for reference in case this breaks.

    #Load my preferred modules
    #module purge # sometimes helps thing go smoothly
    #module load python

    #source ${HOME}/PyVE/bin/activate
fi

if  [ `expr match "$HOSTNAME" 'pixel-c'` -gt 0 ]
then
    echo ".bash_profile: Executing pixel-c login shell preferences"

    #Customize keymappings for the pixel-c keyboard
    #   ... key            --> keycode 108 Alt_R
    #   <search/mag glass> --> keycode 133 Super_L

    #turn ... into distinct mod key, we use Mode_switch here
    #                         key         shift+key   Mode_switch+key Mode_switch+shift+key
    xmodmap -e "keycode 108 = Mode_switch Mode_switch Mode_switch     Mode_switch"

    #... + o (keycode 32)        --> [   (keycode 34 bracketleft)
    #... + shift + o (keycode 32) --> {   (keycode 34 braceleft)
    xmodmap -e "keycode 32 = o O bracketleft braceleft"

    #... + p (keycode 33)         --> ]   (keycode 35 bracketright)
    #... + shift + p (keycode 33) --> }   (keycode 35 braceright)
    xmodmap -e "keycode 33 = p P bracketright braceright"

    #... + = (keycode 21)         --> \   (keycode 51 backslash)
    #... + shift + = (keycode 21) --> |   (keycode 51 bar)
    xmodmap -e "keycode 21 = equal plus backslash bar"

    #... + 2 (keycode 11)         --> `   (keycode 49 grave)
    #... + shift + 2 (keycode 11) --> ~   (keycode 49 asciitilde)
    xmodmap -e "keycode 11 = 2 at grave asciitilde"

    #... + 1 (keycode 10)         --> Esc (keycode 34)
    xmodmap -e "keycode 10 = 1 exclam Escape NoSymbol"
fi




# Common for all hosts

# .bashrc is sometimes sourced in login shells, sometimes not.
# For consistency, just always do it.  I do it last because I want PATH changes
# in .bashrc to take precedence of those from modules.
[[ -f ~/.bashrc ]] && . ~/.bashrc
