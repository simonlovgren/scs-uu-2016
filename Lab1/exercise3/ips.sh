#!/usr/bin/env bash

# Check if first argument is not zero (empty)
if ! [ -z $1 ]; then
    # Chech if file in argument 1 exists
    if [ -f $1 ]; then
        # Loop for each row in file, extracting each
        # row to a variable called name
        for name in $(cat $1); do
            # Resolve IP address of each host by calling
            # the progam 'host', supplying the hostname
            # extracted from the supplied file
            #
            # Grep all lines with an address, reverse as address
            # is always last, but IPv6 lines has one more word.
            # Cut with delimiter as whitestpace and extract first
            # field, then (re-)reverse the text. Lastly sort for
            # unique IP:s
            host $name | grep address | rev | cut -d " " -f 1 | rev
        done
    else
        # Argument given, but file does not exist
        # Print error message and usage.
        echo "[$1] does not exist."
        echo "Please select an existing file"
        echo "Usage: $(basename $0) [file]"
        # Exit with error (value != 0)
        exit 1
    fi
else
    # Missing argument, print error message
    # and usage of script
    echo "Missing argument"
    echo "Usage: $(basename $0) [file]"
    # Exit with error (value != 0)
    exit 1
fi
