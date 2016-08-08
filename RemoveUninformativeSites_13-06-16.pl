#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements

# Author: Joseph Crisp
# Remove uninformative sites from a FASTA file

# Command Line Run Structure:
# perl RemoveUninformativeSites.pl verbose sequences.fasta output.fasta

# Fasta File Structure
# 	2 18					noSamples sequenceLength
#	>Sample1ID
#	GCTGATCGTGNGTAGGCC
#	>Sample2ID
#	GCTGATCGTGNGTAGGCT

# Get the verbose option from the command line
my $verbose = shift @ARGV;

##################################################
# Read in the FASTA file and store the sequences #
##################################################

# Open the FASTA file
my $fastaFile = shift @ARGV;
open FASTA, $fastaFile or die "Couldn't open $fastaFile:$!";

# Initialise arrays to store the sequence information
my @isolateIds = ();
my $isolateId = "";
my @sequences = ();
my $sequence = "";
my $index = -1;

# Initialise the necessary variables for parsing the file
my $line;
my @cols;
my $lineNo = 0;

# Begin reading the FASTA file
while(<FASTA>){
	$line = $_;
	chomp($line);
	$lineNo++;
	
	# Skip the header line
	next if $lineNo == 1;
	
	# Have we found a new sequence?
	if($line =~ /^>/){
		
		# Store the previous sequence, if not the first encountered
		if($lineNo != 2){
			$index++;
			@{$sequences[$index]} = split //, $sequence;
			$isolateIds[$index] = $isolateId;
		}
		
		# Wipe the sequence
		$sequence = "";
		
		# Get the isolate ID
		$isolateId = substr($line, 1);
		
	# Still dealing with sequence - allowing sequence to spread across multiple lines
	}else{
		$sequence = $sequence . $line;
	}
}
close(FASTA);

# Store the last sequence
$index++;
@{$sequences[$index]} = split //, $sequence;
$isolateIds[$index] = $isolateId;


######################################
# Note which sites are uninformative #
######################################

# Find the number of sites and isolates
my $nSites = scalar(@{$sequences[0]});
my $nIsolates = scalar(@isolateIds);

# Initialise an array to note the alleles removed
my @removedCounts = (0) x 4; # ACGT

# Initialise an array to record which sites are informative
my @informativeSites = (0) x $nSites;
my $nInformativeSites = 0;

# Examine each site
for(my $siteIndex = 0; $siteIndex < $nSites; $siteIndex++){
	
	# Find the first site that isn't and N and compare to all others
	for(my $isolateI = 0; $isolateI < $nIsolates; $isolateI++){
	
		# Is the current isolate's site an N?
		if($sequences[$isolateI][$siteIndex] ne "N"){
			
			# Compare the current isolate to all the other isolates at the current site, are the same or different?
			for(my $isolateJ = 0; $isolateJ < $nIsolates; $isolateJ++){
				
				# Are the sites different? - INFORMATIVE!
				if($sequences[$isolateJ][$siteIndex] ne "N" && $sequences[$isolateI][$siteIndex] ne $sequences[$isolateJ][$siteIndex]){
					$informativeSites[$siteIndex] = 1;
					$nInformativeSites++;
					
					# Finish comparing
					last;
				}				
			}
			
			# If site is uninformative, record the allele removed - ACGT
			if($informativeSites[$siteIndex] == 0){
				if($sequences[$isolateI][$siteIndex] eq "A"){
					$removedCounts[0]++;
				}elsif($sequences[$isolateI][$siteIndex] eq "C"){
					$removedCounts[1]++;
				}elsif($sequences[$isolateI][$siteIndex] eq "G"){
					$removedCounts[2]++;
				}elsif($sequences[$isolateI][$siteIndex] eq "T"){
					$removedCounts[3]++;
				}else{
					print "ERROR: Site allele note recognised: $sequences[$isolateI][$siteIndex]\n";
				}
			}
			
			# Finish looking at the current site
			last;
		}
	}
}

###########################
# Print out the sequences #
###########################

# Open the output file
my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile:$!";

# Print out a header = NumberIsolates	SequenceLength
print OUTPUT "$nIsolates $nInformativeSites\n";

# Print out the sequences
for(my $isolateIndex = 0; $isolateIndex < $nIsolates; $isolateIndex++){

	print OUTPUT ">$isolateIds[$isolateIndex]\n";
	$sequence = "";

	for(my $siteIndex = 0; $siteIndex < $nSites; $siteIndex++){
	
		# Skip non-informative sites
		next if $informativeSites[$siteIndex] == 0;
		
		# Add the site allele to the current individuals sequence
		$sequence = $sequence . $sequences[$isolateIndex][$siteIndex];
	}
	
	print OUTPUT "$sequence\n";
}
close(OUTPUT);

#################################################
# Print out information about the sites removed #
#################################################

print "$nInformativeSites Informative sites retained of $nSites.\n" if $verbose == 1;
print "Allele Counts of non-informative sites:\n" if $verbose == 1;
print "A\tC\tG\tT\n" if $verbose == 1;
print "$removedCounts[0]\t$removedCounts[1]\t$removedCounts[2]\t$removedCounts[3]\n" if $verbose == 1;