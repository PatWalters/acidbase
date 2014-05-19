#!/usr/bin/env python

import sys
import csv

reader = csv.reader(open(sys.argv[1]))
keyVal = int(sys.argv[2])
writer = csv.writer(sys.stdout)

keyDict = {}
for row in reader:
    valStr = row[keyVal]
    if keyDict.get(valStr) == None:
        keyDict[valStr] = True
        writer.writerow(row)
