#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Investigate the coverage of the sequenced isolates on the reference genome

# Command Line Structure:
# perl ExamineGenomeCoverage.pl filtered.txt threshold genomeCoverage.txt genomeCoverageSummary.txt missingPositions.txt isolateCoverageSummary.txt 

# Creates file where information for each SNP position is recorded (For each of the samples available):
# #CHROM	POS	Sample 1:Sample 2:Sample 3:...
# 0			1	2
#				|
#				 ---> 	DP	HQDP	MQ	AlleleSupport	AlleleCalled	QUAL	FQ		Result		;
# 						0 	1  		2 	3				5				6		7		8

# Genome coverage file structure:
# POS	filenameA:filenameB:filenameC
# 1		20:2:5
# 		DPA:DPB:DPC
# 0		1

################################################################
# Make a note of the Variant Sites selected for further analysis

# Open the Filtered VP file
my $filtered = shift @ARGV;
open FILTERED, $filtered or die "Couldn't open $filtered:$!";

# Initialise a hashtable to store the Variant Positions
my %variantPositions = ();

# Initialise the necessary variables to process the Filtered VP file
my $line;
my @cols;

# Begin reading the Filtered VP file
while(<FILTERED>){
	$line = $_;
	chomp($line);
	
	# Skip all the VCFheader lines
	next if $line =~ /^#/;
	
	# Store the current Position
	@cols = split /\t/, $line;
	$variantPositions{$cols[1]} = 1;
}
close(FILTERED);

#######################################################################
# Examine the isolate coverage at each position of the Reference Genome

# Get the Read Depth threshold from the command line
my $threshold = shift @ARGV;

# Open the IsolateCoverage file
my $coverage = shift @ARGV;
open COVERAGE, $coverage or die "Couldn't open $coverage:$!";

# Open an output genome coverage file
my $coverageOutput = shift @ARGV;
open GENOMECOV, ">$coverageOutput" or die "Couldn't open $coverageOutput:$!";

# Open a file to record any gaps with no coveraeg in any isolates
my $missingPositions = shift @ARGV;
open MISSING, ">$missingPositions" or die "Couldn't open $missingPositions:$!";

# Initialise a hashtable to store information for each isolate: Index: IsolateID, Species
my @isolateInfoAtIndex = ();
my @info = ();
my @isolateNames = ();

# Initialise variables necessary to fill in positions where there was no coverage in any isolates
my $nPositionsMissed;
my $outputLine;

# Initialise two arrays for calculating the mean coverage and percentage coverage
my @meanDepth = ();
my @percentageCov = ();

# Initialise a variable to record the average coverage at each position on the genome
my $averageDepth;

# Initialise the necessary variables to parse the file
my @parts = ();
my $lineNo = 0;
my $pos;

# Initialise an array to count the number of cattle and badgers with coverage above th threshold
my @nSpecies = ();

# Begin reading the genome coverage file
while(<COVERAGE>){
	$line = $_;
	chomp($line);
	@cols = split /\t/, $line;
	
	# Examine the header
	if($line =~ /^POS/){
		
		print GENOMECOV "POS\tMeanDepth\tSelected\n";#\tNBadgers\tNCattle\tSelected\n";
		
		# Note the column index of each isolate and the species
		# **** VCF file name begins with TB for cattle isolate and WB for badger
		for(my $i = 1; $i < scalar(@cols); $i++){
		
			# Note the isolate id at the current column
			$info[0] = $cols[$i];
		
			# Is the isolate from a cow?
			$info[1] = "BADGER";
			$info[1] = "CATTLE" if $cols[$i] =~ /^TB/;
		
			# Store the isolate info
			@{$isolateInfoAtIndex[$i - 1]} = @info;
		}
		
		# Initialise the arrays for calculating mean depth and percentage coverage
		@meanDepth = (0) x (scalar(@cols) - 1);
		@percentageCov = (0) x (scalar(@cols) - 1);
		next;
	}	
	
	# Record the current line
	$lineNo++;
	
	# Have we skip any genome positions since the last line?
	if($lineNo != $cols[0]){
		
		# Calculate how many positions have been skipped
		$nPositionsMissed = $cols[0] - $lineNo;
		print MISSING "Missing Positions Found: $lineNo\t$cols[0]\t$nPositionsMissed\n";
		
		# Insert a line in the output table
		for(my $i = 0; $i < $nPositionsMissed; $i++){
			
			$pos = $lineNo + $i;
			print GENOMECOV "$pos\t0\t0\n";#\t0\t0\n";
		}
		
		# Update the line number
		$lineNo = $cols[0];
	}
	
	# How many cattle and badger isolates with sufficient coverage at the current position?
	$nSpecies[0] = 0;
	$nSpecies[1] = 0;
	
	# Reset the average depth variable
	$averageDepth = 0;
	
	for(my $i = 1; $i < scalar(@cols); $i++){
		
		# Calculating the average read depth at the current position
		$averageDepth += $cols[$i];
		
		# Get the current isolates info
		@info = @{$isolateInfoAtIndex[$i - 1]};
		
		if($cols[$i] >= $threshold){
		
			$nSpecies[0]++ if $info[1] eq "BADGER";
			$nSpecies[1]++ if $info[1] eq "CATTLE";
		
			# Make the calculations for the percentage coverage
			$percentageCov[$i - 1]++ if $cols[$i] >= $threshold;
		}
		
		# Make the calculations for the mean depth for the current isolate
		$meanDepth[$i - 1] += $cols[$i];
	}
	
	# Calculate the average read depth at the current position across the isolates
	$averageDepth = $averageDepth / scalar(@isolateInfoAtIndex);
	
	# Print out the summary information for the current genome position
	$outputLine = $cols[0] . "\t" . $averageDepth . "\t";# . $nSpecies[0] . "\t" . $nSpecies[1] . "\t";
	
	# Has the current position been selected as a Variant Position
	if(exists($variantPositions{$cols[0]})){
		$outputLine = $outputLine . 1;
	}else{
		$outputLine = $outputLine . 0;
	}
	
	print GENOMECOV "$outputLine\n";
	
	# Print progress information
	if($lineNo % 100000 == 0){
		print "Finished reading current line:\t$lineNo\n";
	}
}	
close(COVERAGE);
close(GENOMECOV);
close(MISSING);

# Print the mean depth and percentage coverage for each isolate
my $isolateCov = shift @ARGV;
open ISOLATECOV, ">$isolateCov" or die "Couldn't open $isolateCov:$!";

# Print a Header
print ISOLATECOV "IsolateID\tMeanDepth\tPercentageCoverage\n";

for(my $i = 0; $i < scalar(@isolateInfoAtIndex); $i++){
	
	# Calculate the mean depth for the current isolate
	my $mean = $meanDepth[$i] / $lineNo;
	
	# Calculate the percentage coverage
	my $percentage = $percentageCov[$i] / $lineNo;
	
	# Get the isolate info
	@info = @{$isolateInfoAtIndex[$i]};
	
	# Print out the isolate's mean depth and percentage coverage
	print ISOLATECOV "$info[0]\t$mean\t$percentage\n";
}
close(ISOLATECOV);