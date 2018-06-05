#!/bin/bash

# Common for all hosts

# .bashrc is sometimes sourced in login shells, sometimes not.
# For consistency, just always do it.
# TODO: Would be nice to only do when needed. Does this mean .bashrc can be
#   sourced twice?  Will it make my $PATH ugly?
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

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
    [ `expr match "$HOSTNAME" 'dev-intel14'` -gt 0 ]
then
    echo ".bash_profile: Executing HPCC login shell preferences"

    #Load my preferred modules
    module load GNU/6.2
    module unload Python
    module load Python3/3.5.0
    module load git/2.9.0
    #module load NumPy
    #module load SciPy
    #module load matplotlib
    #module load iPython
fi
