#!/usr/bin/python

import sys
import os

def main():
    dsym_path = os.popen("find . -name %s" % (sys.argv[1], )).read().strip()

    os.system("xcrun atos -o %s -arch arm64 -l %s %s" % (dsym_path, sys.argv[2], sys.argv[3]))

if __name__ == '__main__':
    if len(sys.argv) < 4:
        print("run '%s image_name base_addr symbol_addr' under dSYM directory" % sys.argv[0])
        exit(-1)

    main()
