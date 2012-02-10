# modified commands
#alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
#alias ..='cd ..'

source ${HOME}/.bash.d/functions      # Shell functions
source ${HOME}/.bash.d/alias

# new commands
#alias da='date "+%A, %B %d, %Y [%T]"'
#alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
#alias openports='netstat --all --numeric --programs --inet'
#alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg2'
fi

# ls
alias ls='ls -hF --color=always'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Original settings

# Check for an interactive session
#[ -z "$PS1" ] && return

#alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

complete -cf sudo # autocomplete i bash ved brug af sudo
# If a package in the list is already installed on the system, it will be reinstalled even if it is already up-to-date, unless you use the --needed option.
alias install='sudo pacman-color -S --needed'
alias installed='pacman-color -Qqs'
alias pacman='sudo pacman-color' # krĂŠver pacman-color pakken
alias clean='sudo pacman-color -Scc'
alias cleandeps='sudo pacman-color -Rns $(sudo pacman-color -Qdtq)'
alias info='pacman-color -Si'
alias upgrade='yaourt -Syu --aur'
alias matlab='matlab -desktop'

alias dtumnt='bash /home/paw/.scripts/dtumnt.sh'
alias dtuumnt='fusermount -u ~/dtumnt'

alias et='emacsclient -t -a nano'
# hvis emacs --daemon ikke kører, bruges nano i stedet
alias ef='emacsclient -c'

# pgplot
export PGPLOT_DIR=~/documents/Dropbox/Bachelor/fortran/fem_gfortran/lib/pgplot
export PGPLOT_DEV=/xwin

# set variabels for ifort, idb etc
source /opt/intel/bin/compilervars.sh intel64
# set variabels for intel math library
source /opt/intel/composer_xe_2011_sp1.6.233/mkl/bin/mklvars.sh intel64 mod

PGPLOT_FONT=/home/paw/documents/Dropbox/Bachelor/fortran/fem_gfortran/lib/pgplot_gfortran/grfont.dat
export PGPLOT_FONT

# custom set variabels
export MATLAB_JAVA=/usr/lib/jvm/java-6-openjdk/jre/
export BROWSER=chromium

# set default editor. NB kræver at emacs --deamon kűrer i baggrunden
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"

export HISTCONTROL="ignoredups" # don't put duplicate lines in the history
# Path
export PATH=$PATH:~/bin # flere sti'er adskilles med colon, fx: "~/.bin:~/.bin/Gentoo"
export PATH=/usr/lib/colorgcc/bin:$PATH

export export PYMACS_PYTHON=python2
export python=python2
