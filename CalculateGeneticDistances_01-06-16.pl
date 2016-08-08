#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements

# Author: Joseph Crisp
# Calculate the Genetic Distances between Isolates

# Command Line Run Structure: Should be ran in Directory with VCF Files
# perl CalculateGeneticDistances.pl sequences.fasta outputFile.txt

# Fasta File Structure
# 	2 18					noSamples sequenceLength
#	>Sample1ID
#	GCTGATCGTGNGTAGGCC
#	>Sample2ID
#	GCTGATCGTGNGTAGGCT


####### Read the Sequences in from the FASTA file #######

my $fastaFile = shift @ARGV;
open FASTA, $fastaFile or die "Couldn't open $fastaFile:$!";

# Initialise the necessary variables
my $line;
my @cols = ();
my @sequences = (); # This will be a matrix (sequences stored as character arrays)
my $sequence;
my $seqIndex = -1;
my $lineNo = 0;
my $seqLength;

# Read the FASTA file
while(<FASTA>){
	$lineNo++;
	$line = $_;
	chomp($line);
	
	if($line =~ /^[0-9]/){
		$seqLength = (split /\ /, $line)[1];
		next;
	}
	
	# Are we looking at a new isolate?
	if($line =~ /^>/){
		@cols = split /\_/, $line;
		
		# Store the previous isolate's sequence
		if($lineNo > 2){
			$seqIndex++;
			
			@{$sequences[$seqIndex]} = split //, $sequence;			
		}
		
		# Reset the sequence
		$sequence = "";
	}else{
	
		$sequence = $sequence . "" . $line;
	}
}
close(FASTA);

# Store the last isolate's sequence
$seqIndex++;
@{$sequences[$seqIndex]} = split //, $sequence;	

####### Calculate the Genetic Distances between the isolates #######

my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile:$!";

# Print out a header into the output file
print OUTPUT "Genetic\n";

# Initialise the necessary variables
my @seqI;
my @seqJ;
my $noDiff;
my $distance;

# Initialise variables to record quality information
my @supportForSNPs = (0) x $seqLength;
my @proportionNs = (0) x scalar(@sequences);
my $noNs;

for(my $i = 0; $i < scalar(@sequences); $i++){

	# Get sequence for isolate I
	@seqI = @{$sequences[$i]};
	
	# Look at the sequence quality
	$noNs = 0;
	for(my $x = 0; $x < scalar(@seqI); $x++){
		
		if($seqI[$x] ne 'N'){
			$supportForSNPs[$x]++;
		}else{
			$noNs++;
		}
	}
	$proportionNs[$i] = 0;
	$proportionNs[$i] = $noNs / $seqLength if $seqLength != 0;
	
	for(my $j = 0; $j < scalar(@sequences); $j++){
	
		# Make the comparison once and avoid self comparisons
		next if $i >= $j;
		
		# Get sequence for isolate J
		@seqJ = @{$sequences[$j]};
		
		# Count the number of differences between the sequences
		$noDiff = 0;
		for(my $x = 0; $x < scalar(@seqI); $x++){
			
			$noDiff++ if $seqI[$x] ne $seqJ[$x] && $seqI[$x] ne 'N' && $seqJ[$x] ne 'N';			
		}
		
		# Print out the genetic distance (note that here we use the number of differences (SNPs)
		$distance = $noDiff;
		print OUTPUT "$distance\n";
	}
}
close(OUTPUT);

# Calculate average proportion Ns
my $meanPropNs = 0;
for(my $i = 0; $i < scalar(@proportionNs); $i++){
	
	$meanPropNs += $proportionNs[$i];
}
$meanPropNs = $meanPropNs / scalar(@proportionNs) if scalar(@proportionNs) != 0;

# Calculate average SNP support
my $meanSupport = 0;
for(my $i = 0; $i < scalar(@supportForSNPs); $i++){
	$meanSupport += $supportForSNPs[$i] / scalar(@sequences);
}
$meanSupport = $meanSupport / scalar(@supportForSNPs) if scalar(@supportForSNPs) != 0;

print "$seqLength\t$meanPropNs\t$meanSupport\n";
