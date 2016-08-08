library(png)

path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/GeneticDistanceClustering/"
date <- "16-06-2016"
sourceFile <- paste(path, "clustering_", date, "_Source.txt", sep="");
sources <- read.table(sourceFile, header=TRUE)

locationFile <- paste(path, "clustering_", date, "_Location.txt", sep="");
location <- read.table(locationFile, header=TRUE)

speciesFile <- paste(path, "clustering_", date, "_Species.txt", sep="");
species <- read.table(speciesFile, header=TRUE)

reaFile <- paste(path, "clustering_", date, "_REA.txt", sep="");
rea <- read.table(reaFile, header=TRUE)

reaFile <- paste(path, "geneticDistances_", date, "_REA.txt", sep="");
distances <- read.table(reaFile, header=TRUE)

### Open a PNG file with REA types
pngFile <- paste(path, "path-o-gen_26-10-15_Clade1_plusREF_paired_labeled-1.png", sep="")
treePNG <- readPNG(pngFile)

### Open a output PDF file
file <- paste(path, "JosephCrisp_17-03-16_Figure3_Clustering.pdf", sep="");
pdf(file, height=6.65, width=6.65)

par(mfrow=c(2,2))

##### SOURCE #####
actual <- -1.8714176245210723

xmin <- min(sources$ActualDiff, actual)
xmax <- max(sources$ActualDiff, actual)

quantiles <- quantile(sources$ActualDiff, c(0.025, 0.975))

h <- hist(sources$ActualDiff, breaks=50, plot=FALSE)

cuts <- cut(h$breaks, c(-Inf, quantiles[1], quantiles[2], Inf))

#plot(h, col=c("red", "white", "red")[cuts], xlab="Difference",
#     main="Sampling Source", xlim=c(xmin,xmax))
#lines(c(actual,actual), c(0, max(h$counts)), col="blue", lwd=3)
#text(6, (max(h$counts) - 100), cex = 0.7,
#     paste("Actual Value\n= ", round(actual, digits=2)), col="blue")

##### REA #####

#boxplot(Distance ~ Comparison, data=distances, las=1, cex.axis=1,
#        pch=20, outcol="grey", cex=0.8,
#        ylab="Number of SNPs",
#        main="REA Type:\nInter- versus Intra-Group genetic distances",
#        cex.main=1, cex.lab=1, lwd = 1)
#text(0.65, 310, "A", cex=2)

plot.new()
title("REA Types on ML Tree")
lim <- par()
rasterImage(treePNG, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
text(0.01, 0.95, "A", cex=2)

actual <- 82.63294736842106

xmin <- min(rea$ActualDiff, actual)
xmax <- max(rea$ActualDiff, actual)

quantiles <- quantile(rea$ActualDiff, c(0.025, 0.975))

h <- hist(rea$ActualDiff, breaks=10, plot=FALSE)

cuts <- cut(h$breaks, c(-Inf, quantiles[1], quantiles[2], Inf))

plot(h, col=c("red", "white", "red")[cuts], xlab="Difference",
     main="Isolate REA Type", xlim=c(xmin, xmax), cex.axis=0.8, las=1)
lines(c(actual,actual), c(0, max(h$counts)), col="blue", lwd=3)
text(50, (max(h$counts) - 200), cex = 0.9,
     paste("Actual Value\n= ", round(actual, digits=2)), col="blue")
text(-20, (max(h$counts) - 100), "B", cex=2)

##### LOCATION #####
actual <- 45.6601217166084

xmin <- min(location$ActualDiff, actual)
xmax <- max(location$ActualDiff, actual)

quantiles <- quantile(location$ActualDiff, c(0.025, 0.975))

h <- hist(location$ActualDiff, breaks=50, plot=FALSE)

cuts <- cut(h$breaks, c(-Inf, quantiles[1], quantiles[2], Inf))

plot(h, col=c("red", "white", "red")[cuts], xlab="Difference",
     main="Sampling Location", xlim=c(xmin,xmax), cex.axis=0.8, las=1)
lines(c(actual,actual), c(0, max(h$counts)), col="blue", lwd=3)
text(30, (max(h$counts) - 50), cex = 0.9,
     paste("Actual Value\n= ", round(actual, digits=2)), col="blue")
text(-20, (max(h$counts) - 10), "C", cex=2)

##### SPECIES #####
actual <- -19.79715762273902

xmin <- min(species$ActualDiff, actual)
xmax <- max(species$ActualDiff, actual)

quantiles <- quantile(species$ActualDiff, c(0.025, 0.975))

h <- hist(species$ActualDiff, breaks=50, plot=FALSE)

cuts <- cut(h$breaks, c(-Inf, quantiles[1], quantiles[2], Inf))

plot(h, col=c("red", "white", "red")[cuts], xlab="Difference",
     main="Sampled Species", xlim=c(xmin,xmax), cex.axis=0.8, las=1)
lines(c(actual,actual), c(0, max(h$counts)), col="blue", lwd=3)
text(45, (max(h$counts) - 50), cex = 0.9,
     paste("Actual Value\n= ", round(actual, digits=2)), col="blue")
text(-30, (max(h$counts) - 25), "D", cex=2)

dev.off()




