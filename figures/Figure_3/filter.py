#!/usr/bin/env python

import pandas as pd

df = pd.read_csv("target_class_combined_lt_5000.csv")
lt100 = df[(df.VAL <= 100) & (df.OP == "=")]
lt100.to_csv("target_class_combined_lt_100.csv")


