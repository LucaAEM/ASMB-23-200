
#install.packages("C:\\Users\\39331\\Downloads\\splus2R_1.3-4.tar.gz", repos = NULL, type = "source")
#install.packages("C:\\Users\\39331\\Downloads\\ifultools_2.0-26.tar.gz", repos = NULL, type = "source")

#install.packages("C:\\Users\\39331\\Downloads\\wmtsa_2.0-3.tar.gz", repos = NULL, type = "source")


library(fpp)   # To load the data set a10
library(wmtsa)
library(forecast)
library(wavelets)
library(WaveletComp)
library(waveslim)


file 		    <- "xyz_2"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_2    <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  1300 )[,2]


  file 		    <- "xyz_3"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_3    <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  1300 )[,2]


 
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\denoiser_xyz_2.eps")
x 	 <- as.vector(indexShort_xyz_2)
	tt 	 <- as.numeric(time(indexShort_xyz_2))
			thresh <- seq(0.001,  4.2,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("Signal",thresh),
    				xlab="Time", main=" ")
   dev.off()


 


  
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\denoiser_xyz_3.eps")
x 	 <- as.vector(indexShort_xyz_3)
	tt 	 <- as.numeric(time(indexShort_xyz_3))
			thresh <- seq(0.001,   .2,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("Signal",thresh),
    				xlab="Time", main=" ")
   dev.off()






  file 		    <- "xyz_2"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_2bis    <-  ts(read.csv(name, header = F),freq=1, start = 4000, end =  6000 )[,2]


  file 		    <- "xyz_3"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_3bis    <-  ts(read.csv(name, header = F),freq=1, start = 4000, end =  6000 )[,2]


 
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\denoiser_xyz_2bis.eps")
x 	 <- as.vector(indexShort_xyz_2bis)
	tt 	 <- as.numeric(time(indexShort_xyz_2bis))
			thresh <- seq(0.001,  4.2,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("Signal",thresh),
    				xlab="Time", main=" ")
   dev.off()



  
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\denoiser_xyz_3bis.eps")
x 	 <- as.vector(indexShort_xyz_3bis)
	tt 	 <- as.numeric(time(indexShort_xyz_3bis))
			thresh <- seq(0.001,   .2,length=5)
			ws 	 <- lapply(thresh, function(k,x)
    			wavShrink(x, wavelet="s8",
       		shrink.fun="hard", thresh.fun="universal",
       		thresh.scale=k, xform="modwt"), x=x)
 
				ifultools::stackPlot(x=tt, y=data.frame(x, ws),
    				ylab=c("Signal",thresh),
    				xlab="Time", main=" ")
   dev.off()


#_________________________________________________________________________MRA__________________________________________

		 



 file 		    <- "xyz_2"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_2    <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  1300 )[,2]


  file 		    <- "xyz_3"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_3    <-  ts(read.csv(name, header = F),freq=1, start = 1, end =  1300 )[,2]


 
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\MRA_xyz_2.eps")
		n.level = 5

		## LA(8)
		index.la8 <- mra(indexShort_xyz_2, "la8", n.level, "modwt")

		par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(indexShort_xyz_2, axes=FALSE, ylab="", main="(a)")
		for(i in 1:(n.level+1))
		  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
		axis(side=1, at=seq(0,length(index),by=20) )
		##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
   dev.off()



  
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\MRA_xyz_3.eps")
		n.level = 5

		## LA(8)
		index.la8 <- mra(indexShort_xyz_3, "la8", n.level, "modwt")

		par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(indexShort_xyz_3, axes=FALSE, ylab="", main="(a)")
		for(i in 1:(n.level+1))
		  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
		axis(side=1, at=seq(0,length(index),by=20) )
		##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
   dev.off()
 






  file 		    <- "xyz_2"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_2bis    <-  ts(read.csv(name, header = F),freq=1, start = 4000, end =  6000 )[,2]


  file 		    <- "xyz_3"
  name 		    <-  paste0(file,".csv")
  indexShort_xyz_3bis    <-  ts(read.csv(name, header = F),freq=1, start = 4000, end =  6000 )[,2]


 
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\MRA_xyz_2bis.eps")
		n.level = 5

		## LA(8)
		index.la8 <- mra(indexShort_xyz_2bis, "la8", n.level, "modwt")

		par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(indexShort_xyz_2bis, axes=FALSE, ylab="", main="(a)")
		for(i in 1:(n.level+1))
		  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
		axis(side=1, at=seq(0,length(index),by=20) )
		##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
   dev.off()



  
setEPS(); postscript("C:\\Users\\39331\\Downloads\\DATA\\MRA_xyz_3bis.eps")
		n.level = 5

		## LA(8)
		index.la8 <- mra(indexShort_xyz_3bis, "la8", n.level, "modwt")

		par(mfcol=c(8,1), pty="m", mar=c(5-2,4,4-2,2))
		plot.ts(indexShort_xyz_3bis, axes=FALSE, ylab="", main="(a)")
		for(i in 1:(n.level+1))
		  plot.ts(index.la8 [[i]], axes=FALSE, ylab=names(index.la8)[i])
		axis(side=1, at=seq(0,length(index),by=20) )
		##  , labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))
   dev.off()


#___________________________ to be saved manually______________________________MRA__________________________________________


#setEPS(); postscript("C:\\Users\\lfenga\\Dropbox\\Z_OPERATIONAL\\PRED_MAINT\\TABLEU_xyz_2.eps")
result <- wavMODWT(indexShort_xyz_2, wavelet="s8", n.levels=5, keep.series=TRUE)
	plot(result )
    	plot(wavShift(result))  
	eda.plot(result)
 #  dev.off()
	

#setEPS(); postscript("C:\\Users\\lfenga\\Dropbox\\Z_OPERATIONAL\\PRED_MAINT\\TABLEU_xyz_3.eps")
result <- wavMODWT(indexShort_xyz_3, wavelet="s8", n.levels=5, keep.series=TRUE)
	plot(result )
    	plot(wavShift(result))  
	eda.plot(result)
  # dev.off()



#setEPS(); postscript("C:\\Users\\lfenga\\Dropbox\\Z_OPERATIONAL\\PRED_MAINT\\TABLEU_xyz_2bis.eps")
result <- wavMODWT(indexShort_xyz_2bis, wavelet="s8", n.levels=5, keep.series=TRUE)
	plot(result )
    	plot(wavShift(result))  
	eda.plot(result)
#   dev.off()
 
 
#setEPS(); postscript("C:\\Users\\lfenga\\Dropbox\\Z_OPERATIONAL\\PRED_MAINT\\TABLEU_xyz_3bis.eps")
result <- wavMODWT(indexShort_xyz_3bis, wavelet="s8", n.levels=5, keep.series=TRUE)
	plot(result )
    	plot(wavShift(result))  
	eda.plot(result)
#   dev.off()

 
 














