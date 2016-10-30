#!/usr/bin/env bash

# Regex-Pattern for single number of 1-3 digits
IP_NUM='[0-9]{1,3}'
# Regex-Pattern for single number of 1-3 (ex. 192) digits OR range
# of two numbers of 1-3 digits (192-196)
IP_NOR="$IP_NUM(-$IP_NUM)?"
# Regex-pattern to Match an IP Address (ex. 123.123.123.123) or
# IP Range (ex. 12-13.14-15.145-178.1-5)
nIP_PATTERN="^$IP_NOR\.$IP_NOR\.$IP_NOR\.$IP_NOR$"


# Functions can be used to divide the script into
# smaller parts, which makes it easier to read and
# commands only need to be written once.
#
# This function takes an IP-address or range and
# a number denoting which dot-separated field to
# analyze (starting with 1).
#
# If the field contains only a number, the number
# is printed. If the field contains a range (eg. 123-134),
# it calls seq to produce- and print the range.
#
# To be used in for-loop for creating IP-section.
function name_or_range() {
    # Extract selected part from IP
    PART=$(echo $1 | cut -d "." -f $2)
    # Pattern for matching against a range/sequence
    SEQ_PATTERN="^$IP_NUM-$IP_NUM$"
    # If selected PART is a range/sequence 
    if [[ $PART =~ $SEQ_PATTERN ]]; then
        # Split on '-' char and feed both parts to seq
        seq $(echo $PART | cut -d "-" -f 1)  $(echo $PART | cut -d "-" -f 2)
    else
        # If only a number, print number.
        echo $PART
    fi
}

# MAIN 'PROGRAM'
# Check if first argument is not zero (empty)
if ! [ -z $1 ]; then
    # Check if argument matches pattern of an IP address
    # or IP range
    if [[ $1 =~ $IP_PATTERN ]]; then
        
        # Naive algorithm for generating IP addresses
        # Loop for each number of FIRST (leftmost) field of IP,
        # returned from our function name_or_range
        for p1 in $(name_or_range $1 1); do
            # Loop for each number of SECOND field of IP,
            # returned from our function name_or_range
            for p2 in $(name_or_range $1 2); do
                # Loop for each number of THIRD field of IP,
                # returned from our function name_or_range
                for p3 in $(name_or_range $1 3); do
                    # Loop for each number of FOURTH (rightmost) field of IP,
                    # returned from our function name_or_range
                    for p4 in $(name_or_range $1 4); do
                        # Ping selected IP addresses (this is what
                        # we came here to do!)
                        # Grep lines with responses and cut the
                        # IP from each line.
                        ping -c 1 "$p1.$p2.$p3.$p4" | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1
                    done
                done
            done
        done
        
    else
        # Bad rgument given, did not match IP-pattern
        # Print error and 'usage' of script
        echo "[$1] is not a valid IP of IP range."
        echo "Usage: $(basename $0) 123.123.123.123"
        echo "       $(basename $0) 123.123.123.100-123"
        # Exit with error (value != 0)
        exit 1
    fi
else
    # Missing argument, print error message
    # and 'usage' of script
    echo "Missing argument"
    echo "Usage: $(basename $0) 123.123.123.123"
    echo "       $(basename $0) 123.123.123.100-123"
    # Exit with error (value != 0)
    exit 1
fi
