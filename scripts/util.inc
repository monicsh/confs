#!/bin/bash

AVAILABLE_CPUS=$(cat /proc/cpuinfo |grep processor|wc  -l)

# PREFIX, PATTERN_FILE, SUFFIX
function parse_folder_names()
{
    PREFIX=$1
    PATTERN_FILE=$2
    SUFFIX=$3
    shift 3

    while IFS='' read -r line || [[ -n "$line" ]]; do
        if [[ $line =~ ^# ]]; then
            echo ""             # skipping

        elif [[ $line == */* ]]; then
            let len=-1          # remove the CR from end
            if [[ $line =~ $'\r' ]]; then
                len=-2
            fi
            echo "$PREFIX${line::$len}$SUFFIX"
        fi

    done < "$PATTERN_FILE"
}
