doPlot<-function(){
	cs = read.csv("pubchem_sol.charge_state",header=TRUE,row.names=1)
	v = read.csv("pubchem_sol.csv",header=TRUE,row.names=2)
	csv = merge(cs,v,by=0)
	row.names(csv) = csv$Row.names
	csv = csv[,-1]
	l = read.table("pubchem_sol.logd",header=TRUE,row.names=1)
	csvl = merge(csv,l,by=0)
	csvlc = colorByLogD(csvl,2,4)
	beeswarm(SOL~STATE_50,csvlc,method="hex",corral="gutter",cex=0.5,pwcol=csvlc$COL,pch=16,ylab="Log Solubility (uM)",xlab="")
}