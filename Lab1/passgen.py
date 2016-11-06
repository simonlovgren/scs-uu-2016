#!/usr/bin/env python

import os
import sys
import getopt
import random
import math

# SETTINGS
script_name = "passgen.py"
num_words = 4

def countLines(f):
    '''
    Function to count number of lines in file

    Sig:     string => int
    Pre:     f is name of- and path to a readable file
    Returns: counted lines in file
    '''
    lines = 0
    with open(f,'r') as fh:
        for l in fh:
            lines += 1
    return lines

def passwordInfo(pwdgen):
    '''
    Prints password/phrase and entropy info

    sig: (string => string)
    '''
    def decorator(f):
        global num_words

        # Generate password
        password = pwdgen(f)

        # Calculate entropy of password
        # num_words randomly selected words from
        # dictionary of length dic_len
        dic_len = countLines(f)
        entropy = num_words * math.log(dic_len,2)
        
        # Reverse-calculation from entropy to number
        # of characters needed from [a-zA-Z0-9] for
        # same entropy
        # TODO: How to round?
        numchars = math.ceil(entropy * math.log(2,62))
        
        # Print info
        print(password)
        # Todo: better handling of repeated countLines
        print("{0} RANDOM words from word list [{1}] of {2} words".format(num_words,os.path.basename(f), dic_len))
        print("Entropy: ~{0} bits".format(int(round(entropy))))
        print("You need {0} RANDOM characters in [a-zA-Z0-9] to get the same entropy.".format(int(numchars)))
        print("")

    return decorator
        
@passwordInfo
def genPassword(dic):
    '''
    Function to generate a password/phrase of random
    words from supplied dictionary file.

    Sig: string => string
    Pre: dic is an existing readable file with words
         separated by newline
    Returns: string: string with num_words randomly selected files
    '''
    global num_words
    # Count number of selectable words in dictionary
    dic_size = countLines(dic)
    # Randomly select num_words lines
    selected = []
    i = 0
    random.seed()
    while i<num_words:
        selected.append(random.randint(0,dic_size))
        i += 1
    # Sort selected lines ASC for efficiency
    selected.sort()
    words = []
    with open(dic, 'r') as fh:
        i = 0
        for l in fh:
            if len(selected) == 0:
                break
            if i == selected[0]:
                words.append(l.strip())
                selected = selected[1:]
            i += 1

    # Join words on spaces
    return ' '.join(words)
    

def main(argv):
    files = parseOpts(sys.argv)

    for f in files:
        # Variant: len(files)-1
        if os.path.isfile(f):
            genPassword(f)
        else:
            print('file not found: [{0}]\nskipping...'.format(f))
            
def parseOpts(argv):
    '''
    Function for parsing arguments from command line.
    
    Sig:  string[0..n] => string[0..m]
    Pre:  argv is an array with all command line options (incl. file name)
    '''
    global script_name, num_words

    # Get name of script
    script_name = os.path.basename(argv[0])
    
    #Extract options and arguments
    try:
        opts, args = getopt.getopt(argv[1:], "hw:", ["help"])
    except Exception:
        print("Bad- or missing argument(s)")
        printHelp(1)

    # Parse options
    for opt, arg in opts:
        # variant: len(opts)-1
        if opt == "--help" or opt == "-h":
            printHelp(0)
        if opt == "-w":
            try:
                num_words = int(arg)
            except Exception:
                print("Bad argument [-w]")
                printHelp(1)
        
    # Check arguments match expected number
    if len(args) < 1:
        printHelp(1)

    return args
                
def printHelp(status):
    global script_name
    print "usage: python " + script_name + " [-wh] dictionary [dictionary]\n"
    print "  -w\t\tnumber of words in generated password"
    print "  -h, --help\tprint this help-text"
    
    sys.exit(status)

if __name__ == "__main__":
    main(sys.argv)
