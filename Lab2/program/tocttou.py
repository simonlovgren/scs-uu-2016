#!/usr/bin/env python
import sys, os

def main():
    # Check if filename supplied. Print error if not
    if len(sys.argv) != 2:
        print "usage: python {0} file.name".format(os.path.basename(sys.argv[0]))
        sys.exit(1)
    # Open file given by user
    with open(os.path.abspath(sys.argv[1]),'w') as f:
        # Wait for line of input, then write to file.
        # Append newline, as it is omitted when using
        # raw_input()
        f.write(raw_input())
        f.write('\n')

if __name__ == '__main__':
    main()
