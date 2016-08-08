#!/bin/sh
#!/bin/bash

# Investigating the Impact of Changing the SNP filter Settings
# Author: Joseph Crisp

# RUN SCRIPT USING bash script.sh (in Directory containing Raw Reads)
# Note create permissions first ---> chmod +x script.sh

# Command Line Structure:
# bash FilterSensitivityAnalysis.sh FilterVariants.pl CreateFasta.pl CalculateGeneticDistances.jar FitRandomForestModel.R outputFile.txt


###################
# Necessary Input #
###################

#### Input Files
EPIVARS="epiVariables_10-06-16.txt"
FILTERS="filters_10-06-16.txt"
MERGED="merged_Clade3_28-05-16.txt"

#### Tools
FILTER=$1
CREATEFASTA=$2
GENETICDISTANCES=$3
FITMODEL=$4

# Print out the input files to check
echo -e "\e[0;34mChecking Input Files: \e[0m"
echo "	Epidemiological Variables File: 	"$EPIVARS
echo "	Filter Combinations File: 		"$FILTERS
echo "	Merged VCFs File: 			"$MERGED
echo "	Filtering Variants Tool: 		"$FILTER
echo "	Creating FASTA Tool: 			"$CREATEFASTA
echo "	Calculating Genetic Distances Tool: 	"$GENETICDISTANCES
echo "	R Script to fit Random Forest Model: 	"$FITMODEL


#### Temporary Files
FILTERED="filtered.txt"
COV="SNPCoverage.txt"
FASTA="sequences.fasta"
TABLE="geneticVsEpiTable.txt"
DISTANCES="geneticDistances.txt"
MODELOUTPUT="modelFittingOutput.txt"
SEQQUAL="sequenceQualityMetrics.txt"
TEMP="temporaryFile.txt"

# Create a variable to record when no Variant Positions pass the filtering criteria
NOPASSED=0;

#### Model Fitting Settings

MTRY=4
NTREES=1000

#### Output table
OUTPUT=$5

# WIPE the output Files
> $SEQQUAL
> $MODELOUTPUT

# Calculate the number of filters
NFILTERS=`wc -l $FILTERS | awk '{ split($0, array, " "); print array[1] }'`

####### Examine Multiple Filter Settings #######

# Takes Filter Settings in From File
COUNT=0
while read line
do
	TIME=`date +"%T"`

	COUNT=`expr $COUNT + 1` # Keep track of which filter we're working on (Note expr needed to do arithmetic)
	
	echo -e "\e[0;30mCurrent Filters: \e[0m"$line"   	"$TIME"		"$COUNT" of "$NFILTERS

	# Extract the Filter Settings From Current Line
	VALUES=(`echo $line | awk '{ split($0, array, "\t"); print array[1],array[2],array[3],array[4],array[5],array[6] }'`)

	####### Examine Current Set of Filters #######

	# Filter the Variants
	# DP	HQDP	MQ	SUP	COV
	# 0		1		2		3	4
	# perl FilterVariants.pl verbose DP HQDP MQ AlleleSupport propCoverage QUAL FQ merged.txt filteredSNPs.txt snpCoverage.txt
	NOPASSED=`perl $FILTER 0 ${VALUES[0]} ${VALUES[1]} ${VALUES[2]} ${VALUES[3]} ${VALUES[4]} 0 0 $MERGED $FILTERED $COV | awk '{ split($0, array, " "); print array[1] }'`
	
	# Check that there are some Variant Positions to analyze
	if [ $NOPASSED = 0 ]
	then
	
		# Fill in the output tables with zeros
		echo "0	0" >> $SEQQUAL
		echo "0	0	0	0	0	0	0	0	0	0	0" >> $MODELOUTPUT
	
	else
		
		# Convert to FASTA Sequence File
		# perl CreateFastaFromFiltered.pl verbose proximityFilter filtered.txt output.fasta
		perl $CREATEFASTA 0 ${VALUES[5]} $FILTERED $FASTA
		
		# Check the sequence length
		SEQLENGTH=`head -n 1 $FASTA | awk '{split($0, array, " "); print array[2] }'`
		
		if [ $SEQLENGTH = 0 ]
		then
			
			# Fill in the output tables with zeros
			echo "0	0" >> $SEQQUAL
			echo "0	0	0	0	0	0	0	0	0	0	0" >> $MODELOUTPUT
		
		else
			# Calculate the Inter-Samples Genetic Distances in Java
			# # perl CalculateGeneticDistances.pl sequences.fasta outputFile.txt
			java -jar $GENETICDISTANCES $FASTA $DISTANCES >> $SEQQUAL
	
			# Combine the Output Genetic Distance File to the Epidemiological Variables
			paste $DISTANCES $EPIVARS > $TABLE 
	
			# Run the GLM Model
			Rscript $FITMODEL $TABLE $MODELOUTPUT $MTRY $NTREES
		fi
		
	fi
	
done <$FILTERS

# Combine the Filter Settings and Model Output into Model Fit Table
paste $FILTERS $MODELOUTPUT $SEQQUAL > $OUTPUT

# Add fields to the Model Fit Table
# explained, MSE, predCorr, SpatialImp, TemporalImp, SpeciesImp, LocationImp, AreaImp, REAImp, SpatialCorr, TemporalCorr, SequenceLength, ProportionN
awk 'BEGIN{print "Depth\tHQDepth\tMQ\tSUP\tSNPCov\tProximity\tRSquared\tMSE\tPredictionCorr\tSpatialImp\tTemporalImp\tSpeciesImp\tLocationImp\tAreaImp\tREATypeImp\tSpatialCorr\tTemporalCorr\tNoSNPs\tMeanPropNs"}{print}' $OUTPUT > $TEMP
mv $TEMP $OUTPUT

# Remove Temporary Files
rm $FILTERED
rm $COV
rm $FASTA
rm $TABLE
rm $DISTANCES
#rm $MODELOUTPUT
#rm $SEQQUAL

echo -e "\e[0;35mFinished. \e[0m"
