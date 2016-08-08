##################
# Load in the Data

path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/DecisionTreeAnalysis/"
date <- "15-06-16"

# run_5_07-12-15_HKY_Relaxed-Exp_Constant
file1 <- paste(path, "Replicate1/", "run_5_", date, "_HKY_Relaxed-Exp_Constant/", "NZ_5_", date, "_HKY_Relaxed-Exp_Constant.log.txt", sep="")
file2 <- paste(path, "Replicate2/", "run_5_", date, "_HKY_Relaxed-Exp_Constant/", "NZ_5_", date, "_HKY_Relaxed-Exp_Constant.log.txt", sep="")
file3 <- paste(path, "Replicate3/", "run_5_", date, "_HKY_Relaxed-Exp_Constant/", "NZ_5_", date, "_HKY_Relaxed-Exp_Constant.log.txt", sep="")

constant_1 <- read.table(file1, header=TRUE, skip=2)
constant_2 <- read.table(file2, header=TRUE, skip=2)
constant_3 <- read.table(file3, header=TRUE, skip=2)

# run_6_07-12-15_HKY_Relaxed-Exp_Logistic
#file1 <- paste(path, "Replicate1/", "run_6_", date, "_HKY_Relaxed-Exp_Logistic/", "NZ_6_", date, "_HKY_Relaxed-Exp_Logistic.log.txt", sep="")
#file2 <- paste(path, "Replicate2/", "run_6_", date, "_HKY_Relaxed-Exp_Logistic/", "NZ_6_", date, "_HKY_Relaxed-Exp_Logistic.log.txt", sep="")
#file3 <- paste(path, "Replicate3/", "run_6_", date, "_HKY_Relaxed-Exp_Logistic/", "NZ_6_", date, "_HKY_Relaxed-Exp_Logistic.log.txt", sep="")

#logistic_1 <- read.table(file1, header=TRUE, skip=2)
#logistic_2 <- read.table(file2, header=TRUE, skip=2)
#logistic_3 <- read.table(file3, header=TRUE, skip=2)

# run_7_07-12-15_HKY_Relaxed-Exp_Exponential
file1 <- paste(path, "Replicate1/", "run_7_", date, "_HKY_Relaxed-Exp_Exponential/", "NZ_7_", date, "_HKY_Relaxed-Exp_Exponential.log.txt", sep="")
file2 <- paste(path, "Replicate2/", "run_7_", date, "_HKY_Relaxed-Exp_Exponential/", "NZ_7_", date, "_HKY_Relaxed-Exp_Exponential.log.txt", sep="")
file3 <- paste(path, "Replicate3/", "run_7_", date, "_HKY_Relaxed-Exp_Exponential/", "NZ_7_", date, "_HKY_Relaxed-Exp_Exponential.log.txt", sep="")

exponential_1 <- read.table(file1, header=TRUE, skip=2)
exponential_2 <- read.table(file2, header=TRUE, skip=2)
exponential_3 <- read.table(file3, header=TRUE, skip=2)

# run_8_07-12-15_HKY_Relaxed-Exp_Expansion
#file1 <- paste(path, "Replicate1/", "run_8_", date, "_HKY_Relaxed-Exp_Expansion/", "NZ_8_", date, "_HKY_Relaxed-Exp_Expansion.log.txt", sep="")
#file2 <- paste(path, "Replicate2/", "run_8_", date, "_HKY_Relaxed-Exp_Expansion/", "NZ_8_", date, "_HKY_Relaxed-Exp_Expansion.log.txt", sep="")
#file3 <- paste(path, "Replicate3/", "run_8_", date, "_HKY_Relaxed-Exp_Expansion/", "NZ_8_", date, "_HKY_Relaxed-Exp_Expansion.log.txt", sep="")

#expansion_1 <- read.table(file1, header=TRUE, skip=2)
#expansion_2 <- read.table(file2, header=TRUE, skip=2)
#expansion_3 <- read.table(file3, header=TRUE, skip=2)

# run_9_07-12-15_HKY_Relaxed-Exp_Skyline
file1 <- paste(path, "Replicate1/", "run_9_", date, "_HKY_Relaxed-Exp_Skyline/", "NZ_9_", date, "_HKY_Relaxed-Exp_Skyline.log.txt", sep="")
file2 <- paste(path, "Replicate2/", "run_9_", date, "_HKY_Relaxed-Exp_Skyline/", "NZ_9_", date, "_HKY_Relaxed-Exp_Skyline.log.txt", sep="")
file3 <- paste(path, "Replicate3/", "run_9_", date, "_HKY_Relaxed-Exp_Skyline/", "NZ_9_", date, "_HKY_Relaxed-Exp_Skyline.log.txt", sep="")

skyline_1 <- read.table(file1, header=TRUE, skip=2)
skyline_2 <- read.table(file2, header=TRUE, skip=2)
skyline_3 <- read.table(file3, header=TRUE, skip=2)

# run_10_07-12-15_HKY_Relaxed-Exp_Skyride
file1 <- paste(path, "Replicate1/", "run_10_", date, "_HKY_Relaxed-Exp_Skyride/", "NZ_10_", date, "_HKY_Relaxed-Exp_Skyride.log.txt", sep="")
file2 <- paste(path, "Replicate2/", "run_10_", date, "_HKY_Relaxed-Exp_Skyride/", "NZ_10_", date, "_HKY_Relaxed-Exp_Skyride.log.txt", sep="")
file3 <- paste(path, "Replicate3/", "run_10_", date, "_HKY_Relaxed-Exp_Skyride/", "NZ_10_", date, "_HKY_Relaxed-Exp_Skyride.log.txt", sep="")

skyride_1 <- read.table(file1, header=TRUE, skip=2)
skyride_2 <- read.table(file2, header=TRUE, skip=2)
skyride_3 <- read.table(file3, header=TRUE, skip=2)

# run_11_07-12-15_HKY_Relaxed-Exp_Skygrid
file1 <- paste(path, "Replicate1/", "run_11_", date, "_HKY_Relaxed-Exp_Skygrid/", "NZ_11_", date, "_HKY_Relaxed-Exp_Skygrid.log.txt", sep="")
file2 <- paste(path, "Replicate2/", "run_11_", date, "_HKY_Relaxed-Exp_Skygrid/", "NZ_11_", date, "_HKY_Relaxed-Exp_Skygrid.log.txt", sep="")
file3 <- paste(path, "Replicate3/", "run_11_", date, "_HKY_Relaxed-Exp_Skygrid/", "NZ_11_", date, "_HKY_Relaxed-Exp_Skygrid.log.txt", sep="")

skygrid_1 <- read.table(file1, header=TRUE, skip=2)
skygrid_2 <- read.table(file2, header=TRUE, skip=2)
skygrid_3 <- read.table(file3, header=TRUE, skip=2)

##########################
# Remove the burnin period

burnIn <- 0.1 * 10000
constant_1 <- constant_1[burnIn:nrow(constant_1),]
constant_2 <- constant_2[burnIn:nrow(constant_2),]
constant_3 <- constant_3[burnIn:nrow(constant_3),]

#logistic_1 <- logistic_1[burnIn:nrow(logistic_1),]
#logistic_2 <- logistic_2[burnIn:nrow(logistic_2),]
#logistic_3 <- logistic_3[burnIn:nrow(logistic_3),]

exponential_1 <- exponential_1[burnIn:nrow(exponential_1),]
exponential_2 <- exponential_2[burnIn:nrow(exponential_2),]
exponential_3 <- exponential_3[burnIn:nrow(exponential_3),]

#expansion_1 <- expansion_1[burnIn:nrow(expansion_1),]
#expansion_2 <- expansion_2[burnIn:nrow(expansion_2),]
#expansion_3 <- expansion_3[burnIn:nrow(expansion_3),]

skyline_1 <- skyline_1[burnIn:nrow(skyline_1),]
skyline_2 <- skyline_2[burnIn:nrow(skyline_2),]
skyline_3 <- skyline_3[burnIn:nrow(skyline_3),]

skyride_1 <- skyride_1[burnIn:nrow(skyride_1),]
skyride_2 <- skyride_2[burnIn:nrow(skyride_2),]
skyride_3 <- skyride_3[burnIn:nrow(skyride_3),]

skygrid_1 <- skygrid_1[burnIn:nrow(skygrid_1),]
skygrid_2 <- skygrid_2[burnIn:nrow(skygrid_2),]
skygrid_3 <- skygrid_3[burnIn:nrow(skygrid_3),]

##########################################
# Change subtitution rate estimation units
#  events/site/year -> events/genome/year

nSitesConsidered <- 701736 + 1325639 + 1320196 + 701174 + 1068 # A C G T sequenceLength
constant_1$substitutionRate <- constant_1$meanRate * nSitesConsidered
constant_2$substitutionRate <- constant_2$meanRate * nSitesConsidered
constant_3$substitutionRate <- constant_3$meanRate * nSitesConsidered

#logistic_1$substitutionRate <- logistic_1$meanRate * nSitesConsidered
#logistic_2$substitutionRate <- logistic_2$meanRate * nSitesConsidered
#logistic_3$substitutionRate <- logistic_3$meanRate * nSitesConsidered

exponential_1$substitutionRate <- exponential_1$meanRate * nSitesConsidered
exponential_2$substitutionRate <- exponential_2$meanRate * nSitesConsidered
exponential_3$substitutionRate <- exponential_3$meanRate * nSitesConsidered

#expansion_1$substitutionRate <- expansion_1$meanRate * nSitesConsidered
#expansion_2$substitutionRate <- expansion_2$meanRate * nSitesConsidered
#expansion_3$substitutionRate <- expansion_3$meanRate * nSitesConsidered

skyline_1$substitutionRate <- skyline_1$meanRate * nSitesConsidered
skyline_2$substitutionRate <- skyline_2$meanRate * nSitesConsidered
skyline_3$substitutionRate <- skyline_3$meanRate * nSitesConsidered

skyride_1$substitutionRate <- skyride_1$meanRate * nSitesConsidered
skyride_2$substitutionRate <- skyride_2$meanRate * nSitesConsidered
skyride_3$substitutionRate <- skyride_3$meanRate * nSitesConsidered

skygrid_1$substitutionRate <- skygrid_1$meanRate * nSitesConsidered
skygrid_2$substitutionRate <- skygrid_2$meanRate * nSitesConsidered
skygrid_3$substitutionRate <- skygrid_3$meanRate * nSitesConsidered

############################################################
# Find the estimated substitution rate for the Skygrid model

estimates <- c(skygrid_1$substitutionRate, skygrid_2$substitutionRate, skygrid_3$substitutionRate)

median(estimates)
quantiles <- quantile(estimates, c(0.025, 0.975))

#############################################################################
# Plot the substitution rate estimates across population models and replicates

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
  constant_1$substitutionRate, constant_2$substitutionRate, constant_3$substitutionRate,
  #logistic_1$substitutionRate, logistic_2$substitutionRate, logistic_3$substitutionRate,
  exponential_1$substitutionRate, exponential_2$substitutionRate, exponential_3$substitutionRate,
  #expansion_1$substitutionRate, expansion_2$substitutionRate, expansion_3$substitutionRate,
  skyline_1$substitutionRate, skyline_2$substitutionRate, skyline_3$substitutionRate,
  skyride_1$substitutionRate, skyride_2$substitutionRate, skyride_3$substitutionRate,
  skygrid_1$substitutionRate, skygrid_2$substitutionRate, skygrid_3$substitutionRate
  ), 
          max(
  constant_1$substitutionRate, constant_2$substitutionRate, constant_3$substitutionRate,
  #logistic_1$substitutionRate, logistic_2$substitutionRate, logistic_3$substitutionRate,
  exponential_1$substitutionRate, exponential_2$substitutionRate, exponential_3$substitutionRate,
  #expansion_1$substitutionRate, expansion_2$substitutionRate, expansion_3$substitutionRate,
  skyline_1$substitutionRate, skyline_2$substitutionRate, skyline_3$substitutionRate,
  skyride_1$substitutionRate, skyride_2$substitutionRate, skyride_3$substitutionRate,
  skygrid_1$substitutionRate, skygrid_2$substitutionRate, skygrid_3$substitutionRate
  ))

# Create the breaks for the histogram
breaks <- seq(from=xLim[1], to=xLim[2] + 0.01, by=0.01)

# Create each of the histograms
constant_1_Hist <- hist(constant_1$substitutionRate, breaks=breaks, plot=FALSE)
constant_2_Hist <- hist(constant_2$substitutionRate, breaks=breaks, plot=FALSE)
constant_3_Hist <- hist(constant_3$substitutionRate, breaks=breaks, plot=FALSE)

#logistic_1_Hist <- hist(logistic_1$substitutionRate, breaks=breaks, plot=FALSE)
#logistic_2_Hist <- hist(logistic_2$substitutionRate, breaks=breaks, plot=FALSE)
#logistic_3_Hist <- hist(logistic_3$substitutionRate, breaks=breaks, plot=FALSE)

exponential_1_Hist <- hist(exponential_1$substitutionRate, breaks=breaks, plot=FALSE)
exponential_2_Hist <- hist(exponential_2$substitutionRate, breaks=breaks, plot=FALSE)
exponential_3_Hist <- hist(exponential_3$substitutionRate, breaks=breaks, plot=FALSE)

#expansion_1_Hist <- hist(expansion_1$substitutionRate, breaks=breaks, plot=FALSE)
#expansion_2_Hist <- hist(expansion_2$substitutionRate, breaks=breaks, plot=FALSE)
#expansion_3_Hist <- hist(expansion_3$substitutionRate, breaks=breaks, plot=FALSE)

skyline_1_Hist <- hist(skyline_1$substitutionRate, breaks=breaks, plot=FALSE)
skyline_2_Hist <- hist(skyline_2$substitutionRate, breaks=breaks, plot=FALSE)
skyline_3_Hist <- hist(skyline_3$substitutionRate, breaks=breaks, plot=FALSE)

skyride_1_Hist <- hist(skyride_1$substitutionRate, breaks=breaks, plot=FALSE)
skyride_2_Hist <- hist(skyride_2$substitutionRate, breaks=breaks, plot=FALSE)
skyride_3_Hist <- hist(skyride_3$substitutionRate, breaks=breaks, plot=FALSE)

skygrid_1_Hist <- hist(skygrid_1$substitutionRate, breaks=breaks, plot=FALSE)
skygrid_2_Hist <- hist(skygrid_2$substitutionRate, breaks=breaks, plot=FALSE)
skygrid_3_Hist <- hist(skygrid_3$substitutionRate, breaks=breaks, plot=FALSE)

# Get the y axis limit
yMax <- max(constant_1_Hist$counts, constant_2_Hist$counts, constant_3_Hist$counts,
            #logistic_1_Hist$counts, logistic_2_Hist$counts, logistic_3_Hist$counts,
            exponential_1_Hist$counts, exponential_2_Hist$counts, exponential_3_Hist$counts,
            #expansion_1_Hist$counts, expansion_2_Hist$counts, expansion_3_Hist$counts,
            skyline_1_Hist$counts, skyline_2_Hist$counts, skyline_3_Hist$counts,
            skyride_1_Hist$counts, skyride_2_Hist$counts, skyride_3_Hist$counts,
            skygrid_1_Hist$counts, skygrid_2_Hist$counts, skygrid_3_Hist$counts
            )

# Set a realistic bound on x-axis
xLim[2] <- 1.5

# Set the colours
constantCol <- rgb(1,0,0, alpha)
#logisticCol <- rgb(0,1,0, alpha)
exponentialCol <- rgb(0,0,1, alpha)
#expansionCol <- rgb(1,1,0, alpha)
skylineCol <- rgb(0,1,1, alpha)
skyrideCol <- rgb(1,0,1, alpha)
skygridCol <- rgb(0,0,0, alpha)

# Set the output file
file <- paste(path, "JosephCrisp_21-07-16_Figure4_SubstitutionRate.pdf", sep="")
pdf(file=file, height=6.3, width=4.41)

labelCex <- 1
par(mfrow=c(2,1))

# Plot the histograms
plot(constant_1_Hist$breaks, c(constant_1_Hist$counts, 0), type="s", lwd=lwd,
     main="Estimated Substitution Rate",
     xlab="Rate (Events/Genome/Year)",
     ylab="Number Posterior Samples",
     xlim=xLim, ylim=c(0, yMax), col=constantCol,
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis, las=1)

lines(constant_2_Hist$breaks, c(constant_2_Hist$counts, 0), type="s", lwd=lwd, col=constantCol)
lines(constant_3_Hist$breaks, c(constant_3_Hist$counts, 0), type="s", lwd=lwd, col=constantCol)

#lines(logistic_1_Hist$breaks, c(logistic_1_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)
#lines(logistic_2_Hist$breaks, c(logistic_2_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)
#lines(logistic_3_Hist$breaks, c(logistic_3_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)

lines(exponential_1_Hist$breaks, c(exponential_1_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)
lines(exponential_2_Hist$breaks, c(exponential_2_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)
lines(exponential_3_Hist$breaks, c(exponential_3_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)

#lines(expansion_1_Hist$breaks, c(expansion_1_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)
#lines(expansion_2_Hist$breaks, c(expansion_2_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)
#lines(expansion_3_Hist$breaks, c(expansion_3_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)

lines(skyline_1_Hist$breaks, c(skyline_1_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)
lines(skyline_2_Hist$breaks, c(skyline_2_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)
lines(skyline_3_Hist$breaks, c(skyline_3_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)

lines(skyride_1_Hist$breaks, c(skyride_1_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)
lines(skyride_2_Hist$breaks, c(skyride_2_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)
lines(skyride_3_Hist$breaks, c(skyride_3_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)

lines(skygrid_1_Hist$breaks, c(skygrid_1_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)
lines(skygrid_2_Hist$breaks, c(skygrid_2_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)
lines(skygrid_3_Hist$breaks, c(skygrid_3_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)

# Add a legend
legend("topright", bty="n",
       legend=c("Constant", "Exponential", "Skyline", "Skyride", "Skygrid"),
       text.col=c(constantCol, exponentialCol, skylineCol, skyrideCol, skygridCol),
       cex=cexLegend)
#text(x=0.007, y=300, "A", cex=1)
mtext("A", side=3, line=0, adj=0, cex=labelCex)


#########################################################################
# Are the substitution rate estimates different betwee population models?

# Create a list of the log tables
estimates <- list(c(constant_1$substitutionRate, constant_2$substitutionRate, constant_3$substitutionRate),
               #c(logistic_1$substitutionRate, logistic_2$substitutionRate, logistic_3$substitutionRate),
               c(exponential_1$substitutionRate, exponential_2$substitutionRate, exponential_3$substitutionRate),
               #c(expansion_1$substitutionRate, expansion_2$substitutionRate, expansion_3$substitutionRate),
               c(skyline_1$substitutionRate, skyline_2$substitutionRate, skyline_3$substitutionRate),
               c(skyride_1$substitutionRate, skyride_2$substitutionRate, skyride_3$substitutionRate),
               c(skygrid_1$substitutionRate, skygrid_2$substitutionRate, skygrid_3$substitutionRate)
            )
#names <- c("Constant", "Logistic", "Exponential", "Expansion", "Skyline", "Skyride", "Skygrid")
names <- c("Constant", "Exponential", "Skyline", "Skyride", "Skygrid")

# Set the number of random samples to compare
nSamples <- 10000

# Create a dataframe to store the calculated difference distributions
differences <- data.frame(matrix(0, nrow=nSamples, ncol=1))

count <- 0
for(i in 1:length(estimates)){
    
  for(j in 1:length(estimates)){
    
    # Avoid making self comparisons or the same comparison twice
    if(i == j){
      next
    }
    
    # Reset the array to store the differences calculated
    diffBetweenSamples <- c()
    
    # Take a random sample from each distribution being compared
    samples1 <- sample(estimates[[i]], nSamples, replace=TRUE)
    samples2 <- sample(estimates[[j]], nSamples, replace=TRUE)
    
    diffBetweenSamples <- samples1 - samples2
    
    # Store the calculated differences
    differences[paste(names[i], "-", names[j], sep="")] <- diffBetweenSamples
    
    # Keep track of the progress
    count <- count + 1
    print(paste("Finished making a comparison:", count))
  }  
}

# Remove the empty first row
differences <- differences[, 2: ncol(differences)]

# Note the columns that I want each boxplot in
array <- c()
col <- 0
count <- 0

for(i in 1:length(differences)){
  
  col <- col + 1
  count <- count + 1
  
  if(count == 5){
    col <- col + 1
    count <- 1
  }
  array[i] <- col
}

array

boxplot(differences, las=2, cex.axis=0.4, ylim=c(-1, 1), 
        at=array, pch=20, outcol="grey", cex=0.5,
        ylab="Difference between random samples",
        main="Comparing Substitution Rate Estimates\nbetween different Population Models",
        cex.main=0.8, cex.lab=0.7, lwd = 0.5)
lines(x=c(0, max(array) + 1), y=c(0, 0), col="red", lty=2, lwd=1)
#text(x=0.5, y=0.9, "B", cex=1)
mtext("B", side=3, line=0, adj=0, cex=labelCex)

# Indicate on the plot the 95% bounds of the distribution
for(i in 1:length(differences)){
  
  # Calculate the quantiles
  quantiles <- quantile(differences[[i]], c(0.025, 0.975))
  
  # Plot the upper and lower bounds
  points(x=c(array[i], array[i]), y=c(quantiles[[1]], quantiles[[2]]), col="blue", pch=20, cex=0.5)
}

dev.off()

################################################################
# Change root height from years since most recent sample to year
mostRecentSampledYear <- 2013

constant_1$RootHeight <- mostRecentSampledYear - constant_1$treeModel.rootHeight
constant_2$RootHeight <- mostRecentSampledYear - constant_2$treeModel.rootHeight
constant_3$RootHeight <- mostRecentSampledYear - constant_3$treeModel.rootHeight

#logistic_1$RootHeight <- mostRecentSampledYear - logistic_1$treeModel.rootHeight
#logistic_2$RootHeight <- mostRecentSampledYear - logistic_2$treeModel.rootHeight
#logistic_3$RootHeight <- mostRecentSampledYear - logistic_3$treeModel.rootHeight

exponential_1$RootHeight <- mostRecentSampledYear - exponential_1$treeModel.rootHeight
exponential_2$RootHeight <- mostRecentSampledYear - exponential_2$treeModel.rootHeight
exponential_3$RootHeight <- mostRecentSampledYear - exponential_3$treeModel.rootHeight

#expansion_1$RootHeight <- mostRecentSampledYear - expansion_1$treeModel.rootHeight
#expansion_2$RootHeight <- mostRecentSampledYear - expansion_2$treeModel.rootHeight
#expansion_3$RootHeight <- mostRecentSampledYear - expansion_3$treeModel.rootHeight

skyline_1$RootHeight <- mostRecentSampledYear - skyline_1$treeModel.rootHeight
skyline_2$RootHeight <- mostRecentSampledYear - skyline_2$treeModel.rootHeight
skyline_3$RootHeight <- mostRecentSampledYear - skyline_3$treeModel.rootHeight

skyride_1$RootHeight <- mostRecentSampledYear - skyride_1$treeModel.rootHeight
skyride_2$RootHeight <- mostRecentSampledYear - skyride_2$treeModel.rootHeight
skyride_3$RootHeight <- mostRecentSampledYear - skyride_3$treeModel.rootHeight

skygrid_1$RootHeight <- mostRecentSampledYear - skygrid_1$treeModel.rootHeight
skygrid_2$RootHeight <- mostRecentSampledYear - skygrid_2$treeModel.rootHeight
skygrid_3$RootHeight <- mostRecentSampledYear - skygrid_3$treeModel.rootHeight

############################################################
# Find the estimated root height for the Skygrid model

estimates <- c(skygrid_1$RootHeight, skygrid_2$RootHeight, skygrid_3$RootHeight)

median(estimates)
quantiles <- quantile(estimates, c(0.025, 0.975))

########################################################################
# Plot the root height estimates across population models and replicates

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
  constant_1$RootHeight, constant_2$RootHeight, constant_3$RootHeight,
  #logistic_1$RootHeight, logistic_2$RootHeight, logistic_3$RootHeight,
  exponential_1$RootHeight, exponential_2$RootHeight, exponential_3$RootHeight,
  #expansion_1$RootHeight, expansion_2$RootHeight, expansion_3$RootHeight,
  skyline_1$RootHeight, skyline_2$RootHeight, skyline_3$RootHeight,
  skyride_1$RootHeight, skyride_2$RootHeight, skyride_3$RootHeight,
  skygrid_1$RootHeight, skygrid_2$RootHeight, skygrid_3$RootHeight
), 
max(
  constant_1$RootHeight, constant_2$RootHeight, constant_3$RootHeight,
  #logistic_1$RootHeight, logistic_2$RootHeight, logistic_3$RootHeight,
  exponential_1$RootHeight, exponential_2$RootHeight, exponential_3$RootHeight,
  #expansion_1$RootHeight, expansion_2$RootHeight, expansion_3$RootHeight,
  skyline_1$RootHeight, skyline_2$RootHeight, skyline_3$RootHeight,
  skyride_1$RootHeight, skyride_2$RootHeight, skyride_3$RootHeight,
  skygrid_1$RootHeight, skygrid_2$RootHeight, skygrid_3$RootHeight
))

# Create the breaks for the histogram
breaks <- seq(from=xLim[1], to=xLim[2] + 1, by=1)

# Create each of the histograms
constant_1_Hist <- hist(constant_1$RootHeight, breaks=breaks, plot=FALSE)
constant_2_Hist <- hist(constant_2$RootHeight, breaks=breaks, plot=FALSE)
constant_3_Hist <- hist(constant_3$RootHeight, breaks=breaks, plot=FALSE)

#logistic_1_Hist <- hist(logistic_1$RootHeight, breaks=breaks, plot=FALSE)
#logistic_2_Hist <- hist(logistic_2$RootHeight, breaks=breaks, plot=FALSE)
#logistic_3_Hist <- hist(logistic_3$RootHeight, breaks=breaks, plot=FALSE)

exponential_1_Hist <- hist(exponential_1$RootHeight, breaks=breaks, plot=FALSE)
exponential_2_Hist <- hist(exponential_2$RootHeight, breaks=breaks, plot=FALSE)
exponential_3_Hist <- hist(exponential_3$RootHeight, breaks=breaks, plot=FALSE)

#expansion_1_Hist <- hist(expansion_1$RootHeight, breaks=breaks, plot=FALSE)
#expansion_2_Hist <- hist(expansion_2$RootHeight, breaks=breaks, plot=FALSE)
#expansion_3_Hist <- hist(expansion_3$RootHeight, breaks=breaks, plot=FALSE)

skyline_1_Hist <- hist(skyline_1$RootHeight, breaks=breaks, plot=FALSE)
skyline_2_Hist <- hist(skyline_2$RootHeight, breaks=breaks, plot=FALSE)
skyline_3_Hist <- hist(skyline_3$RootHeight, breaks=breaks, plot=FALSE)

skyride_1_Hist <- hist(skyride_1$RootHeight, breaks=breaks, plot=FALSE)
skyride_2_Hist <- hist(skyride_2$RootHeight, breaks=breaks, plot=FALSE)
skyride_3_Hist <- hist(skyride_3$RootHeight, breaks=breaks, plot=FALSE)

skygrid_1_Hist <- hist(skygrid_1$RootHeight, breaks=breaks, plot=FALSE)
skygrid_2_Hist <- hist(skygrid_2$RootHeight, breaks=breaks, plot=FALSE)
skygrid_3_Hist <- hist(skygrid_3$RootHeight, breaks=breaks, plot=FALSE)

# Get the y axis limit
yMax <- max(constant_1_Hist$counts, constant_2_Hist$counts, constant_3_Hist$counts,
            #logistic_1_Hist$counts, logistic_2_Hist$counts, logistic_3_Hist$counts,
            exponential_1_Hist$counts, exponential_2_Hist$counts, exponential_3_Hist$counts,
            #expansion_1_Hist$counts, expansion_2_Hist$counts, expansion_3_Hist$counts,
            skyline_1_Hist$counts, skyline_2_Hist$counts, skyline_3_Hist$counts,
            skyride_1_Hist$counts, skyride_2_Hist$counts, skyride_3_Hist$counts,
            skygrid_1_Hist$counts, skygrid_2_Hist$counts, skygrid_3_Hist$counts
)

# Set a realistic bound on x-axis
xLim[1] <- 1600

# Set the colours
constantCol <- rgb(1,0,0, alpha)
#logisticCol <- rgb(0,1,0, alpha)
exponentialCol <- rgb(0,0,1, alpha)
#expansionCol <- rgb(1,1,0, alpha)
skylineCol <- rgb(0,1,1, alpha)
skyrideCol <- rgb(1,0,1, alpha)
skygridCol <- rgb(0,0,0, alpha)

# Set the output file
file <- paste(path, "JosephCrisp_21-07-16_FigureX_RootHeight.pdf", sep="")
pdf(file=file, height=3.15, width=3.15)

# Plot the histograms
plot(constant_1_Hist$breaks, c(constant_1_Hist$counts, 0), type="s", lwd=lwd,
     main="Estimated Root Height",
     xlab="Year",
     ylab="Number Posterior Samples",
     xlim=xLim, ylim=c(0, yMax), col=constantCol,
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis)

lines(constant_2_Hist$breaks, c(constant_2_Hist$counts, 0), type="s", lwd=lwd, col=constantCol)
lines(constant_3_Hist$breaks, c(constant_3_Hist$counts, 0), type="s", lwd=lwd, col=constantCol)

#lines(logistic_1_Hist$breaks, c(logistic_1_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)
#lines(logistic_2_Hist$breaks, c(logistic_2_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)
#lines(logistic_3_Hist$breaks, c(logistic_3_Hist$counts, 0), type="s", lwd=lwd, col=logisticCol)

lines(exponential_1_Hist$breaks, c(exponential_1_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)
lines(exponential_2_Hist$breaks, c(exponential_2_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)
lines(exponential_3_Hist$breaks, c(exponential_3_Hist$counts, 0), type="s", lwd=lwd, col=exponentialCol)

#lines(expansion_1_Hist$breaks, c(expansion_1_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)
#lines(expansion_2_Hist$breaks, c(expansion_2_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)
#lines(expansion_3_Hist$breaks, c(expansion_3_Hist$counts, 0), type="s", lwd=lwd, col=expansionCol)

lines(skyline_1_Hist$breaks, c(skyline_1_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)
lines(skyline_2_Hist$breaks, c(skyline_2_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)
lines(skyline_3_Hist$breaks, c(skyline_3_Hist$counts, 0), type="s", lwd=lwd, col=skylineCol)

lines(skyride_1_Hist$breaks, c(skyride_1_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)
lines(skyride_2_Hist$breaks, c(skyride_2_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)
lines(skyride_3_Hist$breaks, c(skyride_3_Hist$counts, 0), type="s", lwd=lwd, col=skyrideCol)

lines(skygrid_1_Hist$breaks, c(skygrid_1_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)
lines(skygrid_2_Hist$breaks, c(skygrid_2_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)
lines(skygrid_3_Hist$breaks, c(skygrid_3_Hist$counts, 0), type="s", lwd=lwd, col=skygridCol)

# Add a legend
legend("topleft", bty="n",
       legend=c("Constant", "Exponential", "Skyline", "Skyride", "Skygrid"),
       text.col=c(constantCol, exponentialCol, skylineCol, skyrideCol, skygridCol),
       cex=cexLegend)

dev.off()
