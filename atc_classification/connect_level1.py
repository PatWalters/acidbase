#!/usr/bin/env python

import sys
sys.path.append("../lib")

import csv
from chembl import ChEMBL
from collections import defaultdict
import pandas as pd
import numpy as np

def getVal(x):
    if type(x) == pd.core.series.Series:
        return list(x)[0]
    else:
        return x

def getChargeValues(df,idx):
    chargeState = df['STATE_50']
    acid = df['ACIDIC']
    base = df['BASIC']
    cs,a,b = [getVal(x) for x in [chargeState[idx],acid[idx],base[idx]]]
    a = None if (a == np.nan or a > 7.4) else a
    b = None if (b == np.nan or b < 7.4) else b
    return [cs,a,b]
    

def getATCDescription(db,code):
    sql = "select distinct level1_description from atc_classification where level1 = '%s'" % (code)
    res = db.execute(sql)
    return res[0][0]

df = pd.read_csv("atc_classification.charge_state",index_col='NAME')

chemblDb = ChEMBL()

atcDict = defaultdict(list)
reader = csv.reader(open("atc_classification_level_1.csv"))
for row in reader:
    smiles,name,atc = row
    level2atc = atc[0:1]
    atcDict[level2atc].append([smiles,name])

output = []
for k,v in atcDict.iteritems():
    output.append([k,len(v),v,getATCDescription(chemblDb,k)])

output.sort(lambda a,b: cmp(b[1],a[1]))
output = output[0:10]

writer = csv.writer(open("atc_level_1_summary.csv","w"))
header = "ATC,ACIDIC,BASIC,NEUTRAL,ZWITTERIONIC".split(",")
writer.writerow(header)

atcDict = defaultdict(list)
for row in output:    
    for i in row[2]:
        rowIdx = int(i[-1])
        chgState,acid,base = getChargeValues(df,rowIdx)
        atcDict[getATCDescription(chemblDb,row[0])].append(chgState)

nameList = ['acidic','basic','neutral','zwiterionic']
for k,v in atcDict.iteritems():
    valueDict = dict((x, v.count(x)) for x in v)
    valueList = np.array([float(valueDict.get(x) or 0) for x in nameList])
    writer.writerow([k]+list(valueList/valueList.sum()))


    