#!/usr/bin/env python

import sys
import MySQLdb
import csv
import numpy as np
import pandas as pd
from scipy import stats


def grabData(cursor,sql):
    cursor.execute(sql)
    return [row for row in cursor]

sqlTmplt = """select cs.canonical_smiles, cs.molregno, act.standard_relation, act.published_value, act.published_units, cp.acd_most_apka, cp.acd_most_bpka
from activities act                                                                                                             join compound_structures cs                                                                                                   
on act.molregno = cs.molregno
join compound_properties cp  
on cs.molregno = cp.molregno                                                                                                   
where assay_id = %s and published_value is not null"""

header = ["SMILES","MOLREGNO","OP","VAL","UNITS","ApKa","BpKa"]

db = MySQLdb.connect(host='localhost', db = 'chembl_17', user='pwalters', passwd='vertex')
cursor = db.cursor()

dataList = []
reader = csv.reader(open(sys.argv[1]))
for idx,row in enumerate(reader):
    if idx > 0:
        assayId,assayName,numMols = row
        print assayId
        query = sqlTmplt % (assayId)
        res = grabData(cursor,query)
        if len(res) > 200:
            csvFileName = "%s.csv" % (assayId)
            writer = csv.writer(open(csvFileName,"w"))
            for row in res:
                writer.writerow(row)

