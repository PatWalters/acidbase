plotData<-function(fileName,title,yAxisLabel,colorCol,ylimVals=NA,doLog=FALSE){
	d = read.csv(fileName,header=TRUE)
	d = d[complete.cases(d),]
	countList = as.numeric(summary(d$STATE_50))
	countList = format(countList,big.mark=",",scientific=FALSE)
	colorList = as.character(d[colorCol][,1])
	labelList = c(paste("Acidic\n",countList[1],sep=""),paste("Basic\n",countList[2],sep=""),paste("Neutral\n",countList[3],sep=""),paste("Zwitterionic\n",countList[4],sep=""))
	if (!is.na(ylimVals)){
			beeswarm(VAL~STATE_50,d,method="hex",las=1,corral="gutter",pwcol=colorList,pch=16,ylab=yAxisLabel,labels=labelList,xlab="",main = title,ylim=ylimVals,log=doLog)		
		} else  {
			beeswarm(VAL~STATE_50,d,method="hex",las=1,corral="gutter",pwcol=colorList,pch=16,ylab=yAxisLabel,labels=labelList,xlab="",main = title,log=doLog,cex=0.5)		
		}
	bxplot(VAL~STATE_50,d,log=FALSE,add=TRUE)		
	pwwt = pairwise.wilcox.test(d$VAL,d$STATE_50)
	print(pwwt)
	return(pwwt)
}

plotStatsMatrix<-function(mwwt,leftMargin,rightMargin){
	pv = mwwt$p.value
	pv = pv[!is.na(pv)]
	tv = pv < 0.05
	p1X = c(0.5,0.5,0.5,1.5,1.5,2.5)
	p1Y = c(2.5,1.5,0.5,1.5,0.5,0.5)
	p2X = c(1.5,2.5,3.5,2.5,3.5,3.5)
	p2Y = c(3.5,3.5,3.5,2.5,2.5,1.5)
	par(fig=c(leftMargin,rightMargin,0.0,0.35), new=TRUE)
	plot(0:4,0:4,type="n",xaxt="n",yaxt="n",xlab="",ylab="",bty="n")
	abline(v=c(0,1,2,3,4))
	abline(h=c(0,1,2,3,4))
	axis(2,at=c(0.5,1.5,2.5,3.5),labels=c("Zwitterionic","Neutral","Basic","Acidic"),las=1,lwd=0) 
	points(p1X[tv],p1Y[tv],pch=16)
	points(p2X[tv],p2Y[tv],pch=16)
}

beeswarmWithStats<-function(fileName, title, yLabel, colorCol,position = 1, ylimVals = NA,doLog=FALSE){
	oldMar = par("mar")
	if (position == 1) {
		leftMargin = 0.0
		rightMargin = 0.5
	} else {
		leftMargin = 0.5
		rightMargin = 1.0
	}

	par(mar=c(1.8,7.1,4.1,2.1))
	if (position == 1) {
		plot.new()
	}
	par(fig=c(leftMargin,rightMargin,0.25,1.0), new=TRUE)
	mwwt =plotData(fileName,title,yLabel,colorCol,ylimVals,doLog)
	plotStatsMatrix(mwwt,leftMargin,rightMargin)
	par(mar=oldMar)
}



