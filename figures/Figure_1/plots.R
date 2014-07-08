library(beeswarm)

d = read.csv("chembl_drugs_ionized_vs_ph.csv",header=TRUE)
d$COL = c("red","blue")[factor(d$STATE,levels=c("acidic","basic"))]
beeswarm(IONIZED~pH,d,method="hex",pch=16,cex=0.4,pwc=d$COL,corral="gutter",ylab="% Ionized")
