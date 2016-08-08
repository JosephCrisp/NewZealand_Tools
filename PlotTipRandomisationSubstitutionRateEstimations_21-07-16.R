path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/TipYearRandomisations/"

# Read in the log files of the 10 replicates
date <- "08-07-16"
name <- paste(date, "_HKY_Relaxed-Exp_Skygrid_RANDOM-YEAR.log.txt", sep="")
file1 <- paste(path, "TipRandomisation_", date, "_1/NZ_1_", name, sep="")
file2 <- paste(path, "TipRandomisation_", date, "_2/NZ_2_", name, sep="")
file3 <- paste(path, "TipRandomisation_", date, "_3/NZ_3_", name, sep="")
file4 <- paste(path, "TipRandomisation_", date, "_4/NZ_4_", name, sep="")
file5 <- paste(path, "TipRandomisation_", date, "_5/NZ_5_", name, sep="")
file6 <- paste(path, "TipRandomisation_", date, "_6/NZ_6_", name, sep="")
file7 <- paste(path, "TipRandomisation_", date, "_7/NZ_7_", name, sep="")
file8 <- paste(path, "TipRandomisation_", date, "_8/NZ_8_", name, sep="")
file9 <- paste(path, "TipRandomisation_", date, "_9/NZ_9_", name, sep="")
file10 <- paste(path, "TipRandomisation_", date, "_10/NZ_10_", name, sep="")

log1All <- read.table(file1, header=TRUE, skip=2)
log2All <- read.table(file2, header=TRUE, skip=2)
log3All <- read.table(file3, header=TRUE, skip=2)
log4All <- read.table(file4, header=TRUE, skip=2)
log5All <- read.table(file5, header=TRUE, skip=2)
log6All <- read.table(file6, header=TRUE, skip=2)
log7All <- read.table(file7, header=TRUE, skip=2)
log8All <- read.table(file8, header=TRUE, skip=2)
log9All <- read.table(file9, header=TRUE, skip=2)
log10All <- read.table(file10, header=TRUE, skip=2)

# Remove the burn in
burnIn <- 0.1 * 10000
log1 <- log1All[burnIn:nrow(log1All),]
log2 <- log2All[burnIn:nrow(log2All),]
log3 <- log3All[burnIn:nrow(log3All),]
log4 <- log4All[burnIn:nrow(log4All),]
log5 <- log5All[burnIn:nrow(log5All),]
log6 <- log6All[burnIn:nrow(log6All),]
log7 <- log7All[burnIn:nrow(log7All),]
log8 <- log8All[burnIn:nrow(log8All),]
log9 <- log9All[burnIn:nrow(log9All),]
log10 <- log10All[burnIn:nrow(log10All),]

# Scale the estimated substitution rate by the sequence length
seqLength <- 1068
log1$substitutionRate <- log1$meanRate * seqLength
log2$substitutionRate <- log2$meanRate * seqLength
log3$substitutionRate <- log3$meanRate * seqLength
log4$substitutionRate <- log4$meanRate * seqLength
log5$substitutionRate <- log5$meanRate * seqLength
log6$substitutionRate <- log6$meanRate * seqLength
log7$substitutionRate <- log7$meanRate * seqLength
log8$substitutionRate <- log8$meanRate * seqLength
log9$substitutionRate <- log9$meanRate * seqLength
log10$substitutionRate <- log10$meanRate * seqLength

######################################################
# Calculate the quantiles of the combine distributions

estimates <- c(log1$substitutionRate, log2$substitutionRate, log3$substitutionRate, log4$substitutionRate,
               log5$substitutionRate, log6$substitutionRate, log7$substitutionRate, log8$substitutionRate,
               log9$substitutionRate, log10$substitutionRate)
median(estimates)
quantiles <- quantile(estimates, c(0.025, 0.975))

########################################
# Plot the substitution rate estimations

# Set dimensions of plotting window
par(mfrow=c(1,1))

# Set the line width
lwd <- 1
alpha <- 0.7
cexMain <- 1
cexLab <- 0.75
cexLegend <- 0.5
cexAxis <- 0.7

# Get the limits for the x axis
xLim <- c(min(
  log1$substitutionRate, log2$substitutionRate, log3$substitutionRate, log4$substitutionRate,
  log5$substitutionRate, log6$substitutionRate, log7$substitutionRate, log8$substitutionRate,
  log9$substitutionRate, log10$substitutionRate
), 
max(
  log1$substitutionRate, log2$substitutionRate, log3$substitutionRate, log4$substitutionRate,
  log5$substitutionRate, log6$substitutionRate, log7$substitutionRate, log8$substitutionRate,
  log9$substitutionRate, log10$substitutionRate
))

# Create the breaks for the histogram
breaks <- seq(from=xLim[1], to=xLim[2] + 0.00001, by=0.00001)

# Create each of the histograms
log1_Hist <- hist(log1$substitutionRate, breaks=breaks, plot=FALSE)
log2_Hist <- hist(log2$substitutionRate, breaks=breaks, plot=FALSE)
log3_Hist <- hist(log3$substitutionRate, breaks=breaks, plot=FALSE)
log4_Hist <- hist(log4$substitutionRate, breaks=breaks, plot=FALSE)
log5_Hist <- hist(log5$substitutionRate, breaks=breaks, plot=FALSE)
log6_Hist <- hist(log6$substitutionRate, breaks=breaks, plot=FALSE)
log7_Hist <- hist(log7$substitutionRate, breaks=breaks, plot=FALSE)
log8_Hist <- hist(log8$substitutionRate, breaks=breaks, plot=FALSE)
log9_Hist <- hist(log9$substitutionRate, breaks=breaks, plot=FALSE)
log10_Hist <- hist(log10$substitutionRate, breaks=breaks, plot=FALSE)

# Get the y axis limit
yMax <- max(
  log1_Hist$counts, log2_Hist$counts, log3_Hist$counts, log4_Hist$counts,
  log5_Hist$counts, log6_Hist$counts, log7_Hist$counts, log8_Hist$counts,
  log9_Hist$counts, log10_Hist$counts
  )

# Open an output PDF file
file <- paste(path, "TipRandomisation_", date, ".pdf", sep="")
pdf(file)

# Plot the histograms
plot(log1_Hist$breaks, c(log1_Hist$counts, 0), type="s", lwd=lwd, las=1,
     main="Estimated Substitution Rate\nusing Shuffled Sampling Years",
     xlab="Rate (Events/Genome/Year)",
     ylab="Number Posterior Samples",
     xlim=xLim, ylim=c(0, yMax), col=rgb(0,0,0, alpha),
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis)
lines(log2_Hist$breaks, c(log2_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log3_Hist$breaks, c(log3_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log4_Hist$breaks, c(log4_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log5_Hist$breaks, c(log5_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log6_Hist$breaks, c(log6_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log7_Hist$breaks, c(log7_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log8_Hist$breaks, c(log8_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log9_Hist$breaks, c(log9_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))
lines(log10_Hist$breaks, c(log10_Hist$counts, 0), type="s", lwd=lwd, col=rgb(0,0,0, alpha))

dev.off()
