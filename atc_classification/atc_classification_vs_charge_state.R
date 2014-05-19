
library(ggplot2)
library(reshape2)

wordwrap<-function(x,len) paste(strwrap(x,width=len),collapse="\n")

doPlot<-function(){
	a = read.csv("atc_level_1_summary.csv",header=TRUE)
	nn = sapply(a$ATC,wordwrap,len=20)
	aa = melt(a,id.vars=1)
	ggplot(data=aa,aes(x=ATC,y=value,fill=variable)) + geom_bar(stat="identity",position=position_dodge(),colour="black") + scale_x_discrete(labels = nn) + ylab("Fraction") + scale_fill_manual(values=c("violetred1","lightblue","grey","mediumorchid1")) + theme_bw() + theme(axis.text.x = element_text(angle = 45,hjust=1)) + theme(legend.title=element_blank()) + xlab("ATC Code") 
}

