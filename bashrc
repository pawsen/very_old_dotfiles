#!/bin/bash

source ${HOME}/.bash.d/functions      # Shell functions
source ${HOME}/.bash.d/alias
source ${HOME}/.bash.d/git-completion.bash

#export HISTCONTROL=erasedups
export HISTCONTROL="ignoredups" # don't put duplicate lines in the history
export HISTSIZE=10000
export HISTIGNORE='ls:bg:fg:history' #ignore these commands

# set default editor. NB kræver at emacs --deamon kører i baggrunden
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
export SUDO_EDITOR="emacsclient -c -a nano"

# Path
export PATH=$PATH:~/bin:~/.scripts # flere sti'er adskilles med colon, fx: "~/.bin:~/.bin/Gentoo"
export PATH=/usr/lib/colorgcc/bin:$PATH
# Set variables
# pgplot
export PGPLOT_DIR=~/documents/Dropbox/Bachelor/fortran/fem_gfortran/lib/pgplot
export PGPLOT_DEV=/xwin
PGPLOT_FONT=/home/paw/documents/Dropbox/Bachelor/fortran/fem_gfortran/lib/pgplot_gfortran/grfont.dat
export PGPLOT_FONT

export MATLAB_JAVA=/usr/lib/jvm/java-6-openjdk/jre/
export BROWSER=chromium

export export PYMACS_PYTHON=python2
export python=python2

#if [ -n "$SSH_CLIENT" ]; then
#    #PS1='\[\e[0;33m\]\u@\h:\wSSH$\[\e[m\] '
#    PS1='\[\e[0;32m\][\u@\h \W]\$\[\e[0m\] '
#else
#    PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
#    #PS1='[\u@\h \W]\$ '
#fi

