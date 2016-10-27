#!/usr/bin/env bash

# Pattern for single number of 1-3 digits
IP_NUM='[0-9]{1,3}'
# Pattern for single number of 1-3 (ex. 192) digits OR range
# of two numbers of 1-3 digits (192-196)
IP_NOR="$IP_NUM(-$IP_NUM)?"
# Match an IP Address (ex. 123.123.123.123) of IP Range
# (ex. 12-13.14-15.145-178.1-5)
IP_PATTERN="^$IP_NOR\.$IP_NOR\.$IP_NOR\.$IP_NOR$"


# This function takes an IP-address or range and
# a number denoting which dot-separated field to
# analyze (starting with 1).
#
# If the field contains only a number, the number
# is printed. If the field contains a range (eg. 123-134),
# it calls seq to produce- and print the range.
#
# To be used in for-loop.
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
# If first argument is not zero (empty)
if ! [ -z $1 ]; then
    # If file in argument 1 exists
    if [[ $1 =~ $IP_PATTERN ]]; then

        # Naive algorithm for generating IP addresses
        # FIRST (leftmost) field of IP
        for p1 in $(name_or_range $1 1); do
            # Fourth (rightmost) field of the IP
            for p2 in $(name_or_range $1 2); do
                # Fourth (rightmost) field of the IP
                for p3 in $(name_or_range $1 3); do
                    # Fourth (rightmost) field of the IP
                    for p4 in $(name_or_range $1 4); do
                        # Ping selected IP addresses (this is what
                        # we came here to do!)
                        ping -c 1 "$p1.$p2.$p3.$p4"
                    done
                done
            done
        done
        
    else
        # Bad rgument given
        echo "[$1] is not a valid IP of IP range."
        exit 1 # Exit with error value
    fi
else
    # Missing argument, print 'usage'
    echo "Missing argument"
    echo "Usage: $(basename $0) 123.123.123.123"
    exit 1 # Exit with error value
fi
