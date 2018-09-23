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
        printf "%s\n\n%s\n" "[Timestamp: $(date)]" "$(./$f)" > "$STATUS_DIR/${f}.out" 2>"$STATUS_DIR/${f}.err"

        # echo "Profile Job:"
        # echo "$f"
        # echo "$STATUS_DIR/${f}.out"
        # echo "$STATUS_DIR/${f}.err"
    done
fi

ONCE_JOBS_DIR="$SHARE_DIR/jobs/once"

if [ -d "$ONCE_JOBS_DIR" ]; then
    cd $ONCE_JOBS_DIR

    [ ! -d "$STATUS_DIR" ] && mkdir $STATUS_DIR

    # run jobs and update in .status, and move them there as well
    files=()
    for f in $(ls -Ap ./ | grep -v /); do 
        printf "%s\n\n%s\n" "[Timestamp: $(date)]" "$(./$f)" > "$STATUS_DIR/${f}.out" 2>"$STATUS_DIR/${f}.err"
        
        # echo "Profile Job:"
        # echo "$f"
        # echo "$STATUS_DIR/${f}.out"
        # echo "$STATUS_DIR/${f}.err"

        files+=("${f}")
    done

    # remove all onces jobs
    for f in "${files[@]}"; do
        # echo "$f"
        mv "${f}" "$STATUS_DIR/${f}"

    done
fi

