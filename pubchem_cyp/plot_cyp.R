source("../lib/color_by_logd.R")

makePlot<-function(fileName,yAxisLabel){
	cs = read.csv("cyp_unique.charge_state",header=TRUE,row.names=1)
	v = read.csv(fileName,header=TRUE,row.names=1)
	csv = merge(cs,v,by=0)
	row.names(csv)=csv$Row.names
	csv = csv[,-1]
	l = read.table("cyp_unique.logd",header=TRUE,row.names=1)
	csvl = merge(csv,l,by=0)	
	csvlc = colorByLogD(csvl,2,4)
	print(dim(csvlc))
	beeswarm(VAL~STATE_50,csvlc,method="hex",corral="gutter",cex=0.75,pwcol=csvlc$COL,pch=16,xlab="",labels=c("Acidic","Basic","Neutral","Zwitterionic"),ylab=yAxisLabel,ylim=c(0,45))
	bxplot(VAL~STATE_50,csvlc,add=TRUE)
}

doPlots<-function(){
	names = c("CYP1A2 Inhibition (uM)","CYP2C9 Inhibition (uM)","CYP2D6 Inhibition (uM)","CYP3A4 Inhibition (uM)")
	fileList = c("p450-cyp1a2-Potency.csv","p450-cyp2c9-Potency.csv","p450-cyp2d6-Potency.csv","p450-cyp3a4-Potency.csv")
	idx = 1
     	for (fileName in fileList){
	print(fileName)
	makePlot(fileName,names[idx])
	idx = idx + 1
	}
}