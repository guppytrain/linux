# get starbux ip 

sbux_ip="$(ip route | sed -n '1 s/default via\s//; 1 s/\s.*$//; 1 s/\(.\+\)/\1\taruba.odyssys.net\n/p')"

echo $sbux_ip

# eval "sed -i '1 i $sbux_ip\n' /etc/hosts"


