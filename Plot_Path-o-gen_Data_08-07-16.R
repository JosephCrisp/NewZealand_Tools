path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/Path-o-gen/"

#########################################
# Open the output files from path-o-gen #
#########################################

# All Isolates
file <- paste(path, "root-to-tip_ALL_plusREF.txt", sep="")
all_plusREF <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")
file <- paste(path, "root-to-tip_ALL.txt", sep="")
all <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")

# Clade 1 Isolates
file <- paste(path, "root-to-tip_CLADE1_plusREF.txt", sep="")
clade1_plusREF <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")
file <- paste(path, "root-to-tip_CLADE1.txt", sep="")
clade1 <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")

# Matched Isolates from Clade 1
file <- paste(path, "root-to-tip_MATCHED_plusREF.txt", sep="")
matched_plusREF <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")
file <- paste(path, "root-to-tip_MATCHED.txt", sep="")
matched <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")

##########################
# Root-to-tip Regression #
##########################

# Open a PDF
file <- paste(path, "root-to-tip_Regression_08-07-16.pdf", sep="")
pdf(file)

# Set the plotting window dimensions
par(mfrow=c(1,1))

## All Isolates and REF
table <- all_plusREF
main <- "All Isolates and Reference"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

## All Isolates
table <- all
main <- "All Isolates"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

## Clade 1 Isolates and REF
table <- clade1_plusREF
main <- "Clade 1 Isolates and Reference"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

## Clade 1 Isolates
table <- clade1
main <- "Clade 1 Isolates"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

## Matched Isolates from Clade 1 and Reference
table <- matched_plusREF
main <- "Matched Isolates from Clade 1 and Reference"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

## Matched Isolates from Clade 1
table <- matched
main <- "Matched Isolates from Clade 1"

# Fit a linear model
linearModel <- lm(distance~date, data=table)
summary <- summary(linearModel)

# Get the confidence intervals
newData <- data.frame(date=seq(from=min(table$date), to=max(table$date), by=1))
confidenceIntervals <- as.data.frame(predict(linearModel, interval="confidence",
                                             newdata=newData))

plot(table$date, table$distance, pch=20, las=1,
     main=main, ylab="Root-to-tip Distance", xlab="Sampling Year")
abline(linearModel, col="red")
lines(x=newData$date, y=confidenceIntervals$upr, col=rgb(1,0,0, 0.2))
lines(x=newData$date, y=confidenceIntervals$lwr, col=rgb(1,0,0, 0.2))

legend("topleft", 
       legend=c(paste("R^2 = ", round(summary$adj.r.squared, 3)),
                paste("p-value = ", round(anova(linearModel)$Pr[[1]], 5))),
       bty='n')

dev.off()

