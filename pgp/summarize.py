#!/usr/bin/env python

import sys
import csv
from collections import defaultdict
import numpy as np

valueDict = defaultdict(list)
reader = csv.reader(open("chembl_pgp_inhib.csv"))
for line in reader:
    smiles,molregno,chembl_id,op,val,units = line
    valueDict[molregno].append(float(val))
for k,v in valueDict.iteritems():
    print k,np.mean(v)
    
