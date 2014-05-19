
groupLogD<-function(df){
	df$LOGD_GRP = factor(cut(df$logD,breaks=c(-100,2,4,100),labels=c("low","med","high")),levels=c("low","med","high"))
	df$COL = c("green","yellow","red")[df$LOGD_GRP] 
	return(df)
}


cs = read.csv("chembl_pgp_inhib.charge_state",header=TRUE,row.names=1)
l = read.table("chembl_pgp_inhib.logd",header=TRUE,row.names=1)
csl = merge(cs,l,by=0)
row.names(csl)=csl$Row.names
csl = csl[,-1]
v = read.table("chembl_pgp_inhib.txt",header=TRUE,row.names=1)
v$VAL = v$VAL/1000
cslv = merge(csl,v,by=0)
cslv = groupLogD(cslv)
beeswarm(VAL~STATE_50,cslv,method="hex",corral="gutter",log=TRUE,pwcol=as.character(cslv$COL),pch=16,cex=0.75,labels=c("Acidic","Basic","Neutral","Zwitterionic"),xlab="",ylab="PGP EC50 uM",yaxt="n")
axis(2,at=c(1e-2,1e0,1e2),labels=c(0.01,1,100),las=1)
bxplot(VAL~STATE_50,cslv,log=TRUE,add=TRUE)



