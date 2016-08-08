path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/DiscreteTraitAnalysis/"

####################
# Read in the data #
####################

###### Matched Isolates

# Symmetric
logFileName <- "NZ_13-07-16_MATCHED_HKY_Relaxed-Exp_Skygrid_CATTLE-Symmetric.log.txt"
directory <- "Symmetric/MatchedIsolates/"
file <- paste(path, directory,
              "run_1_13-07-16_MATCHED_CATTLE_SYM/", logFileName, sep="")
matched_SYM_1_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_2_13-07-16_MATCHED_CATTLE_SYM/", logFileName, sep="")
matched_SYM_2_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_3_13-07-16_MATCHED_CATTLE_SYM/", logFileName, sep="")
matched_SYM_3_full <- read.table(file, , header=TRUE, skip=2)

# Asymmetric
logFileName <- "NZ_13-07-16_MATCHED_HKY_Relaxed-Exp_Skygrid_CATTLE-Asymmetric.log.txt"
directory <- "Asymmetric/MatchedIsolates/"
file <- paste(path, directory,
              "run_1_13-07-16_MATCHED_CATTLE_ASYM/", logFileName, sep="")
matched_ASYM_1_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_2_13-07-16_MATCHED_CATTLE_ASYM/", logFileName, sep="")
matched_ASYM_2_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_3_13-07-16_MATCHED_CATTLE_ASYM/", logFileName, sep="")
matched_ASYM_3_full <- read.table(file, , header=TRUE, skip=2)

###### Clade 1 Isolates

# Symmetric
logFileName <- "NZ_14-06-16_CLADE1_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt"
directory <- "Symmetric/Clade1Isolates/"
file <- paste(path, directory,
              "run_1_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_SYM/", logFileName, sep="")
clade1_SYM_1_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_2_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_SYM/", logFileName, sep="")
clade1_SYM_2_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_3_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_SYM/", logFileName, sep="")
clade1_SYM_3_full <- read.table(file, , header=TRUE, skip=2)

# Asymmetric
logFileName <- "NZ_14-06-16_CLADE1_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt"
directory <- "Asymmetric/Clade1Isolates/"
file <- paste(path, directory,
              "run_1_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_ASYM/", logFileName, sep="")
clade1_ASYM_1_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_2_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_ASYM/", logFileName, sep="")
clade1_ASYM_2_full <- read.table(file, , header=TRUE, skip=2)
file <- paste(path, directory,
              "run_3_13-07-16_HKY_Relaxed-Exp_Skygrid_ALL_CATTLE_ASYM/", logFileName, sep="")
clade1_ASYM_3_full <- read.table(file, , header=TRUE, skip=2)

###### Random Wildlife Pairs

# Symmetric
directory <- "Symmetric/RandomCattleWildlifePairing/"
date <- "21-07-16"
run <- 1
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_1_full <- read.table(file, , header=TRUE, skip=2)
run <- 2
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_2_full <- read.table(file, , header=TRUE, skip=2)
run <- 3
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_3_full <- read.table(file, , header=TRUE, skip=2)
run <- 4
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_4_full <- read.table(file, , header=TRUE, skip=2)
run <- 5
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_5_full <- read.table(file, , header=TRUE, skip=2)
run <- 6
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_6_full <- read.table(file, , header=TRUE, skip=2)
run <- 7
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_7_full <- read.table(file, , header=TRUE, skip=2)
run <- 8
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_8_full <- read.table(file, , header=TRUE, skip=2)
run <- 9
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_9_full <- read.table(file, , header=TRUE, skip=2)
run <- 10
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_SYM_10_full <- read.table(file, , header=TRUE, skip=2)

# Asymmetric
directory <- "Asymmetric/RandomCattleWildlifePairing/"
date <- "21-07-16"
run <- 1
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_1_full <- read.table(file, , header=TRUE, skip=2)
run <- 2
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_2_full <- read.table(file, , header=TRUE, skip=2)
run <- 3
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_3_full <- read.table(file, , header=TRUE, skip=2)
run <- 4
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_4_full <- read.table(file, , header=TRUE, skip=2)
run <- 5
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_5_full <- read.table(file, , header=TRUE, skip=2)
run <- 6
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_6_full <- read.table(file, , header=TRUE, skip=2)
run <- 7
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_7_full <- read.table(file, , header=TRUE, skip=2)
run <- 8
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_8_full <- read.table(file, , header=TRUE, skip=2)
run <- 9
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_9_full <- read.table(file, , header=TRUE, skip=2)
run <- 10
folder <- paste(path, directory, "RandomWildlifeCattlePair_", date, "_", run, "/", sep="")
file <- paste(folder, "NZ_CLADE1_RandomPair-", run, "_HKY_Relaxed-Exp_Skygrid_CATTLE.log.txt", sep="")
rand_ASYM_10_full <- read.table(file, , header=TRUE, skip=2)


#############################
# Remove the burn-in period #
#############################

burnIn <- 0.1 * 10000

# Matched
matched_SYM_1 <- matched_SYM_1_full[burnIn:nrow(matched_SYM_1_full),]
matched_SYM_2 <- matched_SYM_2_full[burnIn:nrow(matched_SYM_2_full),]
matched_SYM_3 <- matched_SYM_3_full[burnIn:nrow(matched_SYM_3_full),]
matched_ASYM_1 <- matched_ASYM_1_full[burnIn:nrow(matched_ASYM_1_full),]
matched_ASYM_2 <- matched_ASYM_2_full[burnIn:nrow(matched_ASYM_2_full),]
matched_ASYM_3 <- matched_ASYM_3_full[burnIn:nrow(matched_ASYM_3_full),]

# Clade 1
clade1_SYM_1 <- clade1_SYM_1_full[burnIn:nrow(clade1_SYM_1_full),]
clade1_SYM_2 <- clade1_SYM_2_full[burnIn:nrow(clade1_SYM_2_full),]
clade1_SYM_3 <- clade1_SYM_3_full[burnIn:nrow(clade1_SYM_3_full),]
clade1_ASYM_1 <- clade1_ASYM_1_full[burnIn:nrow(clade1_ASYM_1_full),]
clade1_ASYM_2 <- clade1_ASYM_2_full[burnIn:nrow(clade1_ASYM_2_full),]
clade1_ASYM_3 <- clade1_ASYM_3_full[burnIn:nrow(clade1_ASYM_3_full),]

# Random Pairs
rand_SYM_1 <- rand_SYM_1_full[burnIn:nrow(rand_SYM_1_full),]
rand_SYM_2 <- rand_SYM_2_full[burnIn:nrow(rand_SYM_2_full),]
rand_SYM_3 <- rand_SYM_3_full[burnIn:nrow(rand_SYM_3_full),]
rand_SYM_4 <- rand_SYM_4_full[burnIn:nrow(rand_SYM_4_full),]
rand_SYM_5 <- rand_SYM_5_full[burnIn:nrow(rand_SYM_5_full),]
rand_SYM_6 <- rand_SYM_6_full[burnIn:nrow(rand_SYM_6_full),]
rand_SYM_7 <- rand_SYM_7_full[burnIn:nrow(rand_SYM_7_full),]
rand_SYM_8 <- rand_SYM_8_full[burnIn:nrow(rand_SYM_8_full),]
rand_SYM_9 <- rand_SYM_9_full[burnIn:nrow(rand_SYM_9_full),]
rand_SYM_10 <- rand_SYM_10_full[burnIn:nrow(rand_SYM_10_full),]
rand_ASYM_1 <- rand_ASYM_1_full[burnIn:nrow(rand_ASYM_1_full),]
rand_ASYM_2 <- rand_ASYM_2_full[burnIn:nrow(rand_ASYM_2_full),]
rand_ASYM_3 <- rand_ASYM_3_full[burnIn:nrow(rand_ASYM_3_full),]
rand_ASYM_4 <- rand_ASYM_4_full[burnIn:nrow(rand_ASYM_4_full),]
rand_ASYM_5 <- rand_ASYM_5_full[burnIn:nrow(rand_ASYM_5_full),]
rand_ASYM_6 <- rand_ASYM_6_full[burnIn:nrow(rand_ASYM_6_full),]
rand_ASYM_7 <- rand_ASYM_7_full[burnIn:nrow(rand_ASYM_7_full),]
rand_ASYM_8 <- rand_ASYM_8_full[burnIn:nrow(rand_ASYM_8_full),]
rand_ASYM_9 <- rand_ASYM_9_full[burnIn:nrow(rand_ASYM_9_full),]
rand_ASYM_10 <- rand_ASYM_10_full[burnIn:nrow(rand_ASYM_10_full),]


################################################################
# Scale the transition rates by the estimated trait clock rate #
################################################################

# Matched
matched_SYM_1$Rate <- matched_SYM_1$CATTLE.rates.BOVINE.WILDLIFE * matched_SYM_1$CATTLE.clock.rate
matched_SYM_2$Rate <- matched_SYM_2$CATTLE.rates.BOVINE.WILDLIFE * matched_SYM_2$CATTLE.clock.rate
matched_SYM_3$Rate <- matched_SYM_3$CATTLE.rates.BOVINE.WILDLIFE * matched_SYM_3$CATTLE.clock.rate

matched_ASYM_1$BovineWildlifeRate <- matched_ASYM_1$CATTLE.rates.BOVINE.WILDLIFE * matched_ASYM_1$CATTLE.clock.rate
matched_ASYM_2$BovineWildlifeRate <- matched_ASYM_2$CATTLE.rates.BOVINE.WILDLIFE * matched_ASYM_2$CATTLE.clock.rate
matched_ASYM_3$BovineWildlifeRate <- matched_ASYM_3$CATTLE.rates.BOVINE.WILDLIFE * matched_ASYM_3$CATTLE.clock.rate

matched_ASYM_1$WildlifeBovineRate <- matched_ASYM_1$CATTLE.rates.WILDLIFE.BOVINE * matched_ASYM_1$CATTLE.clock.rate
matched_ASYM_2$WildlifeBovineRate <- matched_ASYM_2$CATTLE.rates.WILDLIFE.BOVINE * matched_ASYM_2$CATTLE.clock.rate
matched_ASYM_3$WildlifeBovineRate <- matched_ASYM_3$CATTLE.rates.WILDLIFE.BOVINE * matched_ASYM_3$CATTLE.clock.rate

# Clade 1
clade1_SYM_1$Rate <- clade1_SYM_1$CATTLE.rates.BOVINE.WILDLIFE * clade1_SYM_1$CATTLE.clock.rate
clade1_SYM_2$Rate <- clade1_SYM_2$CATTLE.rates.BOVINE.WILDLIFE * clade1_SYM_2$CATTLE.clock.rate
clade1_SYM_3$Rate <- clade1_SYM_3$CATTLE.rates.BOVINE.WILDLIFE * clade1_SYM_3$CATTLE.clock.rate

clade1_ASYM_1$BovineWildlifeRate <- clade1_ASYM_1$CATTLE.rates.BOVINE.WILDLIFE * clade1_ASYM_1$CATTLE.clock.rate
clade1_ASYM_2$BovineWildlifeRate <- clade1_ASYM_2$CATTLE.rates.BOVINE.WILDLIFE * clade1_ASYM_2$CATTLE.clock.rate
clade1_ASYM_3$BovineWildlifeRate <- clade1_ASYM_3$CATTLE.rates.BOVINE.WILDLIFE * clade1_ASYM_3$CATTLE.clock.rate

clade1_ASYM_1$WildlifeBovineRate <- clade1_ASYM_1$CATTLE.rates.WILDLIFE.BOVINE * clade1_ASYM_1$CATTLE.clock.rate
clade1_ASYM_2$WildlifeBovineRate <- clade1_ASYM_2$CATTLE.rates.WILDLIFE.BOVINE * clade1_ASYM_2$CATTLE.clock.rate
clade1_ASYM_3$WildlifeBovineRate <- clade1_ASYM_3$CATTLE.rates.WILDLIFE.BOVINE * clade1_ASYM_3$CATTLE.clock.rate

# Random Pairs
rand_SYM_1$Rate <- rand_SYM_1$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_1$CATTLE.clock.rate
rand_SYM_2$Rate <- rand_SYM_2$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_2$CATTLE.clock.rate
rand_SYM_3$Rate <- rand_SYM_3$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_3$CATTLE.clock.rate
rand_SYM_4$Rate <- rand_SYM_4$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_4$CATTLE.clock.rate
rand_SYM_5$Rate <- rand_SYM_5$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_5$CATTLE.clock.rate
rand_SYM_6$Rate <- rand_SYM_6$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_6$CATTLE.clock.rate
rand_SYM_7$Rate <- rand_SYM_7$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_7$CATTLE.clock.rate
rand_SYM_8$Rate <- rand_SYM_8$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_8$CATTLE.clock.rate
rand_SYM_9$Rate <- rand_SYM_9$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_9$CATTLE.clock.rate
rand_SYM_10$Rate <- rand_SYM_10$CATTLE.rates.BOVINE.WILDLIFE * rand_SYM_10$CATTLE.clock.rate

rand_ASYM_1$BovineWildlifeRate <- rand_ASYM_1$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_1$CATTLE.clock.rate
rand_ASYM_2$BovineWildlifeRate <- rand_ASYM_2$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_2$CATTLE.clock.rate
rand_ASYM_3$BovineWildlifeRate <- rand_ASYM_3$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_3$CATTLE.clock.rate
rand_ASYM_4$BovineWildlifeRate <- rand_ASYM_4$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_4$CATTLE.clock.rate
rand_ASYM_5$BovineWildlifeRate <- rand_ASYM_5$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_5$CATTLE.clock.rate
rand_ASYM_6$BovineWildlifeRate <- rand_ASYM_6$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_6$CATTLE.clock.rate
rand_ASYM_7$BovineWildlifeRate <- rand_ASYM_7$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_7$CATTLE.clock.rate
rand_ASYM_8$BovineWildlifeRate <- rand_ASYM_8$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_8$CATTLE.clock.rate
rand_ASYM_9$BovineWildlifeRate <- rand_ASYM_9$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_9$CATTLE.clock.rate
rand_ASYM_10$BovineWildlifeRate <- rand_ASYM_10$CATTLE.rates.BOVINE.WILDLIFE * rand_ASYM_10$CATTLE.clock.rate

rand_ASYM_1$WildlifeBovineRate <- rand_ASYM_1$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_1$CATTLE.clock.rate
rand_ASYM_2$WildlifeBovineRate <- rand_ASYM_2$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_2$CATTLE.clock.rate
rand_ASYM_3$WildlifeBovineRate <- rand_ASYM_3$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_3$CATTLE.clock.rate
rand_ASYM_4$WildlifeBovineRate <- rand_ASYM_4$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_4$CATTLE.clock.rate
rand_ASYM_5$WildlifeBovineRate <- rand_ASYM_5$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_5$CATTLE.clock.rate
rand_ASYM_6$WildlifeBovineRate <- rand_ASYM_6$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_6$CATTLE.clock.rate
rand_ASYM_7$WildlifeBovineRate <- rand_ASYM_7$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_7$CATTLE.clock.rate
rand_ASYM_8$WildlifeBovineRate <- rand_ASYM_8$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_8$CATTLE.clock.rate
rand_ASYM_9$WildlifeBovineRate <- rand_ASYM_9$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_9$CATTLE.clock.rate
rand_ASYM_10$WildlifeBovineRate <- rand_ASYM_10$CATTLE.rates.WILDLIFE.BOVINE * rand_ASYM_10$CATTLE.clock.rate

##############
# Open a PDF #
##############

file <- paste(path, "JosephCrisp_28-07-16_Figure5_DiscreteTraitsAnalysis.pdf", sep="")
pdf(file=file, height=4.41, width=4.41)

# Set the parameters for the plotting window
par(mfrow=c(2,2))
par(mar=c(3,3.5,3,2.1)) # bottom, left, top, right
par(mgp=c(1.5,0.6,0))  # Distance of axis labels from axis: axis labels, tick labels, ticks
boxLwd <- 2
boxColour <- "white"

############################
# Symmetric vs. Asymmetric #
############################

# Matched
matched_SYM_1_likelihood <- c(-77.08863313018054, -76.57502527292169)
matched_SYM_2_likelihood <- c(-77.02422673521718, -76.5057874413775)
matched_SYM_3_likelihood <- c(-77.14266922369826, -76.62328358297611)

matched_ASYM_1_likelihood <- c(-77.32821449106966, -76.90368551211277) # path, stepping stone
matched_ASYM_2_likelihood <- c(-77.31636898076937, -76.88596554434564)
matched_ASYM_3_likelihood <- c(-77.34764605204677, -76.90773525494743)

matched_1_diff <- matched_SYM_1_likelihood[1] - matched_ASYM_1_likelihood[1]
matched_2_diff <- matched_SYM_2_likelihood[1] - matched_ASYM_2_likelihood[1]
matched_3_diff <- matched_SYM_3_likelihood[1] - matched_ASYM_3_likelihood[1]

# Clade 1
clade1_SYM_1_likelihood <- c(-166.35116630841506, -165.97183074814157)
clade1_SYM_2_likelihood <- c(-166.29345208613773, -165.91873477289218)
clade1_SYM_3_likelihood <- c(-166.39617914871997, -166.01553469080227)

clade1_ASYM_1_likelihood <- c(-164.3230538979297, -163.9230890345025) # path, stepping stone
clade1_ASYM_2_likelihood <- c(-164.37425619129718, -163.9758170960307)
clade1_ASYM_3_likelihood <- c(-164.35506640279607, -163.97231727454525)

clade1_1_diff <- clade1_SYM_1_likelihood[1] - clade1_ASYM_1_likelihood[1]
clade1_2_diff <- clade1_SYM_2_likelihood[1] - clade1_ASYM_2_likelihood[1]
clade1_3_diff <- clade1_SYM_3_likelihood[1] - clade1_ASYM_3_likelihood[1]

# Random Pairs
rand_SYM_1_likelihood <- c(-50.096168763475276, -50.00660846029344)
rand_SYM_2_likelihood <- c(-52.70095674558882, -52.58202728318237)
rand_SYM_3_likelihood <- c(-51.48945940549255, -51.42189663376228)
rand_SYM_4_likelihood <- c(-55.05780366569805, -54.87458046699224)
rand_SYM_5_likelihood <- c(-62.53901729519472, -62.30215721998595)
rand_SYM_6_likelihood <- c(-56.575995011998394, -56.46850705002142)
rand_SYM_7_likelihood <- c(-62.23657143142437, -62.01199199512588)
rand_SYM_8_likelihood <- c(-61.222022229531824, -61.080325993258796)
rand_SYM_9_likelihood <- c(-52.991018275932056, -52.87978048068508)
rand_SYM_10_likelihood <- c(-51.77556729040687, -51.721217882408375)

rand_ASYM_1_likelihood <- c(-46.57536518180652, -46.50886332604239)
rand_ASYM_2_likelihood <- c(-49.76943801422615, -49.664608827765484)
rand_ASYM_3_likelihood <- c(-50.079803431299304, -50.02630394082481)
rand_ASYM_4_likelihood <- c(-54.14370472398203, -53.99311488894292)
rand_ASYM_5_likelihood <- c(-60.80360712693681, -60.61536493631902)
rand_ASYM_6_likelihood <- c(-54.53784435395407, -54.444608567202344)
rand_ASYM_7_likelihood <- c(-60.31411976554067, -60.1448336120696)
rand_ASYM_8_likelihood <- c(-60.30076402923622, -60.175444098237726)
rand_ASYM_9_likelihood <- c(-49.61627037503539, -49.53283713186783)
rand_ASYM_10_likelihood <- c(-49.31200142025338, -49.26862778027097)

rand_1_diff <- rand_SYM_1_likelihood[1] - rand_ASYM_1_likelihood[1]
rand_2_diff <- rand_SYM_2_likelihood[1] - rand_ASYM_2_likelihood[1]
rand_3_diff <- rand_SYM_3_likelihood[1] - rand_ASYM_3_likelihood[1]
rand_4_diff <- rand_SYM_4_likelihood[1] - rand_ASYM_4_likelihood[1]
rand_5_diff <- rand_SYM_5_likelihood[1] - rand_ASYM_5_likelihood[1]
rand_6_diff <- rand_SYM_6_likelihood[1] - rand_ASYM_6_likelihood[1]
rand_7_diff <- rand_SYM_7_likelihood[1] - rand_ASYM_7_likelihood[1]
rand_8_diff <- rand_SYM_8_likelihood[1] - rand_ASYM_8_likelihood[1]
rand_9_diff <- rand_SYM_9_likelihood[1] - rand_ASYM_9_likelihood[1]
rand_10_diff <- rand_SYM_10_likelihood[1] - rand_ASYM_10_likelihood[1]

###### Plot the difference between the likelihoods of the Symmetric and Asymmetric models
table <- data.frame(Matched=c(matched_1_diff, matched_2_diff, matched_3_diff, rep(NA, 7)),
                    Clade1=c(clade1_1_diff, clade1_2_diff, clade1_3_diff, rep(NA, 7)),
                    Random=c(rand_1_diff, rand_2_diff, rand_3_diff, rand_4_diff, rand_5_diff,
                                   rand_6_diff, rand_7_diff, rand_8_diff, rand_9_diff, rand_10_diff))

cexMain <- 0.65
cexLab <- 0.6
cexAxis <- 0.5
labelCex <- 0.8

boxplot(table, las=1, cex.main=cexMain, cex.lab=cexLab, cex.axis=cexAxis,
        main="Difference between Symmetric and \nAsymmetric model Likelihood Scores",
        ylab="Difference between Path Sampling \nLog Marginal Likelihoods",
        mgp = c(3, 0.5, 0))
lines(x=c(0.5, 3.5), y=c(0, 0), lty=3, col=rgb(0,0,0, 1))
text(x=2.5, y=0.2, labels="Symmetric Model", cex=0.5)
text(x=2.5, y=-0.2, labels="Asymmetric Model", cex=0.5)

box(which = "figure", lty = "solid", col=boxColour, lwd=boxLwd)

#text(x=0.6, y=-3, "A", cex=1)
mtext("A", side=3, line=0, adj=0, cex=labelCex)

###############################
# State Transition Clock Rate #
###############################

lwd <- 1
alpha <- 0.7
cexMain <- 0.65
cexLab <- 0.6
cexLegend <- 0.5
cexAxis <- 0.5

# Set the colours
allCol <- rgb(1,0,1, alpha)
matchedCol <- rgb(0,1,1, alpha)
randomCol <- rgb(0,0,0, alpha)
allColLeg <- rgb(1,0,1, 1)
matchedColLeg <- rgb(0,1,1, 1)
randomColLeg <- rgb(0,0,0, 1)

# Get the limits for the x-axis
estimates <- c(matched_SYM_1$CATTLE.clock.rate, matched_SYM_2$CATTLE.clock.rate, matched_SYM_3$CATTLE.clock.rate,
               
               clade1_ASYM_1$CATTLE.clock.rate, clade1_ASYM_2$CATTLE.clock.rate, clade1_ASYM_3$CATTLE.clock.rate, 
               
               rand_ASYM_1$CATTLE.clock.rate, rand_ASYM_2$CATTLE.clock.rate, rand_ASYM_3$CATTLE.clock.rate, rand_ASYM_4$CATTLE.clock.rate, rand_ASYM_5$CATTLE.clock.rate, rand_ASYM_6$CATTLE.clock.rate, rand_ASYM_7$CATTLE.clock.rate, rand_ASYM_8$CATTLE.clock.rate, rand_ASYM_9$CATTLE.clock.rate, rand_ASYM_10$CATTLE.clock.rate
               )
xLim <- c(min(estimates), max(estimates))

# Create the breaks for the histogram
breaks <- seq(from=xLim[1], to=xLim[2] + 0.0005, by=0.0005)

# Create each of the histograms
matched_SYM_1_Hist <- hist(matched_SYM_1$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
matched_SYM_2_Hist <- hist(matched_SYM_2$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
matched_SYM_3_Hist <- hist(matched_SYM_3$CATTLE.clock.rate, breaks=breaks, plot=FALSE)

clade1_ASYM_1_Hist <- hist(clade1_ASYM_1$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
clade1_ASYM_2_Hist <- hist(clade1_ASYM_2$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
clade1_ASYM_3_Hist <- hist(clade1_ASYM_3$CATTLE.clock.rate, breaks=breaks, plot=FALSE)

rand_ASYM_1_Hist <- hist(rand_ASYM_1$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_2_Hist <- hist(rand_ASYM_2$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_3_Hist <- hist(rand_ASYM_3$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_4_Hist <- hist(rand_ASYM_4$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_5_Hist <- hist(rand_ASYM_5$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_6_Hist <- hist(rand_ASYM_6$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_7_Hist <- hist(rand_ASYM_7$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_8_Hist <- hist(rand_ASYM_8$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_9_Hist <- hist(rand_ASYM_9$CATTLE.clock.rate, breaks=breaks, plot=FALSE)
rand_ASYM_10_Hist <- hist(rand_ASYM_10$CATTLE.clock.rate, breaks=breaks, plot=FALSE)

# Set a bound for the x axis
xMax <- 0.025
#xMax <- xLim[2]

# Get the y axis limits
yMax <- max(
  matched_SYM_1_Hist$counts, matched_SYM_2_Hist$counts, matched_SYM_3_Hist$counts,
  clade1_ASYM_1_Hist$counts, clade1_ASYM_2_Hist$counts, clade1_ASYM_3_Hist$counts,
  rand_ASYM_1_Hist$counts, rand_ASYM_2_Hist$counts, rand_ASYM_3_Hist$counts, rand_ASYM_4_Hist$counts, rand_ASYM_5_Hist$counts, rand_ASYM_6_Hist$counts, rand_ASYM_7_Hist$counts, rand_ASYM_8_Hist$counts, rand_ASYM_9_Hist$counts, rand_ASYM_10_Hist$counts
)

plot(rand_ASYM_1_Hist$breaks, c(rand_ASYM_1_Hist$counts, 0),
     type="s", lwd=lwd,  
     main="State Transition Rate",
     xlab="Rate (Events/Lineage/Year)",
     ylab="Number Posterior Samples",
     xlim=c(xLim[1], xMax), ylim=c(0, yMax), col=randomCol,
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis, las=1)

lines(rand_ASYM_2_Hist$breaks, c(rand_ASYM_2_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_3_Hist$breaks, c(rand_ASYM_3_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_4_Hist$breaks, c(rand_ASYM_4_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_5_Hist$breaks, c(rand_ASYM_5_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_6_Hist$breaks, c(rand_ASYM_6_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_7_Hist$breaks, c(rand_ASYM_7_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_8_Hist$breaks, c(rand_ASYM_8_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_9_Hist$breaks, c(rand_ASYM_9_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)
lines(rand_ASYM_10_Hist$breaks, c(rand_ASYM_10_Hist$counts, 0), type="s", lwd=lwd, col=randomCol)

lines(clade1_ASYM_1_Hist$breaks, c(clade1_ASYM_1_Hist$counts, 0), type="s", lwd=lwd, col=allCol)
lines(clade1_ASYM_2_Hist$breaks, c(clade1_ASYM_2_Hist$counts, 0), type="s", lwd=lwd, col=allCol)
lines(clade1_ASYM_3_Hist$breaks, c(clade1_ASYM_3_Hist$counts, 0), type="s", lwd=lwd, col=allCol)

lines(matched_SYM_1_Hist$breaks, c(matched_SYM_1_Hist$counts, 0), type="s", lwd=lwd, col=matchedCol)
lines(matched_SYM_2_Hist$breaks, c(matched_SYM_2_Hist$counts, 0), type="s", lwd=lwd, col=matchedCol)
lines(matched_SYM_3_Hist$breaks, c(matched_SYM_3_Hist$counts, 0), type="s", lwd=lwd, col=matchedCol)

legend("topright", legend=c("All", "Matched", "Random Pairs"),
       text.col=c(allColLeg, matchedColLeg, randomColLeg), bty="n", cex=cexLegend)

#text(x=0.001, y=1250, "B", cex=1)
mtext("B", side=3, line=0, adj=0, cex=labelCex)

box(which = "figure", lty = "solid", col=boxColour, lwd=boxLwd)

#####################################
# Asymmetric State Transition Rates #
#####################################

# Set the colours
BovineWildlifeCol <- rgb(1,0,0, alpha)
WildlifeBovineCol <- rgb(0,0,1, alpha)
BovineWildlifeColLeg <- rgb(1,0,0, 1)
WildlifeBovineColLeg <- rgb(0,0,1, 1)

# Get the limits for the x axis
estimates <- c(clade1_ASYM_1$BovineWildlifeRate, clade1_ASYM_1$WildlifeBovineRate,
               clade1_ASYM_2$BovineWildlifeRate, clade1_ASYM_2$WildlifeBovineRate, 
               clade1_ASYM_3$BovineWildlifeRate, clade1_ASYM_3$WildlifeBovineRate, 
               
               rand_ASYM_1$BovineWildlifeRate, rand_ASYM_1$WildlifeBovineRate,
               rand_ASYM_2$BovineWildlifeRate, rand_ASYM_2$WildlifeBovineRate, 
               rand_ASYM_3$BovineWildlifeRate, rand_ASYM_3$WildlifeBovineRate,
               rand_ASYM_4$BovineWildlifeRate, rand_ASYM_4$WildlifeBovineRate,
               rand_ASYM_5$BovineWildlifeRate, rand_ASYM_5$WildlifeBovineRate,
               rand_ASYM_6$BovineWildlifeRate, rand_ASYM_6$WildlifeBovineRate,
               rand_ASYM_7$BovineWildlifeRate, rand_ASYM_7$WildlifeBovineRate,
               rand_ASYM_8$BovineWildlifeRate, rand_ASYM_8$WildlifeBovineRate,
               rand_ASYM_9$BovineWildlifeRate, rand_ASYM_9$WildlifeBovineRate,
               rand_ASYM_10$BovineWildlifeRate, rand_ASYM_10$WildlifeBovineRate)
xLim <- c(min(estimates), max(estimates)) 

# Create the breaks for the histogram
breaks <- seq(from=xLim[1], to=xLim[2] + 0.0001, by=0.0001)

# Create each of the histograms
clade1_ASYM_1_Hist_BovineWildlifeRate <- hist(clade1_ASYM_1$BovineWildlifeRate, breaks=breaks, plot=FALSE)
clade1_ASYM_1_Hist_WildlifeBovineRate <- hist(clade1_ASYM_1$WildlifeBovineRate, breaks=breaks, plot=FALSE)
clade1_ASYM_2_Hist_BovineWildlifeRate <- hist(clade1_ASYM_2$BovineWildlifeRate, breaks=breaks, plot=FALSE)
clade1_ASYM_2_Hist_WildlifeBovineRate <- hist(clade1_ASYM_2$WildlifeBovineRate, breaks=breaks, plot=FALSE)
clade1_ASYM_3_Hist_BovineWildlifeRate <- hist(clade1_ASYM_3$BovineWildlifeRate, breaks=breaks, plot=FALSE)
clade1_ASYM_3_Hist_WildlifeBovineRate <- hist(clade1_ASYM_3$WildlifeBovineRate, breaks=breaks, plot=FALSE)

rand_ASYM_1_Hist_BovineWildlifeRate <- hist(rand_ASYM_1$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_1_Hist_WildlifeBovineRate <- hist(rand_ASYM_1$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_2_Hist_BovineWildlifeRate <- hist(rand_ASYM_2$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_2_Hist_WildlifeBovineRate <- hist(rand_ASYM_2$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_3_Hist_BovineWildlifeRate <- hist(rand_ASYM_3$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_3_Hist_WildlifeBovineRate <- hist(rand_ASYM_3$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_4_Hist_BovineWildlifeRate <- hist(rand_ASYM_4$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_4_Hist_WildlifeBovineRate <- hist(rand_ASYM_4$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_5_Hist_BovineWildlifeRate <- hist(rand_ASYM_5$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_5_Hist_WildlifeBovineRate <- hist(rand_ASYM_5$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_6_Hist_BovineWildlifeRate <- hist(rand_ASYM_6$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_6_Hist_WildlifeBovineRate <- hist(rand_ASYM_6$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_7_Hist_BovineWildlifeRate <- hist(rand_ASYM_7$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_7_Hist_WildlifeBovineRate <- hist(rand_ASYM_7$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_8_Hist_BovineWildlifeRate <- hist(rand_ASYM_8$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_8_Hist_WildlifeBovineRate <- hist(rand_ASYM_8$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_9_Hist_BovineWildlifeRate <- hist(rand_ASYM_9$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_9_Hist_WildlifeBovineRate <- hist(rand_ASYM_9$WildlifeBovineRate, breaks=breaks, plot=FALSE)
rand_ASYM_10_Hist_BovineWildlifeRate <- hist(rand_ASYM_10$BovineWildlifeRate, breaks=breaks, plot=FALSE)
rand_ASYM_10_Hist_WildlifeBovineRate <- hist(rand_ASYM_10$WildlifeBovineRate, breaks=breaks, plot=FALSE)

### Plot for ALL ISOLATES ###

# Get the y axis limit
yMax <- max(
  clade1_ASYM_1_Hist_BovineWildlifeRate$counts, clade1_ASYM_1_Hist_WildlifeBovineRate$counts,
  clade1_ASYM_2_Hist_BovineWildlifeRate$counts, clade1_ASYM_2_Hist_WildlifeBovineRate$counts,
  clade1_ASYM_3_Hist_BovineWildlifeRate$counts, clade1_ASYM_3_Hist_WildlifeBovineRate$counts
)

plot(clade1_ASYM_1_Hist_BovineWildlifeRate$breaks, c(clade1_ASYM_1_Hist_BovineWildlifeRate$counts, 0),
     type="s", lwd=lwd,
     main="Estimating Direction:\nClade 1 Isolates",
     xlab="Rate (Events/Lineage/Year)",
     ylab="Number Posterior Samples",
     xlim=c(xLim[1], xMax), ylim=c(0, yMax), col=BovineWildlifeCol,
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis, las=1)

lines(clade1_ASYM_2_Hist_BovineWildlifeRate$breaks, c(clade1_ASYM_2_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(clade1_ASYM_3_Hist_BovineWildlifeRate$breaks, c(clade1_ASYM_3_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)

lines(clade1_ASYM_1_Hist_WildlifeBovineRate$breaks, c(clade1_ASYM_1_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(clade1_ASYM_2_Hist_WildlifeBovineRate$breaks, c(clade1_ASYM_2_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(clade1_ASYM_3_Hist_WildlifeBovineRate$breaks, c(clade1_ASYM_3_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)

estimates <- c(clade1_ASYM_1$BovineWildlifeRate, clade1_ASYM_2$BovineWildlifeRate, clade1_ASYM_3$BovineWildlifeRate)
medianBovineWildlifeRate <- round(median(estimates), 3)
quantilesBovineWildlifeRate <- round(quantile(estimates, c(0.025, 0.975)), 3)

estimates <- c(clade1_ASYM_1$WildlifeBovineRate, clade1_ASYM_2$WildlifeBovineRate, clade1_ASYM_3$WildlifeBovineRate)
medianWildlifeBovineRate <- round(median(estimates), 3)
quantilesWildlifeBovineRate <- round(quantile(estimates, c(0.025, 0.975)), 3)

legend("topright", legend=c("Cattle to Wildlife", "Wildlife to Cattle"),
       text.col=c(BovineWildlifeColLeg, WildlifeBovineColLeg), bty="n", cex=cexLegend)
legend("right", legend=c(paste(medianBovineWildlifeRate, " [", quantilesBovineWildlifeRate[[1]], ", ", quantilesBovineWildlifeRate[[2]], "]", sep=""),
                         paste(medianWildlifeBovineRate, " [", quantilesWildlifeBovineRate[[1]], ", ", quantilesWildlifeBovineRate[[2]], "]", sep="")),
       text.col=c(BovineWildlifeColLeg, WildlifeBovineColLeg), bty="n", cex=cexLegend)


#(x=0.005, y=170, "C", cex=1)
mtext("C", side=3, line=0, adj=0, cex=labelCex)

box(which = "figure", lty = "solid", col=boxColour, lwd=boxLwd)

### RANDOM PAIRS ###

# Get the y axis limit
yMax <- max(
  rand_ASYM_1_Hist_BovineWildlifeRate$counts, rand_ASYM_1_Hist_WildlifeBovineRate$counts,
  rand_ASYM_2_Hist_BovineWildlifeRate$counts, rand_ASYM_2_Hist_WildlifeBovineRate$counts,
  rand_ASYM_3_Hist_BovineWildlifeRate$counts, rand_ASYM_3_Hist_WildlifeBovineRate$counts,
  rand_ASYM_4_Hist_BovineWildlifeRate$counts, rand_ASYM_4_Hist_WildlifeBovineRate$counts,
  rand_ASYM_5_Hist_BovineWildlifeRate$counts, rand_ASYM_5_Hist_WildlifeBovineRate$counts,
  rand_ASYM_6_Hist_BovineWildlifeRate$counts, rand_ASYM_6_Hist_WildlifeBovineRate$counts,
  rand_ASYM_7_Hist_BovineWildlifeRate$counts, rand_ASYM_7_Hist_WildlifeBovineRate$counts,
  rand_ASYM_8_Hist_BovineWildlifeRate$counts, rand_ASYM_8_Hist_WildlifeBovineRate$counts,
  rand_ASYM_9_Hist_BovineWildlifeRate$counts, rand_ASYM_9_Hist_WildlifeBovineRate$counts,
  rand_ASYM_10_Hist_BovineWildlifeRate$counts, rand_ASYM_10_Hist_WildlifeBovineRate$counts
)

plot(rand_ASYM_1_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_1_Hist_BovineWildlifeRate$counts, 0),
     type="s", lwd=lwd,
     main="Estimating Direction:\nRandom Cattle-Wildlife Pairs",
     xlab="Rate (Events/Lineage/Year)",
     ylab="Number Posterior Samples",
     xlim=c(xLim[1], xMax), ylim=c(0, yMax), col=BovineWildlifeCol,
     cex.lab=cexLab, cex.main=cexMain, cex.axis=cexAxis)

lines(rand_ASYM_2_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_2_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_3_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_3_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_4_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_4_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_5_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_5_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_6_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_6_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_7_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_7_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_8_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_8_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_9_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_9_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)
lines(rand_ASYM_10_Hist_BovineWildlifeRate$breaks, c(rand_ASYM_10_Hist_BovineWildlifeRate$counts, 0), type="s", lwd=lwd, col=BovineWildlifeCol)

lines(rand_ASYM_1_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_1_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_2_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_2_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_3_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_3_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_4_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_4_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_5_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_5_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_6_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_6_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_7_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_7_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_8_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_8_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_9_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_9_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)
lines(rand_ASYM_10_Hist_WildlifeBovineRate$breaks, c(rand_ASYM_10_Hist_WildlifeBovineRate$counts, 0), type="s", lwd=lwd, col=WildlifeBovineCol)

estimates <- c(rand_ASYM_1$BovineWildlifeRate, rand_ASYM_2$BovineWildlifeRate, rand_ASYM_3$BovineWildlifeRate,
               rand_ASYM_4$BovineWildlifeRate, rand_ASYM_5$BovineWildlifeRate, rand_ASYM_6$BovineWildlifeRate,
               rand_ASYM_7$BovineWildlifeRate, rand_ASYM_8$BovineWildlifeRate, rand_ASYM_9$BovineWildlifeRate,
               rand_ASYM_10$BovineWildlifeRate)
medianBovineWildlifeRate <- round(median(estimates), 3)
quantilesBovineWildlifeRate <- round(quantile(estimates, c(0.025, 0.975)), 3)

estimates <- c(rand_ASYM_1$WildlifeBovineRate, rand_ASYM_2$WildlifeBovineRate, rand_ASYM_3$WildlifeBovineRate,
               rand_ASYM_4$WildlifeBovineRate, rand_ASYM_5$WildlifeBovineRate, rand_ASYM_6$WildlifeBovineRate,
               rand_ASYM_7$WildlifeBovineRate, rand_ASYM_8$WildlifeBovineRate, rand_ASYM_9$WildlifeBovineRate,
               rand_ASYM_10$WildlifeBovineRate)
medianWildlifeBovineRate <- round(median(estimates), 3)
quantilesWildlifeBovineRate <- round(quantile(estimates, c(0.025, 0.975)), 3)

legend("topright", legend=c(
  paste(medianBovineWildlifeRate, " [", quantilesBovineWildlifeRate[[1]], ", ", quantilesBovineWildlifeRate[[2]], "]", sep=""),
  paste(medianWildlifeBovineRate, " [", quantilesWildlifeBovineRate[[1]], ", ", quantilesWildlifeBovineRate[[2]], "]", sep="")),
  text.col=c(BovineWildlifeColLeg, WildlifeBovineColLeg), bty="n", cex=cexLegend)

#text(x=0.005, y=1180, "D", cex=1)
mtext("D", side=3, line=0, adj=0, cex=labelCex)

box(which = "figure", lty = "solid", col=boxColour, lwd=boxLwd)

dev.off()

