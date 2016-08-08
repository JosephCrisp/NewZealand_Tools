library(maps)
library(mapdata)
library(ggmap)

path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/Sequences/"
file <- paste(path, "isolateTraits_NotedMatchedAndClade_14-06-16.txt", sep="")

table <- read.table(file, header=TRUE, sep="\t", quote="", comment.char="")

# Change class of clade column to factor
table$Clade <- as.factor(table$Clade)
table$Selected <- as.factor(table$Selected)

# Order the table so that the none selected go first!
table <- table[order(table$Selected), ]

# Create Year column
table$Year <- rep(0, nrow(table))
for(row in 1:nrow(table)){
  
  parts <- strsplit(toString(table[row, 1]), "_")
  table[row, ncol(table)] <- parts[[1]][length(parts[[1]])]
}
table$Year <- as.numeric(table$Year)

# Replace BOVINE and NONBOVINE with CATTLE and WILDLIFE
table$State <- as.character(table$CATTLE)
table$State[table$State == "NONBOVINE"] <- "WILDLIFE"
table$State[table$State == "BOVINE"] <- "CATTLE"


# Open an output PDF
file <- paste(path, "JosephCrisp_22-07-16_Figure1B_SamplingLocations.pdf", sep="")
pdf(file, height=6.65, width=6.65)

# Plot the sampling locations onto a map of New Zealand
map <- ggmap( get_googlemap( center=c(172, -42), zoom=6,
                             maptype='terrain',
                             scale = 2, color="bw"),
              size = c(500, 500), extent='device', darken = 0 )

map <- map + 
  geom_point( data = table, aes( x=Longitude, y=Latitude, colour=Selected, size=Size,
                                 shape=State, fill=Clade, alpha=Selected)
              , size=3,
              position=position_jitter(w=0.1, h=0.1)) +
  
  scale_shape_manual(values=c(22, 24)) +
  scale_alpha_manual(values=c(0.2, 1), guide=FALSE) +
  scale_colour_manual(values=c("black", "white"), guide=FALSE) +
  #scale_size(range=c(5, 10), guide=FALSE) +
  #scale_fill_gradient(low="red", high="yellow") +
  scale_fill_manual(values=c("red", "gold", "blue", "green"), guide=FALSE) +
  #geom_jitter() + 
  guides(shape = guide_legend(override.aes = list(size=8, alpha=1), title=NULL)) + 
  theme ( legend.position = c(0.65, 0.05), legend.justification = c(0, 0),
          legend.background = element_rect(colour = FALSE, fill = "white"),
          legend.key = element_rect (fill = FALSE, colour = FALSE),
          panel.grid.major = element_blank (), # remove major grid
          panel.grid.minor = element_blank (),  # remove minor grid
          axis.text = element_blank (), 
          axis.title = element_blank (),
          axis.ticks = element_blank ())

plot(map)

dev.off()

