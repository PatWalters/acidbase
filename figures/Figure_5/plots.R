source("../lib/beeswarm_with_stats.R")
x = beeswarmWithStats("pubchem_sol_combined_desc.csv","Aqueous Solubility\nColored by CLogD","Log Aqueous Solubility","LOGD_COLOR",1)
plot.new()
x = beeswarmWithStats("pubchem_sol_combined_desc.csv","Aqueous Solubility\nColored by CLogP","Log Aqueous Solubility","LOGP_COLOR",1)	
x = beeswarmWithStats("pubchem_sol_combined_desc.csv","Aqueous Solubility\nColored by Molecular Weight","Log Aqueous Solubility","MW_COLOR",2)


