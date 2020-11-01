#!/bin/bash

file="$1"

if ! [ -f "$file" ]; then
	echo "Le fichier $file n'existe pas"
	exit 1
fi

echo "#!/bin/bash" 1> semscript.sh
c=1
dir1=""
dir2=""
while IFS= read -r line
do
  	#echo "$line"
	if [ "$c" -eq 1 ] && ! echo "$line" | grep -q "^[a-zA-Z1-9 ]+$"; then
		dir1="$line"
		if [ -d "$line" ]; then
			echo "rm -rf $line" 1>> semscript.sh
		fi
			echo "mkdir $line" 1>> semscript.sh
	elif echo "$line" | grep -q "^[a-zA-Z1-9 ]+$"; then
		dir2="$line"
		echo "mkdir $dir1/$dir2" 1>> semscript.sh
	elif echo "$line" | grep -q ","; then
		echo ""
	fi
	((c=c+1))
done < "$file"
