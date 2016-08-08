#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Add Clade labels into an isolate traits file

# Command Line Structure
# perl AddCladeToIsolateTraitsFile.pl isolateInClades.txt isolateTraits.txt

# Isolate in clades file structure:
# 	IsolateId	CladeIndex
#	AgR227	0
#	AgR11	0
#	AgR19	0

# Isolate Traits file structure:
#	traits		Species	Latitude	Longitude	Location	Area				CATTLE
#	AgR136_1991	BOVINE	-44.266		170.09		TWIZEL		MACKENZIECOUNTRY	BOVINE
#	0			1		2			3			4			5					6


# Open the isolate in clades file
my $clades = shift @ARGV;
open CLADES, $clades or die "Couldn't open $clades:$!";

# Initialise a hashtable to store the isolate ID and associated clade index
my %isolateClade = ();

# Initialise the ncessary variables for parsing the file
my $line;
my @parts;

# Initialise a variable to store the isolate ID
my $isolateId;

# Begin reading the isolates in clades file
while(<CLADES>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^IsolateId/;
	
	# Store the isolate ID and clade index
	@parts = split /\t/, $line;
	$isolateClade{$parts[0]} = $parts[1];
}
close(CLADES);


# Open the isolate traits file
my $traits = shift @ARGV;
open TRAITS, $traits or die "Couldn't open $traits:$!";

# Begin reading the isolate traits file
while(<TRAITS>){
	$line = $_;
	chomp($line);
	
	# Skip but print the header line
	if($line =~ /^traits/){
		print "$line\tClade\n";
		next;
	}
	
	# Get the isolate ID
	@parts = split /\_/, (split /\t/, $line)[0];
	$isolateId = $parts[0];
	$isolateId = $parts[0] . "_" . $parts[1] if scalar(@parts) > 2;
	
	# Print out the isolate information plus the clade it was assigned
	print "$line\t$isolateClade{$isolateId}\n";	
}
close(TRAITS);