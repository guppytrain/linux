#!/bin/bash

# jobs directory
PROFILE_JOBS_DIR="$SHARE_DIR/jobs/profile"
STATUS_DIR=".status"

# run all profile jobs
if [ -d "$PROFILE_JOBS_DIR" ]; then
    cd $PROFILE_JOBS_DIR

    [ ! -d "$STATUS_DIR" ] && mkdir $STATUS_DIR

    # run jobs and update in .status
    for f in $(ls -Ap ./ | grep -v /); do 
        read -n 1 -e -p "Run job ${f} ? [Y/n]: "
        _reply="${REPLY:-Y}"
        reply="${_reply^^}"

        # echo "reply: $reply"

        # printf "%s\n\n%s\n" "[Timestamp: $(date)]" "$(. $f)" > "$STATUS_DIR/${f}.out" 2>"$STATUS_DIR/${f}.err"
        [ "$reply" = "Y" ] && "$(. "$f")" || echo "Skipping \"$f\""
     done
fi

ONCE_JOBS_DIR="$SHARE_DIR/jobs/once"

if [ -d "$ONCE_JOBS_DIR" ]; then
    cd $ONCE_JOBS_DIR

    [ ! -d "$STATUS_DIR" ] && mkdir $STATUS_DIR

    # run jobs and update in .status, and move them there as well
    files=()
    for f in $(ls -Ap ./ | grep -v /); do
        read -n 1 -e -p "Run job once ${f} ? [Y/n]: "
        _reply="${REPLY:-Y}"
        reply="${_reply^^}"

        # echo "reply: $reply"

        # printf "%s\n\n%s\n" "[Timestamp: $(date)]" "$(. $f)" > "$STATUS_DIR/${f}.out" 2>"$STATUS_DIR/${f}.err"
        [ "$reply" = "Y" ] && "$(. "$f")" || echo "Skipping \"$f\""
        
        files+=("${f}")
    done

    # remove all onces jobs
    for f in "${files[@]}"; do
        echo "Moving file ${f}"
        mv "${f}" "$STATUS_DIR/${f}"
    done
fi

