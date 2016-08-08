#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements

# Author: Joseph Crisp
# Remove particular isolates from the filter variant positions file

# Command Line Run Structure: 
# perl RemoveIsolatesFromMerged.pl clade isolateClades.txt merged.txt output.txt

# Isolate Clades file structure:
# IsolateId		CladeIndex
# 12754_7#10	0
# 0				1

# Merged.txt file structure:
# ## Header lines
# #CHROM	POS	Sample 1:Sample 2:Sample 3:...
# 0			1	2
#				|
#				 ---> 	DP	HQDP	MQ	QUAL	FQ	RefAlt		;
# 						0 	1  		2 	3		4	5	

# Note the clade to keep
my $clade = shift @ARGV;

# Read in the isolate clade file
my $isolateClades = shift @ARGV;
open CLADES, $isolateClades or die "Couldn't open $isolateClades:$!";

# Initialise a hashtable to note which isolates to ignore
my %remove = ();

# Read the sample information file
my $line;
my @cols;

while(<CLADES>){
	$line = $_;
	next if $line =~ /^IsolateId/;
	chomp($line);
	@cols = split /\t/, $line;
	
	# Store the IDs of the isolates NOT in the selected clade
	$remove{$cols[0]} = 1 if $cols[1] != $clade;
	
}
close(CLADES);


# Open the mergedVPs.txt file
my $mergedFile = shift @ARGV;
open MERGED, $mergedFile or die "Couldn't open $mergedFile:$!";

# Initialise an array of indices (columns) to keep
my @colIndices = ();
my $index;
my @isolateInfo = ();
my $sampleId;
my $outputLine = "";
my @parts;

# Open an output file
my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile\n";

# Read the mergedVPs.txt file
while(<MERGED>){
	$line = $_;
	chomp($line);
	
	# Print out the header information
	if($line =~ /^##/){
		print OUTPUT "$line\n";
		next;
	}
	
	@cols = split /\t/, $line;
	@isolateInfo = split /\:/, $cols[2];
		
	# Find the fields line: use list of vcf file names: N49_S5_14.vcf
	if($line =~ /^#/){
	
		# Create an array of indices (columns) to keep
		$index = -1;
		for(my $i = 0; $i < scalar(@isolateInfo); $i++){
			
			# Get the sample ID (if begins with N, then change to AgR)
			@parts = split /\_/, $isolateInfo[$i];
			$sampleId = $parts[0];
			$sampleId = $parts[0] . "_" . $parts[1] if $parts[0] !~ /^AgR/ && $parts[0] !~ /^Ref/ && $parts[0] !~ /^N/;

			# Skip isolates we want to ignore
			next if exists($remove{$sampleId});
			
			# Store the index of the column (of isolate's information) to be kept
			$index++;
			$colIndices[$index] = $i;
			$outputLine = $outputLine . ":" . $isolateInfo[$i];
		}

		# Print out the fields line but with only the vcfFile names of isolates we want to keep
		$outputLine = $cols[0] . "\t" . $cols[1] . "\t" . substr($outputLine, 1); # substr removes the first ":" - saves coding ;-)
		print OUTPUT "$outputLine\n";
		next;
	}
	
	# Only print out information for isolates interested in keeping
	$outputLine = "";
	foreach my $i(@colIndices){
		$outputLine = $outputLine . ":" . $isolateInfo[$i];
	}
	$outputLine = $cols[0] . "\t" . $cols[1] . "\t" . substr($outputLine, 1);
	print OUTPUT "$outputLine\n";
}
close(MERGED);
close(OUTPUT);
