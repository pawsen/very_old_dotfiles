#!/bin/bash

# Use gimp to auto-crop an image
# From http://www.mail-archive.com/paraview@paraview.org/msg10402.html

if [ $# -ne 2 ] ; then
  echo "Usage: $0 infile outfile"
  exit 1
fi

gimp -i -b "(sq-auto-crop \"$1\" \"$2\")" -b '(gimp-quit 0)'

#EOF
