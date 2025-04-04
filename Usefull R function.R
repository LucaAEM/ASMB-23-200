


x <- 1:100
aa <- create.signalSeries(x, length.out=60)

 # some examples
nms <- c("blocks", "linchirp", "mishmash1", "bumps")
z <- lapply(nms, make.signal)
ifultools::stackPlot(x=seq(1024),y=z, ylab=nms)



## Wavelet decomposition and reconstruction :
## https://stackoverflow.com/questions/22131080/wavelet-reconstruction-of-time-series-r
## A Practical Guide to Wavelet Analysis

y<-as.numeric(LakeHuron)

y.m<-mean(y)
y.madj<-y-y.m

J<-70
wt<-matrix(rep(NA,(length(y.madj))*(J+1)),ncol=(J+1))

## Lets first write a function for Wavelet decomposition as in formula (1):
mo<-function(t,trans=0,omega=6,j=0){
  dial<-2*2^(j*.125)
  sqrt((1/dial))*pi^(-1/4)*exp(1i*omega*((t-trans)/dial))*exp(-((t-trans)/dial)^2/2)
}

for(j in 0:J){
for(k in 1:length(y.madj)){
  wt[k,j+1]<-mo(t=1:(length(y.madj)),j=j,trans=k)%*%y.madj
  }
}

#Extract the real part for the reconstruction:
wt.r<-Re(wt)

# Reconstruct as in formula (11):
dial<-2*2^(0:J*.125)
rec<-rep(NA,(length(y.madj)))
for(l in 1:(length(y.madj))){
  rec[l]<-0.2144548*sum(wt.r[l,]/sqrt(dial))
}
rec<-rec+y.m

plot(y,type="l")
lines(rec,col=2)





## BOOTSTRAP == wavestrap the lake Huron series
x <- as.numeric(y)
z <- wavBootstrap(x, n.realization=1)  ## bootstrap 1 series
ifultools::stackPlot(x=seq(along=x),
y=data.frame(y, z, abs(z)),
ylab=list(text=c("sunspots","wavestrap","|wavestrap|")))
title("Wavelet-based bootstrapping of sunspots series", cex=0.7)


## wavestrap the sunspots series
x <- as.numeric(sunspots)
z <- wavBootstrap(x, n.realization=1)
ifultools::stackPlot(x=seq(along=sunspots),
y=data.frame(x, z, abs(z)),
ylab=list(text=c("sunspots","wavestrap","|wavestrap|")))
title("Wavelet-based bootstrapping of sunspots series", cex=0.7)















