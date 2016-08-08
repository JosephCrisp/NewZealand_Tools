library(maps)
library(mapdata)
library(ggmap)

path <- "C:/Users/Joseph Crisp/Desktop/UbuntuSharedFolder/NewZealand/NewAnalyses_12-05-16/SamplingInformation/"

pairedFile <- paste(path, "matchedIsolates_40km-3yrs_02-06-16.csv", sep="")

table <- read.table(pairedFile, header=TRUE, sep=",", quote="", comment.char="")

par(mfrow=c(1,1))

outputFile <- paste(path, "matchedIsolates_40km-3yrs_02-06-16.pdf")
pdf(outputFile)

# Plot the sampling locations onto a map of New Zealand
map <- ggmap( get_googlemap( center=c(172, -42), zoom=6, maptype='satellite',
                             scale = 2),
              size = c(500, 500), extent='device', darken = 0 )

map <- map + 
  geom_point( data = table, aes( x=Longitude, y=Latitude, #colour=Species,
                                 cex=1.5, shape=Species, fill=Species)
                         , size = 8, alpha=0.5) +
  scale_shape_manual(values=c(21, 22, 23, 24, 25)) +
  #scale_color_manual(values=c("cyan", "yellow", "green", "purple", "red")) +
  scale_fill_manual(values=c("cyan", "yellow", "green", "purple", "red")) +
  theme ( legend.position = c(0.65, 0.05), legend.justification = c(0, 0),
          legend.background = element_rect(colour = F, fill = "white"),
          legend.key = element_rect (fill = F, colour = F),
          panel.grid.major = element_blank (), # remove major grid
          panel.grid.minor = element_blank (),  # remove minor grid
          axis.text = element_blank (), 
          axis.title = element_blank (),
          axis.ticks = element_blank () )
#+
#coord_map(xlim=c(169, 175), ylim=c(-46, -40))

plot(map)

levels(table$Species)
#table$Species <- factor(table$Species,
#                        c("POSSUM", "PORCINE", "FERRET", "CERVINE", "BOVINE"))

boxplot(Year ~ Species, data=table, horizontal=TRUE, las=1, cex.axis=0.75,
        border="white", col="white", main="Sampling Range for each Species",
        cex.main=1.5)

middle <- min(table$Year) + (0.5 * (max(table$Year) - min(table$Year)))

species <- sort(unique(table$Species))
for(i in 1:length(species)){
  
  subset <- table[table$Species == species[i],]
  
  lines(c(min(subset$Year),max(subset$Year)), c(i,i))
  list <- rep(i, nrow(subset))
  
  
  counts <- table(subset$Year)
  yearsSampled <- as.numeric(rownames(counts))
  
  for(x in 1:length(yearsSampled)){
    points(yearsSampled[x],i, pch=19, col=rgb(1,0,0, 0.5), cex=counts[x])
  }
  
  
  #points(subset$Year,list, pch=19, col=rgb(1,0,0, 0.3), cex=2)
  text(x=middle, y=(i+0.25), paste("n = ", nrow(subset)), cex=1)
}

dev.off()
