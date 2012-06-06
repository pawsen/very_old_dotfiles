#!/bin/bash
# small script for backing up the server at HUS1, VJK


HOME="/home/paw"
# Save directories as an array instead of list(which is what you get when using DIR="$HOME/Musik/paw $HOME/...")
DIR=($HOME/dotfiles $HOME/documents $HOME/src $HOME/.ssh)
BACKUP=/media/backup/laptop
DST=$BACKUP/


#DIR is an array. Then we need to use [@] (or [*]) to get all elements
for dir in "${DIR[@]}"
do  
    #echo "$DST"
    #echo "${DIR[@]:0:1}"
    #echo "$dir"

    # #If dir is first entry in DIR, then change DST to musik directory.
    # if [ "$dir" = "${DIR[@]:0:1}" ]; then
    #     DST=$BACKUP/musik/
    # else
    #     DST=$BACKUP/
    # fi
 
   DST=$BACKUP/
    #create DST if not exist
    [ ! -d $DST ] && mkdir -p $DST || :
    rsync --delete --log-file=$BACKUP/logfile.txt -avz $dir $DST

done

