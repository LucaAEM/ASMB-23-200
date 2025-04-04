detach("package:fpp", unload=TRUE)
detach("package:wmtsa", unload=TRUE)
detach("package:waveslim", unload=TRUE)

library(wavelets)
library(fBasics)
     
 #1 Dataset
  
a  <- read.csv("Data_1.csv", fill = TRUE, sep=";", header = F) 
     g <-  unlist(  a     ) 
  head(g)
  length(g)
  
  s  <-  matrix(NA,  length(g), 1 )
 
  for( j in 1: length(g)  )  {
  s[j]  <-  as.numeric(    as.vector(   g[[j]]     ) )

   }

  dim(s)
  head(s)

   head(s[-1])

    w  <- s[-1]

   ####plot.modwt 

######### MRA

 		index 	<-   w[1:1000] 
		n.levels 	=  5
  		index.la8 <- modwt(index,  filter="la8", n.levels = n.levels ,  boundary = "periodic" ) 

    				# Graph of the considered index 

		par(mfcol=c(n.levels +2,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(index, axes=FALSE, ylab="", main=   paste(  "50 seconds"  )    )
		for(i in 1:(n.levels )  )
  		plot.ts(getSlot(index.la8,"W")[[i]], axes=FALSE, ylab=names(  getSlot(index.la8,"W") )[[i]],
		abline(v =  , col=2),
		abline(v = 222 , col=2) )
		 
		abline(v =  , col=2)
		abline(v =  , col=2)
		abline(v =  , col=3)
 		plot.ts(getSlot(index.la8,"V")[[i]], axes=FALSE, ylab=names(  getSlot(index.la8,"V") )[[i]]  )
		axis(side=1, at=seq(0,length(w ),by=67 ))

		W1 <- index.la8@W[[ 1 ]]
 		W2 <- index.la8@W[[ 2 ]]
 		W3 <- index.la8@W[[ 3 ]]
  		W4 <- index.la8@W[[ 4 ]]
 		W5 <- index.la8@W[[ 5 ]]
 		V5 <- index.la8@V[[ 5 ]] 





########  S U P P R E S S I N G   W_j

 
		 index.la8@W[[1 ]]   <- NULL   # this instruction sequencially delete the first component
						       # each time is pressed
 	names(index.la8@W)

   		 ts.plot(imodwt( index.la8 ), ylim=c(-1.5,.5) )
		 lines(index, col=4)



 index.la8@W[[4]]  <- NULL
   		 ts.plot(imodwt( index.la8 ), ylim=c(-2,.5) )
		 lines(index, col=4)





		 
		 
		 
		 
		 
 









