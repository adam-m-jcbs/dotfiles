#!/bin/bash

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

  # Aliases
  alias ls='ls --color --group-directories-first'
fi

#dtn (data transfer nodes) preferences
if [ `expr match "$HOSTNAME" 'dtn'` -gt 0 ] 
then
  echo ".bash_profile: Executing dtn login shell preferences"

  #Load my preferred modules for dtn
  module load globus

  # Aliases
fi

#rhea preferences
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

  # Aliases

  # Doesn't seem to source .bashrc automatically on Rhea
  source .bashrc
fi

#summitdev preferences
if [ `expr match "$HOSTNAME" 'summitdev'` -gt 0 ] 
then
  echo ".bash_profile: Executing summitdev login shell preferences"

  #Load my preferred modules
  module load pgi/17.4

  # Aliases

  # Doesn't seem to source .bashrc automatically on summitdev
  source .bashrc
fi



#Common for all hosts
