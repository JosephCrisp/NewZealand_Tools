#!/bin/sh
#!/bin/bash

# Create the nexus and isolate trait files necessary for the tip randomisation test
# Author: Joseph Crisp

# Command Line Structure:
# bash CreateTipRandomisationFiles.sh RandomlyShuffleYearsInNexus.pl nTimes date sequences.nexus out.nexus isolateTraits.txt outIsolateTraits.txt

# RUN SCRIPT USING bash script.sh (in Directory containing Raw Reads)
# Note create permissions first ---> chmod +x script.sh

# Get the input information from the command line
SHUFFLE=$1
NTIMES=$2
DATE=$3
NEXUS=$4
OUTNEXUS=$5
TRAITS=$6
OUTTRAITS=$7

# Do NTIMES random shuffles of isolate years
COUNT=0
while [ $COUNT -lt $NTIMES ]
do
	COUNT=`expr $COUNT + 1`
	echo -e "\e[0;34m Randomly shuffling isolate Years: \e[0m"$COUNT
	
	# Create a directory to store the shuffled data
	DIRECTORY="TipRandomisation_"$DATE"_"$COUNT
	mkdir $DIRECTORY
	
	# Move into new directory
	cd $DIRECTORY
	
	# Create the output nexus and isolateTraits file
	NEXUSOUT=$OUTNEXUS"-"$COUNT".nexus"
	TRAITSOUT=$OUTTRAITS"-"$COUNT".txt"
	
	# Randomly shuffle the isolate sampling years
	perl "../"$SHUFFLE "../"$NEXUS $NEXUSOUT "../"$TRAITS $TRAITSOUT
	
	# Move back into the original directory
	cd ..
	
done

echo -e "\e[0;32m Finished. \e[0m"
