# add to path if not already exist
addpath () 
{
    if [ -n "$1" ]; then
		found="$(echo $PATH | grep $1)"

		if [ -z "$found" ]; then
			# echo "Adding path \"$1\""

			if [ -n "$2" ]; then
				if [ "$2" = "tail" ]; then
					PATH="$PATH:$1" 
				else
					PATH="$1:$PATH"
				fi
			else
				PATH="$1:$PATH"
			fi
		# else
			# echo "\"$1\" already in \$PATH"
		fi
    fi
}

