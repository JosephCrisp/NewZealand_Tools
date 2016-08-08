path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/Sequences/"

########################
# Get the Isolate Data #
########################

# Read the isolate traits information
file <- paste(path, "isolateTraits_NotedMatchedAndClade_14-06-16.txt", sep="")
table <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")

# Create Year column
table$Year <- rep(0, nrow(table))
for(row in 1:nrow(table)){
  
  parts <- strsplit(toString(table[row, 1]), "_")
  table[row, ncol(table)] <- parts[[1]][length(parts[[1]])]
}
table$Year <- as.numeric(table$Year)

#########################################################
# Plot the Temporal Range of Isolates Within Each Clade #
#########################################################

# Open an output PDF
file <- paste(path, "JosephCrisp_22-07-16_Figure2_TemporalRange.pdf", sep="")
pdf(file, height=5, width=6.65)

layout(matrix(c(1,1,1,5,5,5,2,2,3,3,4,4), 2, 6, byrow = TRUE))
par(mar = c(3.1,4.1,3.1,2.1)) # bottom left top right

# Set limts on axis
limits <- c(1980, 2015)

# Calculate the middle of the x axis
middle <- min(table$Year) + (0.5 * (max(table$Year) - min(table$Year)))

# Get a list of the species
species <- sort(unique(table$Species))

# Set the position for the Number of Isolates labels
positions <- c(2010, 2008, 2008, 2008)

# Set the size of the text in the plots
mainCex <- 1
textCex <- 0.6
axisCex <- 0.9
labelCex <- 1

# Create a list of labels for the plots
labels <- c("A", "C", "D", "E")

# Plot the data for each clade
for(clade in 0:max(table$Clade)){
  
  # Select only the isolates from the current clade
  cladeSelected <- table[table$Clade == clade, ]
  
  boxplot(Year ~ Species, data=table, horizontal=TRUE, las=1, cex.axis=0.75,
          border="white", col="white", 
          main=paste("Clade ", (clade + 1), " Isolates", sep=""),
          cex.main=mainCex, pars=list(ylim=limits), axis.lab=axisCex)
  #text(x=1981, y=6, labels[(clade + 1)], cex=1.5)
  mtext(labels[(clade + 1)], side=3, line=0, adj=0, cex=labelCex)
  text(x=positions[(clade + 1)], y=6.4,
       paste("N. Isolates = ", nrow(cladeSelected), sep=""), cex=textCex)
  
  for(i in 1:length(species)){
    
    subset <- cladeSelected[cladeSelected$Species == species[i],]
    
    if(nrow(subset) == 0){
      next
    }
    
    lines(c(min(subset$Year),max(subset$Year)), c(i,i))
    #list <- rep(i, nrow(subset))
    
    
    counts <- table(subset$Year)
    yearsSampled <- as.numeric(rownames(counts))
    
    for(x in 1:length(yearsSampled)){
      points(yearsSampled[x],i, pch=19, col=rgb(0,0,0, 0.25), cex=counts[x])
    }
    text(x=middle, y=(i+0.4), paste("n = ", nrow(subset), sep=""), cex=textCex)
  }
  
}

# Plot the temporal range of the temporally and spatiall matched isolates
cladeSelected <- table[table$Selected == 1, ]

boxplot(Year ~ Species, data=table, horizontal=TRUE, las=1, cex.axis=0.75,
        border="white", col="white", 
        main=paste("Spatially and Temporally Matched Isolates\nFrom Clade 1", sep=""),
        cex.main=mainCex, pars=list(ylim=limits), cex.axis=axisCex)
#text(x=1981, y=6, "B", cex=1.5)
mtext("B", side=3, line=0, adj=0, cex=labelCex)

text(x=2010, y=6.4,
     paste("N. Isolates = ", nrow(cladeSelected), sep=""), cex=textCex)

for(i in 1:length(species)){
  
  subset <- cladeSelected[cladeSelected$Species == species[i],]
  
  if(nrow(subset) == 0){
    next
  }
  
  lines(c(min(subset$Year),max(subset$Year)), c(i,i))
  list <- rep(i, nrow(subset))
  
  
  counts <- table(subset$Year)
  yearsSampled <- as.numeric(rownames(counts))
  
  for(x in 1:length(yearsSampled)){
    points(yearsSampled[x],i, pch=19, col=rgb(0,0,0, 0.25), cex=counts[x])
  }
  text(x=middle, y=(i+0.4), paste("n = ", nrow(subset), sep=""), cex=textCex)
}

dev.off()
