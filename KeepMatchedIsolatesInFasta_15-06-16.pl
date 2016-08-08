#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Keep only the matched cattle and wildlife in a FASTA file

# Command Line Structure
# perl KeepMatchedIsolatesInFasta.pl refPresent matchedIsolates.csv sequences.fasta output.fasta 

# Matched Isolates file format:
# ID		Year	Species	Latitude	Longitude
# 12755_8#6	2006	FERRET	-43.156645	172.730484
# 0			1		2		3			4

# FASTA File Format:
#	4 20				noSamples	noSites
#	>AgR111_S8_1.vcf
#	GGTCGCGCTCCGACACGCCC
#	>AgR121_S1_2.vcf
#	GGTCGCGCTCCGNCANGCCC
#	>12755_8#21_202.vcf
#	GGTCGCGCTCCGACANGCCC
#	>12754_7#93_92.vcf
#	GGTCGCGCTCCGACGNGCCC

# Are the Reference sites present in the fasta?
my $refPresent = shift @ARGV;

###############################################
# Get the Isolate IDs of the matched isolates #
###############################################

# Open the matched isolates file
my $matchedFile = shift @ARGV;
open MATCHED, $matchedFile or die "Couldn't open $matchedFile:$!";

# Initialise a hashtable to store the matched isolate IDs
my %matchedIsolates = ();

# Initialise the necessary variables for parsing the file
my $line;
my @cols;

# Begin reading the file
while(<MATCHED>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^ID/;
	
	# Split the line into its columns
	@cols = split /\,/, $line;
	
	# Store the IDs of the matched isolates
	$matchedIsolates{$cols[0]} = 1;
}
close(MATCHED);

###########################################################
# Read FASTA File and Print Sequences of Matched Isolates #
###########################################################

# Open in the Sample FASTA File
my $fastaFile = shift @ARGV; 
open FASTA, $fastaFile or die "Couldn't open $fastaFile:$!";

# Open an output FASTA file
my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile:$!";

# Initialise the necessary variables to parse the FASTA file
my $lineNo = 0;

# Initialise variables to streo sequence and isolateID
my $sequence = "";
my $isolateId;
my $pos;

# Initialise a variable to record the sequence length
my $nIsolates = keys %matchedIsolates;
my $seqLength;

# Add 1 to number of isolates if reference sites are present
$nIsolates++ if $refPresent == 1;

# Read the FASTA file
while(<FASTA>){
	$lineNo++;
	$line = $_;
	chomp($line);
	
	# Get the number of isolates and sequence length from the first line
	if($lineNo == 1){
		@cols = split /\ /, $line;
		$seqLength = $cols[1];
		
		# Print out a new header into the output FASTA file
		print OUTPUT "$nIsolates $seqLength\n";
	}
	
	# Are we looking at a new isolate?
	if($line =~ /^>/){
		@cols = split /\_/, substr($line, 1);
		
		# Store the previous isolate's sequence
		if($lineNo > 2){
			$pos++;
			
			# Print the isolate sequence out to file if it is one of the matched isolates
			if(exists($matchedIsolates{$isolateId}) || $isolateId =~ /^Ref/){
				print OUTPUT ">$isolateId\n$sequence\n";
			}
		}
		
		# Reset the sequence
		$sequence = "";
		
		# Get the isolate ID
		$isolateId = $cols[0]; # AgR145_S24_9.vcf or N11_S8_1.vcf
		if($line =~ /^>12754/ || $line =~ /^>12755/){ # >12754_8#67_159.vcf
			$isolateId = $cols[0] . "_" . $cols[1];
		}
		
	}else{
	
		$sequence = $sequence . "" . $line;
	}
}
close(FASTA);

# Print the last isolate's sequence out to file if it is one of the matched isolates
if(exists($matchedIsolates{$isolateId}) || $isolateId =~ /^Ref/){
	print OUTPUT ">$isolateId\n$sequence\n";
}

# Close the output file
close(OUTPUT);

