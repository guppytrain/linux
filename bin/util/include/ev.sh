# print out variable values in a "eager to find anything that matches" manner
ev () 
{
    # echo "Handling \$1=\"$1\""

    local a=${1^^}
    local b=${1,,}
    local c=${1^}
   
    local va=$(eval "echo ${a/#/$}")
    local vb=$(eval "echo ${b/#/$}")
    local vc=$(eval "echo ${c/#/$}")

    local v=

    echo "${v:-${va:-${vb:-${vc:-}}}}"
}

