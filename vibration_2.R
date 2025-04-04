
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

  file <- "xyz_3"
  name <-  paste0(file,".csv")

  index         <-  ts(read.csv(name, header = F),freq=1)[,2]    					   ## whole 

   indexShort    <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  1300 )[,2]   ## START 
   indexFast     <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  500  )[,2]   ## START 

 
   
###  filtering

	x 	 <- as.vector(indexShort)
	tt 	 <- as.numeric(time(indexShort))
			thresh <- seq(0.001,  .05,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("Signal",thresh),
    				xlab="Time", main="Wavelet Denoiser")

###  storing in matrix M 
 
		w = data.frame(x, ws)
		w <- do.call(cbind,w)
		M <- matrix(NA, dim(w)[1],  dim(w)[2] )
				for ( i in 1: dim(M)[2] ){
				M[,i] <-  w[,i] 		 }   		   #--o--o--o--o  matrix with the filtered signals


### mra
		n.level = 5

		## LA(8)
		index.la8 <- mra(indexShort, "la8", n.level, "modwt")

		par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(indexShort, axes=FALSE, ylab="", main="(a)")
		for(i in 1:(n.level+1))
		  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
		axis(side=1, at=seq(0,length(index),by=20) )
		##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
  

	 
## MODWT of indexShort  ts.plot(indexShort  )
 
	result <- wavMODWT(indexShort, wavelet="s8", n.levels=5, keep.series=TRUE)
	## plot the transform non-shifted for approximate zero
	plot(result )
      ## phase alignment; plot the transform shifted for approximate zero
	plot(wavShift(result))  
	## plot summary
	eda.plot(result)
	## summarize the transf
	summary(result)
						result$scales #  levels
						nLevels <- length(result$scales)
	
      EnergyMtx   <-     summary(result)[[1]][1:(nLevels+1),10]  ## sums up to 100%


	wavMRD(result )

	plot(wavMRD(result , level = c(3,4  )))

	## create a MODWT-based MRD of the sunspots series
	## and sum over decomposition levels 4 to 6
	x <- as.vector(indexShort)
	z1 <- wavMRDSum(x, wavelet="s8", levels=4:5)
	ifultools::stackPlot(x=as.vector(time(indexShort)),
	y=list(indexShort=x, "sum"=z1),
	ylim=range(x,z1))

 

  ## perform a time independent wavelet variance
  ## analysis
  vmod <- wavVar(indexShort, n.levels=4,  wavelet="s8")
  plot(vmod, pch=15, edof=c(1,3), title="")

   summary( vmod )[[3]]    ## j-DEPENDENT VARIANCE

   summary( vmod )[[3]][2] ## d1 variance  
	
	log10(mean(as.vector(abs(result$data$d1))))
	log10(var(as.vector((result$data$d1))))

		 mean(as.vector(abs(result$data$d1)))
		 var(as.vector((result$data$d1)))


	#__________________________________________________________________________________________

  #_________ mean_sum_variance   __________________
    names(result$data )
    as.vector(result$data$d1)
  meanEnergy <-   mean(as.vector(abs(result$data$d1)))
  sumEnergy  <-   sum(as.vector(abs(result$data$d1)))
    var(as.vector((result$data$d1)))
  #_________  :-)				__________________


	resultF <- wavMODWT(indexFast, wavelet="s8", n.levels=5, keep.series=TRUE)
 

 #_________ mean_sum_variance Fast  __________________
    names(resultF$data )
    as.vector(resultF$data$d1)
  meanEnergyF <-   mean(as.vector(abs(resultF$data$d1)))
  sumEnergyF  <-   sum(as.vector(abs(resultF$data$d1)))
    var(as.vector((resultF$data$d1)))
  #_________  :-)				__________________


    
    #errore

  #_________ procedure  	    __________________

   
	edof <- wavEDOF(indexShort, wavelet="s8", levels=5)
  d1.VARIANCE  <-  as.vector( edof$variance.unbiased[1])

  wavVarConfidence(edof$variance.unbiased, edof$EDOF3)

  d1_CI_low  <- wavVarConfidence(edof$variance.unbiased, edof$EDOF1)$low[1]
  d1_CI_high <- wavVarConfidence(edof$variance.unbiased, edof$EDOF1)$high[1]

  #_________ procedure  Fast	    __________________


  edofF	 	   <-  wavEDOF(indexFast)
  d1.VARIANCE.F     <-  as.vector( edofF$variance.unbiased[1])


  d1_CI_low.F  <- wavVarConfidence(edofF$variance.unbiased, edofF$EDOF1)$low[1]
  d1_CI_high.F <- wavVarConfidence(edofF$variance.unbiased, edofF$EDOF1)$high[1]


  #_________ end procedure :-)__________________


  log( as.vector(c(sumEnergy, meanEnergy,  d1_CI_low  , d1.VARIANCE  , d1_CI_high   )))

  log( as.vector(c(sumEnergyF,meanEnergyF, d1_CI_low.F, d1.VARIANCE.F, d1_CI_high.F )))








 



















