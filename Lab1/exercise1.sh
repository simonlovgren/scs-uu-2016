#!/usr/bin/env bash

IP=$1

if ! [ -z $IP ]; then
    echo "# nmap $IP"
    nmap $IP
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# nmap $IP > scan.txt"
    nmap $IP > scan.txt
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt"
    cat scan.txt
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt | grep \"report\""
    cat scan.txt | grep "report"
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt | grep \"report\" | cut -d \" \" -f 5"
    cat scan.txt | grep "report" | cut -d " " -f 5
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt | grep \"report\" | cut -d \" \" -f 5 | sort"
    cat scan.txt | grep "report" | cut -d " " -f 5 | sort
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt | grep \"report\\|open\" | cut -d \" \" -f 5"
    cat scan.txt | grep "report\|open" | cut -d \" \" -f 5
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
    echo "# cat scan.txt | grep \"report\\|open\" | cut -d \"/\" -f 1 | cut -d \"r\" -f 4 | cut -d \" \" -f 2"
    cat scan.txt | grep "report\|open" | cut -d "/" -f 1 | cut -d "r" -f 4 | cut -d " " -f 2
    echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"
    
else
    echo "Missing IP address"
    echo "Usage: $0 10.0.1.0-255"
fi
