#!/bin/sh
#!/bin/bash

# Create the nexus and isolate trait files necessary for the tip randomisation test
# Author: Joseph Crisp

# Command Line Structure:
# bash CreateRandomWildlifeCattlePairsFiles.sh RandomlySelectWildlifeAndCattle.pl nTimes nToSelect date sequences.nexus out.nexus isolateTraits.txt outIsolateTraits.txt

# RUN SCRIPT USING bash script.sh (in Directory containing Raw Reads)
# Note create permissions first ---> chmod +x script.sh

# Get the input information from the command line
RANDOMPAIRING=$1
NTIMES=$2
NTOSELECT=$3
DATE=$4
NEXUS=$5
OUTNEXUS=$6
TRAITS=$7
OUTTRAITS=$8

# Do NTIMES random shuffles of isolate years
COUNT=0
while [ $COUNT -lt $NTIMES ]
do
	COUNT=`expr $COUNT + 1`
	echo -e "\e[0;34m Selecting Random Pairs of Cattle and Wildlife: \e[0m"$COUNT
	
	# Create a directory to store the data for the select random pairs
	DIRECTORY="RandomWildlifeCattlePair_"$DATE"_"$COUNT
	mkdir $DIRECTORY
	
	# Move into new directory
	cd $DIRECTORY
	
	# Create the output nexus and isolateTraits file
	NEXUSOUT=$OUTNEXUS"-"$COUNT".nexus"
	TRAITSOUT=$OUTTRAITS"-"$COUNT".txt"
	
	# Randomly select pairs of wildlife and cattle
	perl "../"$RANDOMPAIRING $NTOSELECT "../"$TRAITS $TRAITSOUT "../"$NEXUS $NEXUSOUT 
	
	# Move back into the original directory
	cd ..
	
done

echo -e "\e[0;32m Finished. \e[0m"
