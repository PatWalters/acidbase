library(beeswarm)
source("../lib/beeswarm_with_stats.R")
x = beeswarmWithStats("hepatic_merged_desc.csv","Hepatic Clearance\nColored by CLogD","Clearance (ml/min/kg)","LOGD_COLOR",1,c(0,100))
x = beeswarmWithStats("renal_merged_desc.csv","Renal Clearance\nColored by CLogD","Clearance (ml/min/kg)","LOGD_COLOR",2,c(0,20))
x = beeswarmWithStats("hepatic_merged_desc.csv","Hepatic Clearance\nColored by CLogP","Clearance (ml/min/kg)","LOGP_COLOR",1,c(0,100))
x = beeswarmWithStats("renal_merged_desc.csv","Renal Clearance\nColored by CLogP","Clearance (ml/min/kg)","LOGP_COLOR",2,c(0,20))
x = beeswarmWithStats("hepatic_merged_desc.csv","Hepatic Clearance\nColored by Molecular Weight","Clearance (ml/min/kg)","MW_COLOR",1,c(0,100))
x = beeswarmWithStats("renal_merged_desc.csv","Renal Clearance\nColored by Molecular Weight","Clearance (ml/min/kg)","MW_COLOR",2,c(0,20))



