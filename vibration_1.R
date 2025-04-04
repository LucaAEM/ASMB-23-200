

#install.packages("C:\\Users\\39331\\Downloads\\splus2R_1.3-4.tar.gz", repos = NULL, type = "source")
#install.packages("C:\\Users\\39331\\Downloads\\ifultools_2.0-26.tar.gz", repos = NULL, type = "source")

#install.packages("C:\\Users\\39331\\Downloads\\wmtsa_2.0-3.tar.gz", repos = NULL, type = "source")


library(fpp)   # To load the data set a10
library(wmtsa)
library(forecast)
library(wavelets)
library(WaveletComp)
library(waveslim)
 	
 
 

#--o--o--o  TRAINING AND VALIDATION   o--o--o

   					    #--o--o--o--o--o--o INPUT SIGNAL (Vector)

  file <- "xyz_2"
  name <-  paste0(file,".csv")

  start = c(1)
  endTr = c(15000)
  endTs = c(20000)

   O         <-  ts(read.csv(name, header = F),freq=1)[,2]    					   ## whole 

   zz        <-  ts(read.csv(name, header = F),freq=1, start = start, end = 1111 )[,2]    ## START 
   

   
   

   LenTrain  <-  length(zz)
	x 	 <- as.vector(zz)
	tt 	 <- as.numeric(time(zz))
			thresh <- seq(2,23.50,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("zz",thresh),
    				xlab="Time")
 
		w = data.frame(x, ws)
		w <- do.call(cbind,w)
		M <- matrix(NA, dim(w)[1],  dim(w)[2] )
				for ( i in 1: dim(M)[2] ){
				M[,i] <-  w[,i] 		 }   		   #--o--o--o--o  matrix with the filtered signals

	
 






## Easy check to see if it works...
x <- rnorm(32)
x.mra <- mra(x)
sum(x - apply(matrix(unlist(x.mra), nrow=32), 1, sum))^2






index <- O [4:10000]

n.level = 6

## LA(8)
index.la8 <- mra(index, "la8", n.level, "modwt")


 

## plot multiresolution analysis


par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(index, axes=FALSE, ylab="", main="(a)")
for(i in 1:(n.level+1))
  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
axis(side=1, at=seq(0,length(index),by=23) )
##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
 





dev.off()
 









