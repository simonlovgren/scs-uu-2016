#!/usr/bin/env bash

# If first argument is not zero (empty)
if ! [ -z $1 ]; then
    # If file in argument 1 exists
    if [ -f $1 ]; then
        # Loop for each row in file, extracting each row to the variable
        # name
        for name in $(cat $1); do
            # Resolve IP address of each host
            host $name
            # Print delimiter (newline)
            echo ""
        done
    else
        # Argument given, but file does not exist
        echo "[$1] does not exist."
        echo "Please select an existing file"
        exit 1 # Exit with error value
    fi
else
    # Missing argument, print 'usage'
    echo "Missing argument"
    echo "Usage: $(basename $0) [file]"
    exit 1 # Exit with error value
fi
