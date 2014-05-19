
showPlots<-function(dataFile,chargeFile,title){
	p = read.csv(dataFile,header=TRUE,row.names=1)
	cs = read.csv(chargeFile,header=TRUE,row.names=1)
	data =merge(p,cs,by=0)
	boxplot(VAL~STATE_10,data,names=c("Acidic","Basic","Neutral","Zwitterionic"),xlab="10% Ionized",col=c("red","lightblue","grey","purple"),varwidth=FALSE,ylab=title)
	boxplot(VAL~STATE_50,data,names=c("Acidic","Basic","Neutral","Zwitterionic"),xlab="50% Ionized",col=c("red","lightblue","grey","purple"),varwidth=FALSE,ylab=title)
	boxplot(VAL~STATE_90,data,names=c("Acidic","Basic","Neutral","Zwitterionic"),xlab="90% Ionized",col=c("red","lightblue","grey","purple"),varwidth=FALSE,ylab=title)
}