#!/bin/sh

# docker related
# Usage: $0 {0|c|i|ils|cls|clsall|r|e|ri|ei|rsh|rbash|esh|ebash|prc|pri|prall}

	case "$1" in
		0)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker $2 $3 $4 $5 $6 $7 $8
			;;
		c)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker container $2 $3 $4 $5 $6 $7 $8
			;;
		i)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker image $2 $3 $4 $5 $6 $7 $8
			;;
		ils)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker image ls $2 $3 $4 $5 $6 $7 $8
			;;
		cls)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker container ls $2 $3 $4 $5 $6 $7 $8
			;;
		call)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			docker container ls --all
			;;
		r)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
			
			if [ ! -z $2 ]; then
				docker run $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		e)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker exec $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ri)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker run -it $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ei)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker exec -it $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		rsh)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker run -it $2 $3 $4 $5 $6 $7 $8 sh
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		rbash)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker run -it $2 $3 $4 $5 $6 $7 $8 bash
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		esh)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker exec -it $2 $3 $4 $5 $6 $7 $8 sh
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ebash)
			echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				docker exec -it $2 $3 $4 $5 $6 $7 $8 bash
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
        cpr)
            echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
            docker container prune -f
            ;;
        ipr)
            echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
            IDS="$(docker image ls --format "{{.Repository}} {{.ID}} -" | grep '<none>' | awk '{print $2}' | tr '\n' ' ')"
            [ -n "$IDS" ] && docker image rm -f $IDS
            ;;
        prall)
            echo $"sd(docker) $1 $2 $3 $4 $5 $6 $7 $8"
            docker container prune -f
            IDS="$(docker image ls --format "{{.Repository}} {{.ID}} -" | grep '<none>' | awk '{print $2}' | tr '\n' ' ')"
            [ -n "$IDS" ] && docker image rm -f $IDS
            ;;
		*)
			echo $"Usage: $0 {c|i|ils|cls|clsall|r|e|ri|ei|rsh|rbash|esh|ebash|prc|pri|prall}"
			# exit 1
	esac



