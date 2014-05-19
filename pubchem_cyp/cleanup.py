#!/usr/bin/env python

import glob
import os
import csv
import collections
import numpy as np

header = ["NAME","VAL"]

for fileName in glob.glob("../p450*Potency.csv"):
    dataDict = collections.defaultdict(list)
    outFileName = os.path.split(fileName)[1]
    writer = csv.writer(open(outFileName,"w"))
    writer.writerow(header)
    for line in open(fileName):
        toks = line.split()
        smiles,name,val = toks
        val = float(val)
        dataDict[name].append(val)
    for k,v in dataDict.iteritems():
        writer.writerow([k,np.mean(v)])
    


