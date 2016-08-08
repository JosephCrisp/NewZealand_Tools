suppressMessages(library(randomForest))
#suppressMessages(library(foreach))
#suppressMessages(library(doParallel)) # WINDOWS
#suppressMessages(library(doMC))

###############################################################
# Predicting Genetic Distance using Epidemiological Variables #
###############################################################


# Find the GLM Table file - take in from the command line
args <- commandArgs(TRUE)

#path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/FilterSensitivityAnalysis/"
#file <- paste(path, "geneticVsEpiTable.txt", sep="")
#outFile <- paste(path, "modelFittingOutput.txt", sep="")
#mTry=4
#nTree=1000

# Retrieve Info from Command Line
file <- args[1]
outFile <- args[2]
mTry <- as.numeric(args[3])
nTree <- as.numeric(args[4])

# Note that I define the Table classes manually - IMPORTANT
table <- read.table(file, header=TRUE, colClasses="numeric")

# Tune the mtry parameter
#mTryInitial <- 3
#nTrees <- 500
#tuneOutput <- tuneRF(table[,-1], table$Genetic, mtryStart=mTryInitial,
#                     ntreeTry=nTrees, stepFactor=1.5, improve=0.0001, trace=TRUE,
#                     plot=TRUE)

# Fit random forest model
infoRF <- randomForest(table[,-1], table$Genetic,
                       proximity=FALSE, mtry=mTry, importance=TRUE,
                       ntree=nTree, do.trace=FALSE, keep.forest=FALSE, 
                       norm.votes=FALSE)

# Start a parallel session
#registerDoParallel(cores=4) # WINDOWS
#registerDoMC(4) # UNIX

# Run Random Forest Algorithm
#system.time(
#  infoRF <- foreach(ntree=rep(125, 4), .combine=combine,
#                  .packages='randomForest', .multicombine=TRUE) %dopar% randomForest(table$Genetic~., data=table[,-1],
#                                                                         proximity=FALSE, mtry=mtry, importance=TRUE,
#                                                                         ntree=ntree, do.trace=FALSE, keep.forest=FALSE, 
#                                                                        norm.votes=FALSE))




# Calculate the correltation between the predicted and actual
predCorr <- cor.test(table$Genetic, infoRF$predicted)

# Extract Descriptive RF statistics
explained <- infoRF$rsq[length(infoRF$rsq)]
MSE <- infoRF$mse[length(infoRF$mse)]

# Extract the Variable Importance Information
importanceTable <- importance(infoRF)

# Calculate the Correlations
SpaCorr <- cor.test(table$Genetic, table$Spatial)
TempCorr <- cor.test(table$Genetic, table$Temporal)

# Print the output to File
write(paste(explained, MSE, predCorr$estimate, importanceTable[1,1], importanceTable[2,1],
            importanceTable[3,1], importanceTable[4,1], importanceTable[5,1],
            importanceTable[6,1],SpaCorr$estimate[[1]], TempCorr$estimate[[1]],
            sep="\t"), file=outFile, append=TRUE)
