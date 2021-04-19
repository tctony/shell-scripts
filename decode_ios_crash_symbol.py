#!/usr/bin/python

import sys
import os

def main():
    dsym_path = os.popen("find . -name %s" % (sys.argv[2], )).read().strip()
    os.system("xcrun atos -o %s -arch %s -l %s %s" % (dsym_path, sys.argv[1], sys.argv[3], sys.argv[4]))

if __name__ == '__main__':
    if len(sys.argv) < 5:
        print("run '%s arch image_name base_addr symbol_addr' under dSYM directory" % sys.argv[0])
        exit(-1)

    main()
