#!/bin/bash
COMMAND="xdg-email"
for file in "$@"
do
  COMMAND="$COMMAND --attach '$file'"
done
sh -c "$COMMAND"




#while (( $# )); do
#    ATTACH+= --attach \"$1\"
#    shift
#done
#echo "ATTACH: $ATTACH" 
#xdg-email $ATTACH

#!/bin/bash
#while (( $# )); do
#  DIRPATH=$(dirname "$1")
#  FILENAME=$(basename "$1" | sed 's@\.\([^\.]\+\)$@\.resized\.\1@')
  
#  /usr/bin/convert "$1" -resize 1200x800\> "${DIRPATH}/${FILENAME}"

#  shift
#done

