#!/usr/bin/env python

import sys
import pandas as pd

origDf = pd.read_csv(sys.argv[1])
newDf = pd.read_csv(sys.argv[2])
comboDf = pd.merge(origDf,newDf,on="ID")
comboDf["LOGP_COLOR"] = pd.cut(comboDf["CLOGP"],[-1000,3,5,10000],labels=["green","yellow","red"])
comboDf["MW_COLOR"] = pd.cut(comboDf["MW"],[-1000,400,500,10000],labels=["green","yellow","red"])
comboDf["LOGD_COLOR"] = pd.cut(comboDf["logD"],[-1000,2,4,10000],labels=["green","yellow","red"])
comboDf.to_csv(sys.argv[3],index=False)
