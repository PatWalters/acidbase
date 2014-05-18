#!/usr/bin/env python

import sys
import csv

def calcPctIonized(state,pH,pKa):
    exp = pH - pKa
    ionized = 10**exp
    if state == "acidic":
        pctIonized = (ionized/(ionized+1))* 100
    elif state == "basic":
        pctIonized = (1/(ionized+1))* 100
    else:
        print >> sys.stderr,"%s is not a valid state" % state
    return pctIonized

pHmin = 2
pHmax = 11
reader = csv.reader(open("chembl_drugs.charge_state"))
chgDict = {"acidic":0,"basic":1}
header = ["NAME","STATE","pKa","pH","IONIZED"]
writer = csv.writer(open("chembl_drugs_ionized_vs_ph.csv","w"))
writer.writerow(header)
for idx,row in enumerate(reader):
    if idx > 0:
        name,acidic,basic,state_10,state_50,state_90 = row
        val = chgDict.get(state_50)
        if val is not None:
            pKa = float([acidic,basic][val])
            ionizedList = [[pH,calcPctIonized(state_50,pH,pKa)] for pH in range(pHmin,pHmax)]
            for p,i in ionizedList:
                writer.writerow([name,state_50,pKa,p,i])


    



        
        
        





