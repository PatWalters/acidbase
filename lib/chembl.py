#!/usr/bin/env python

import MySQLdb

class ChEMBL:
    def __init__(self):
        self.db = MySQLdb.connect(host='localhost', db = 'chembl_18', user='chembluser', passwd='chemblpass')
        self.cursor = self.db.cursor()

    def execute(self,query):
        self.cursor.execute(query)
        return [x for x in self.cursor]


if __name__ == "__main__":
    chembl = ChEMBL()
    print chembl.execute("select distinct level2_description from atc_classification where level2 = 'L02'")
    
        
