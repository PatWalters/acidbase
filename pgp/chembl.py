#!/usr/bin/env python

import sys
import MySQLdb
import csv

class ChEMBL:
    def __init__(self):
        self.db = MySQLdb.connect(host='localhost', db = 'chembl_18', user='chembluser', passwd='chemblpass')
        self.cursor = self.db.cursor()

    def execute(self,query):
        self.cursor.execute(query)
        return [x for x in self.cursor]

    def getStructuresAndData(self,assayList):
        query = """select canonical_smiles,cs.molregno,chembl_id,standard_relation,standard_value,standard_units
        from activities act
        join compound_structures cs on (cs.molregno = act.molregno)
        join assays ass on (ass.assay_id = act.assay_id)
        where chembl_id in (%s) """ % ",".join(["'%s'" % x for x in assayList])
        self.cursor.execute(query)
        return [x for x in self.cursor]


if __name__ == "__main__":
    chembl = ChEMBL()
    writer = csv.writer(sys.stdout)
    for row in  chembl.getStructuresAndData(['CHEMBL2449559','CHEMBL914418']):
        writer.writerow(row)
#    print chembl.execute("select distinct level2_description from atc_classification where level2 = 'L02'")
    
        
