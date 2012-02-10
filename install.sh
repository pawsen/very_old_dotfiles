#!/bin/bash

#	copying files from this folder(dotfiles) to 
#	to the home directory


update () {
    file="$@"

    # dont copy these files
    case $file in
        "install.sh" | "update.sh")
            return
            ;;
    esac

    base_file=~/.$file
    # check if file exist and then if they are equal dont do any thing
    if [ -f "$base_file" ]; then
        if diff "$base_file" "$file" > /dev/null; then
            # File did not change
            #echo "Skipped $file"
            return
        fi
    fi
    
    if [ -d "$base_file" ]; then
        # Dirs are handled recursively
        #echo "Recursively updating $file..."
	    dirupdate $file/
	    return
    fi

    # if $file is not a directory and not equal to an existing file
    # then the file is copyied. Note this overwrite an existing file
	echo "Copying $file" >& 2
	cp -R "$file" "$base_file"
	return

}


dirupdate () {
    for file in ${@}*; do
	    case $file in
	        gitup)
		        continue
		        ;;
	    esac # end case

	    update "$file"
    done
}


dirupdate
