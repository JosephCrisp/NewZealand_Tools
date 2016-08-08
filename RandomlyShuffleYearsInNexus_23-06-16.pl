#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use List::Util qw(shuffle); # Shuffle function

# Author: Joseph Crisp
# Randomly shuffle the years associated with each isolate - in nexus and traits file

# Command Line Structure
# perl RandomlyShuffleYearsInNexus.pl input.nexus output.nexus inputTraits.txt outputTraits.txt

# Nexus File Structure:
#	#NEXUS
#
#
#	BEGIN DATA;
#	DIMENSIONS NTAX=3 NCHAR=10;
#	FORMAT MISSING=N GAP=- DATATYPE=DNA;
#	MATRIX
#	AgR111_1987	GGTCGCGTCG
#	AgR121_1988	GGTCGCGTCG
#	AgR122_1992	GGTCGCGTCG
#	;
#	END;

## Open Nexus File
my $nexusFile = shift @ARGV;
open NEXUS, $nexusFile or die "Couldn't open $nexusFile:$!";

# Create a hashtable to store the isolate sequences
my %isolateData = (); # key = ID_year
my @info = (); # ID, year, sequence

# Create an array to store the isolate sampling years
my $index = -1;
my @years = ();

# Create variables to store the data information
my $nTaxa;
my $seqLength;

# Create a variable to note whether we have found the sequence block yet
my $foundSeq = 0;

# Create necessary variables for parsing the file
my $line;
my @cols;
my @parts;

# Begin reading the Nexus File
while(<NEXUS>){
	$line = $_;
	chomp($line);
	
	# Get the nexus dimension information
	if($line =~ /^DIMENSIONS/){
		$nTaxa = (split /\=/,(split /\ /, $line)[1])[1];
		$seqLength = substr((split /\=/, $line)[-1], 0, -1);
		
	# Have we found the sequence block?
	}elsif($line =~ /^MATRIX/){
		$foundSeq = 1;
	
	# Are we currently in the sequence block?
	}elsif($foundSeq == 1 && $line !~ /^;/){
		
		# Get the isolate's ID
		@cols = split /\t/, $line;
		@parts = split /\_/, $cols[0];
		
		@info = ();
		$info[0] = $parts[0];
		$info[0] = $parts[0] . "_" . $parts[1] if scalar(@parts) > 2;
		
		# Store the isolate's sampling year and sequence
		$info[1] = $parts[-1];
		$info[2] = $cols[1];
		
		@{$isolateData{$cols[0]}} = @info;
		
		# Store the isolate's sampling year
		$index++;
		$years[$index] = $parts[-1];
	
	# Have we reached the end of the sequence block?
	}elsif($foundSeq == 1 && $line =~ /^;/){
		$foundSeq = 0;
	}
}
close(NEXUS);

## Shuffle the Years and re-assign to the isolates
my @shuffled = shuffle @years;
$index = -1;

foreach my $key (keys %isolateData){
	$index++;
	@info = @{$isolateData{$key}};
	$info[1] = $shuffled[$index];
	@{$isolateData{$key}} = @info;
}

## Print out to the New Nexus File
my $newNexus = shift @ARGV; # Open Output File to Print out to
open NEXUSOUT, ">$newNexus" or die "Couldn't open $newNexus:$!";

# Print Header information
print NEXUSOUT "#NEXUS\n\n\nBEGIN DATA;\nDIMENSIONS NTAX=$nTaxa NCHAR=$seqLength;\nFORMAT MISSING=N GAP=- DATATYPE=DNA;\nMATRIX\n";

# Print out the isolate information with the shuffled years
foreach my $key (keys %isolateData){

	@info = @{$isolateData{$key}};
	print NEXUSOUT "$info[0]_$info[1]\t$info[2]\n";
}
print NEXUSOUT ";\nEND;\n";
close(NEXUSOUT);

## Read in the Trait information and print it out with the different year information

# Read the isolate traits file
my $traitsFile = shift @ARGV;
open TRAITS, $traitsFile or die "Couldn't open $traitsFile:$!";

# Open the output traits file
my $newTraitsFile = shift @ARGV;
open TRAITSOUT, ">$newTraitsFile" or die "Couldn't open $newTraitsFile:$!";

# Traits File Structure:
#	traits		Species	Location	Area				REA	Latitude	Longitude	Cattle		WestCoast
#	AgR111_1987	POSSUM	STATIONBF	MACKENZIECOUNTRY	11	-44.419		170.256		WILDLIFE	OUTSIDE
#	0			1		2			3					4	5			6			7			8

my $id;

while(<TRAITS>){
	$line = $_;
	chomp($line);
		
	if($line =~ /^traits/){
		print TRAITSOUT "$line\n";
		next;
	}
	
	# Get the information for the current isolate
	@cols = split /\t/, $line;
	@info = @{$isolateData{$cols[0]}};
	
	# Create the ID_year with the new randomly selected year
	$cols[0] = $info[0] . "_" . $info[1];
	
	$line = join("\t", @cols);
	
	print TRAITSOUT "$line\n";
}
close(TRAITS);
close(TRAITSOUT);
