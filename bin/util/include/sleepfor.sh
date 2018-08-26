# sleep for n seconds and print a progress indicator
sleepfor () 
{
    local count="${1:-5}"
    local marker=" ${2:-"."} " # ensure spaces on both sides

    while [ "$(( count-- ))" -gt 0 ]; 
    do 
        printf "${marker}"
        sleep 1
    done
    
    echo ""
}
