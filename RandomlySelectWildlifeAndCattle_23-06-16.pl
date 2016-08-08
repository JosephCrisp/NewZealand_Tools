#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements
use List::Util qw(shuffle); # For shuffle command

# Author: Joseph Crisp
# Randomly select X wildlife and X Cattle

# Command Line Run Structure: 
# perl RandomlySelectWildlifeAndCattle.pl nToSelect isolateTraits.txt traitsOut.txt sequences.nexus out.nexus

# Isolate Traits file structure:
# traits		Species	Latitude	Longitude	Location	Area				Source	CATTLE
# AgR136_1991	BOVINE	-44.266		170.09		TWIZEL		MACKENZIECOUNTRY	Farmed	BOVINE
# 0				1		2			3			4			5					6		7

# NEXUS File Structure: (Note the Year is tacked onto the end of the Sequence Name)
#	#NEXUS
#
#
#	BEGIN DATA;
#	DIMENSIONS NTAX=3 NCHAR=20;
#	FORMAT MISSING=N GAP=- DATATYPE=DNA;
#	MATRIX
#	AgR111_1987       ATGCGATGCGTAGGAGTAGG
#	AgR121_1988       ATGCGATGCGTAGGNGTAGG
#	AgR122_1992       ATGCGATGCGNAGGAGTAGG
#	;
#	END;

## Get the number of random pairs to create
my $nToSelect = shift @ARGV;

## Use the isolate trait information to select isolates to keep

# Open the isolate traits file
my $traitsFile = shift @ARGV;
open TRAITS, $traitsFile or die "Couldn't open $traitsFile:$!";

# Open the output isolate traits file
my $outputTraitsFile = shift @ARGV;
open TRAITSOUT, ">$outputTraitsFile" or die "Couldn't open $outputTraitsFile:$!";

# Create two arrays to store wildlife and cattle isolate information separately
my @wildlife = ();
my $wildlifeIndex = -1;
my @cattle = ();
my $cattleIndex = -1;

# Initialise the necessary variables to parse the file
my $line;
my @cols;

# Begin reading the isolate traits file
while(<TRAITS>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	if($line =~ /^traits/){
		print TRAITSOUT "$line\n";
		next;
	}
	
	# Split the isolates's information into an array
	@cols = split /\t/, $line;

	# Skip non-cattle farmed animals
	next if $cols[1] ne "BOVINE" && $cols[6] eq "Farmed";
	
	# Skip feline isolates
	next if $cols[1] eq "FELINE";
	
	# Is the isolate from wildlife or cattle?
	if($cols[1] eq "BOVINE"){
		$cattleIndex++;
		@{$cattle[$cattleIndex]} = @cols;
	}else{
		$wildlifeIndex++;
		@{$wildlife[$wildlifeIndex]} = @cols;
	}
}
close(TRAITS);


## Randomly select X wildlife and X cattle

# Create an array of indices for the wildlife and cattle arrays
my @wildlifeIndices = 0 .. (scalar(@wildlife) - 1);
my @cattleIndices = 0 .. (scalar(@wildlife) - 1);

# Shuffle the arrays of indices
my @shuffledWildlifeIndices = shuffle(@wildlifeIndices);
my @shuffledCattleIndices = shuffle(@cattleIndices);

# Pick the first X elements from the shuffled arrays
my @pickedWildlifeIndices = @shuffledWildlifeIndices[0 .. ($nToSelect-1)];
my @pickedCattleIndices = @shuffledCattleIndices[0 .. ($nToSelect-1)];

# Select the picked isolates
my @pickedWildlife = @wildlife[@pickedWildlifeIndices];
my @pickedCattle = @cattle[@pickedCattleIndices];

# Initialise a hashtable to store the IDs of the selected isolates
my %keep = ();

# Note the IDs of the selected wildlife and cattle
for(my $i = 0; $i < $nToSelect; $i++){
	
	# Print out the isolate's information
	@cols = @{$pickedWildlife[$i]};
	$line = join("\t", @cols);
	
	print TRAITSOUT "$line\n";

	# Store the ID of the isolate to be kept
	$keep{$cols[0]} = 1;	
}
for(my $i = 0; $i < $nToSelect; $i++){
	
	# Print out the isolate's information
	@cols = @{$pickedCattle[$i]};
	$line = join("\t", @cols);	
	print TRAITSOUT "$line\n";

	# Store the ID of the isolate to be kept
	$keep{$cols[0]} = 1;	
}
close(TRAITSOUT);


## Keep the selected isolates in the NEXUS file

# Open the NEXUS file
my $nexusFile = shift @ARGV;
open NEXUS, $nexusFile or die "Couldn't open $nexusFile:$!";

# Open the output NEXUS file
my $outputNexusFile = shift @ARGV;
open NEXUSOUT, ">$outputNexusFile" or die "Couldn't open $outputNexusFile:$!";

# Create a variable to note whether we have found the sequence block
my $found = 0;

# Create variables to record the dimensions
my $nTaxa = keys %keep;
my $length;

# Begin reading the NEXUS file
while(<NEXUS>){
	$line = $_;
	chomp($line);
	
	if($line =~ /^DIMENSIONS/){
		
		# Get the sequence length: DIMENSIONS NTAX=186 NCHAR=4176;
		$length = substr((split /\=/, $line)[-1], 0, -1);
		
		# Print out the new dimensions information
		print NEXUSOUT "DIMENSIONS NTAX=$nTaxa NCHAR=$length;\n";
	
	# Have we found the sequence block?
	}elsif($line =~ /^MATRIX/){
		$found = 1;
		print NEXUSOUT "$line\n";
		
	# Are we in the sequence block?
	}elsif($found == 1 && $line !~ /^;/){
		
		# Is this an isolate we want to keep?
		@cols = split /\t/, $line;
		print NEXUSOUT "$line\n" if exists($keep{$cols[0]});
	
	# Have we reached the end of the sequence block?
	}elsif($found == 1 && $line =~ /^;/){
		$found = 0;
		print NEXUSOUT "$line\n";
	}else{
		print NEXUSOUT "$line\n";
	}
}
close(NEXUS);
close(NEXUSOUT);
