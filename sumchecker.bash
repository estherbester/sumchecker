#!/bin/bash


SAVEIFS=$IFS
IFS=$(echo -en "\n\b") # to read files with whitespace in them

if [ $# -ne 1 ]; 
then
echo "Specify directory like this: $0 DirectoryName"
else

pushd $1
directory=`basename $1`

`date >> md5sums_for_"$directory".txt`
for file in `find . -maxdepth 1` # modify this to sumcheck files in subdirectories.
do
   f=$(file "$file")
   if [ -f "$file" ];
   then
        echo "Processing  "$file" ..."; # or whatever you want to do
        `openssl dgst -md5 "$file" >> md5sums_for_"$directory".txt`
   else
        echo "skipping "$file"..."
    fi
done

echo "Done! Open md5sums.txt in $1 to view checksums."

popd
fi

# restore $IFS
IFS=$SAVEIFS