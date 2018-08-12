# print out variable values in a "eager to find anything that matches" manner
ev () 
{
    # echo "Handling \$1=\"$1\""

    local _a=${1^^}
    local _b=${1,,}
    local _c=${1^}
   
    local _va=$(eval "echo ${a/#/$}")
    local _vb=$(eval "echo ${b/#/$}")
    local _vc=$(eval "echo ${c/#/$}")

    local _v=

    echo "${_v:-${_va:-${_vb:-${_vc:-}}}}"
}

