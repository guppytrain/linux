#!/bin/sh

# docker related
# Usage: $0 {0|c|i|ils|cls|clsall|r|e|ri|ei|rsh|rbash|esh|ebash|prc|pri|prall}

	case "$1" in
		0)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker $2 $3 $4 $5 $6 $7 $8
			;;
		c)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker container $2 $3 $4 $5 $6 $7 $8
			;;
		i)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker image $2 $3 $4 $5 $6 $7 $8
			;;
		ils)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker image ls $2 $3 $4 $5 $6 $7 $8
			;;
		cls)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker container ls $2 $3 $4 $5 $6 $7 $8
			;;
		call)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			sudo docker container ls --all
			;;
		r)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
			
			if [ ! -z $2 ]; then
				sudo docker run $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		e)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker exec $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ri)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker run -it $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ei)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker exec -it $2 $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		rsh)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker run -it $2 sh $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		rbash)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker run -it $2 bash $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		esh)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker exec -it $2 sh $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
		ebash)
			echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"

			if [ ! -z $2 ]; then
				sudo docker exec -it $2 bash $3 $4 $5 $6 $7 $8
			else
				echo "Expected argument: \$2:<image name>"
			fi
			;;
        cpr)
            echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
            sudo docker container prune -f
            ;;
        ipr)
            echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
            IDS="$(sudo docker image ls --format "{{.Repository}} {{.ID}} -" | grep '<none>' | awk '{print $2}' | tr '\n' ' ')"
            [ -n "$IDS" ] && sudo docker image rm -f $IDS
            ;;
        prall)
            echo $"sd(sudo docker) $1 $2 $3 $4 $5 $6 $7 $8"
            sudo docker container prune -f
            IDS="$(sudo docker image ls --format "{{.Repository}} {{.ID}} -" | grep '<none>' | awk '{print $2}' | tr '\n' ' ')"
            [ -n "$IDS" ] && sudo docker image rm -f $IDS
            ;;
		*)
			echo $"Usage: $0 {c|i|ils|cls|clsall|r|e|ri|ei|rsh|rbash|esh|ebash|prc|pri|prall}"
			# exit 1
	esac



