
#########################
# Open the Output table #
#########################
path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/FilterSensitivityAnalysis/"
file <- paste(path, "sensitivityOutput_13-06-16.txt", sep="")

sensitivityOutput <- read.table(file, header=TRUE, sep="\t")

# Note the column names
columnNames <- c("Read Depth", "High Quality Base Depth", "Mapping Quality", "Allele Support",
                 "SNP Coverage Across Isolates", "SNP Proximity", "Pseudo R Squared",	"Mean Squared Error",
                 "Pearsons Correlation: Predicted vs. Actual", "Spatial Distance Importance",	
                 "Number Years Between Sampling Importance",	"Same Species Importance",	
                 "Same Location Importance",	"Same Area Importance",	"Same REA Type Importance",	
                 "Pearsons Correlation: Spatial vs. Genetic",	"Pearsons Correlation: Temporal vs. Genetic",	
                 "Number of Sites Retained", "Mean Proportions Ns")

# Open output file
file <- paste(path, "sensitivity_13-06-16.pdf", sep="")
pdf(file)


####################
# Filter Selection #
####################

# Order the table by both High R Squared and low Error
orderedOutput <- sensitivityOutput[ order(-sensitivityOutput$RSquared, sensitivityOutput$MSE), ]

# Find the Highest 5% for pseudo R Squared
upper <- quantile(sensitivityOutput$RSquared, probs=c(0.95), na.rm=TRUE)
line <- rep(upper[[1]], nrow(orderedOutput))

# Set up the layout of the figure
layout(matrix(c(1,1,1,1,1,1,2,2,2,2,2,2,3,4,5,6,7,8), 3, 6, byrow=TRUE))

# Plot the ordered data
smoothScatter(orderedOutput$RSquared, nrpoints=0, pch=20, cex=0.01, xlab="Index",
              ylab="Pseudo R Squared (%)", bty="n", las=1)
points(line, type="l", col="red")

smoothScatter(orderedOutput$MSE, nrpoints=0, pch=20, cex=0.01, xlab="",
              ylab="Mean Squared Residuals", bty="n", las=1)

# Select the highest 5% for pseudo R Squared
selection <- subset(sensitivityOutput, sensitivityOutput$RSquared >= upper[[1]])

for(i in 1:6){
  
  if(i == 1){
    boxplot(selection[,i], ylim=range(sensitivityOutput[,i]), 
            frame=FALSE,ylab=columnNames[i], las=1,
            xlab=paste(length(unique(selection[,i])), "/", length(unique(sensitivityOutput[,i]))),
            main=paste("n=",length(selection[,i]))
    )
  }else{
    boxplot(selection[,i], ylim=range(sensitivityOutput[,i]), 
            frame=FALSE,ylab=columnNames[i], las=1,
            xlab=paste(length(unique(selection[,i])), "/", length(unique(sensitivityOutput[,i])))
    )
  }
}
title("Ordered by Increasing R Squared and Decreased Error.\n Selecting for High R Squared (upper 5%)", outer=TRUE)

################################
# Plot the Variable Importance #
################################

# Use the Upper 5% of the Models
layout(matrix(c(1), 1,1, byrow=TRUE))
boxplot(selection[,10:15], names=c("Spatial", "Temporal", "Species", 
                                                "Location","Area", "REA Type"),
        ylab="Importance", main="Variable Importance", cex.axis=0.9, las=2)
legend("top", legend=paste("n = ",length(selection[,i])), bty="n")


#########################################################
# Plot the effect of the filters on the output measures #
#########################################################

# Plot each of the Measures Against the Filter Values - BOX PLOTS
par(mfrow=c(3,2))
par(mar=c(4,4,3,1), oma=c(2,0,3,0)) # mar is for individual plot margins, oma is for plotting window margins

# Loop through each of the Output Measures comparing them to the filter values
for(i in 7:ncol(sensitivityOutput)){
  
  boxplot(sensitivityOutput[,i] ~ sensitivityOutput$Depth, xlab="Read Depth", ylab=columnNames[i], cex.axis=0.6, las=1)
  
  boxplot(sensitivityOutput[,i] ~ sensitivityOutput$HQDepth, xlab="High Quality Base Depth", cex.axis=0.6, las=1)
  
  boxplot(sensitivityOutput[,i] ~ sensitivityOutput$MQ, xlab="Mapping Quality", cex.axis=0.6, las=1)
  
  boxplot(sensitivityOutput[,i] ~sensitivityOutput$SUP, xlab="Alelle Support", cex.axis=0.6, las=1)
  
  boxplot(sensitivityOutput[,i] ~ sensitivityOutput$SNPCov, xlab="SNP Coverage Across Isolates", cex.axis=0.6, las=1)
  
  boxplot(sensitivityOutput[,i] ~ sensitivityOutput$Proximity, xlab="SNP Proximity", cex.axis=0.6, las=1)
  
  title(columnNames[i], outer=TRUE)
}

##################################################
# Plot the Filter Thresholds Against One Another #
##################################################

nRows <- nrow(orderedOutput)
orderedOutput$index <- c(1:nRows)
alpha <- 0.5

plot(orderedOutput[,1:6],pch=16,main="Selecting by Order for Combined Increased R Squared and Decreased Error",
     col = ifelse(orderedOutput$index <= (nRows * 0.05),rgb(1,0,0, alpha),
                  ifelse(orderedOutput$index <= (nRows * 0.5), rgb(0,1,0, 0),
                         ifelse(orderedOutput$index <= (nRows * 0.75), rgb(0,0,1, 0), rgb(0,0,0, 0)))))

plot(orderedOutput[,1:6],pch=16, main="Selecting by Order for Combined Increased R Squared and Decreased Error",
     col = ifelse(orderedOutput$index <= (nRows * 0.25),rgb(1,0,0, 0),
                  ifelse(orderedOutput$index <= (nRows * 0.5), rgb(0,1,0, alpha),
                         ifelse(orderedOutput$index <= (nRows * 0.75), rgb(0,0,1, 0), rgb(0,0,0, 0)))))

plot(orderedOutput[,1:6],pch=16, main="Selecting by Order for Combined Increased R Squared and Decreased Error",
     col = ifelse(orderedOutput$index <= (nRows * 0.25),rgb(1,0,0, 0),
                  ifelse(orderedOutput$index <= (nRows * 0.5), rgb(0,1,0, 0),
                         ifelse(orderedOutput$index <= (nRows * 0.75), rgb(0,0,1, alpha), rgb(0,0,0, 0)))))

plot(orderedOutput[,1:6],pch=16, main="Selecting by Order for Combined Increased R Squared and Decreased Error",
     col = ifelse(orderedOutput$index <= (nRows * 0.25),rgb(1,0,0, 0),
                  ifelse(orderedOutput$index <= (nRows * 0.5), rgb(0,1,0, 0),
                         ifelse(orderedOutput$index <= (nRows * 0.75), rgb(0,0,1, 0), rgb(0,0,0, alpha)))))


dev.off()
