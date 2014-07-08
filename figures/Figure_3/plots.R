library(ggplot2)
library(reshape2)

# Multiple plot function from http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

doPlot<-function(fileName,plotTitle){
        d = read.csv(fileName)
	d = d[d$TARGET_CLASS %in% c("Enzyme","Ion channel","Membrane receptor","Transporter"),]

	all = as.numeric(summary(d$STATE_50))
	numAll = sum(all)
	all = all/numAll
	allStr = paste("All\n",format(numAll,big.mark=",",scientific=FALSE),sep="")

	enz = as.numeric(summary(d[d$TARGET_CLASS == "Enzyme",]$STATE_50))
	numEnz = sum(enz)
	enz = enz/numEnz
	enzStr = paste("Enzyme\n",format(numEnz,big.mark=",",scientific=FALSE),sep="")

	mr = as.numeric(summary(d[d$TARGET_CLASS == "Membrane receptor",]$STATE_50))
	numMr = sum(mr)
	mr = mr/numMr
	mrStr = paste("Membrane Receptor\n",format(numMr,big.mark=",",scientific=FALSE),sep="")

	ic = as.numeric(summary(d[d$TARGET_CLASS == "Ion channel",]$STATE_50))
	numIc = sum(ic)
	ic = ic/numIc
	icStr = paste("Ion Channel\n",format(numIc,big.mark=",",scientific=FALSE),sep="")

	trn = as.numeric(summary(d[d$TARGET_CLASS == "Transporter",]$STATE_50))
	numTrn = sum(trn)
	trn = trn/numTrn
	trnStr = paste("Transporter\n",format(numTrn,big.mark=",",scientific=FALSE),sep="")

	tcDf = data.frame(rbind(all,enz,mr,ic,trn))
	names(tcDf) = c("Acidic","Basic","Neutral","Zwitterionic")
	row.names(tcDf) = c(allStr,enzStr,mrStr,icStr,trnStr)

	tcDf$target_class = row.names(tcDf)
	aa = melt(tcDf)
	g = ggplot(aa,aes(x=target_class,y=value,fill=variable)) + geom_bar(stat="identity",colour="black") + ylab("Fraction") + scale_fill_manual(values=c("violetred1","lightblue","grey","mediumorchid1")) + theme_bw() + theme(legend.title=element_blank()) + xlab("Target Class") + theme(axis.text.x = element_text(size=12,angle=45,hjust=1),axis.text.y = element_text(size=12)) + labs(title="Target Class")  + theme(legend.text = element_text(size=14)) + ggtitle(plotTitle)
	return(g)
}


plt5000 = doPlot("target_class_combined_lt_5000.csv","Activity Cutoff = 5uM")
plt100 = doPlot("target_class_combined_lt_100.csv","Activity Cutoff = 100nM")
multiplot(plt5000,plt100,cols=2)


