#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Note the 60 isolates selected for further analyses

# Command Line Structure
# perl NoteSelectedIsolatesFromAllIsolates.pl isolateTraits_selected.txt isolateTraits_All.txt > output.txt

# Isolate Traits file structure:
#	traits		Species	Latitude	Longitude	Location	Area				CATTLE
#	AgR136_1991	BOVINE	-44.266		170.09		TWIZEL		MACKENZIECOUNTRY	BOVINE
#	0			1		2			3			4			5					6

# Open the isolate traits file containing only the selected isolates
my $traits = shift @ARGV;
open TRAITS, $traits or die "Couldn't open $traits:$!";

# Initialise a hashtable to store the IDs of the selected individuals
my %selected = ();

# Initialise the ncessary variables for parsing the file
my $line;
my @cols;

# Begin reading the isolates traits file
while(<TRAITS>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^IsolateId/;
	
	# Split the line into its columns
	@cols = split /\t/, $line;
	
	# Store the isolate ID and clade index
	$selected{$cols[0]} = 1;
}
close(TRAITS);

# Open the isolate traits file containing all the isolates
$traits = shift @ARGV;
open TRAITS, $traits or die "Couldn't open $traits:$!";

# Begin reading the isolate traits file
while(<TRAITS>){
	$line = $_;
	chomp($line);
	
	# Skip but print the header line
	if($line =~ /^traits/){
		print "$line\tSelected\n";
		next;
	}
	
	# Split the line into its columns
	@cols = split /\t/, $line;
	
	# Print out the isolate information plus whether it was a selected isolate
	if(exists($selected{$cols[0]})){
		print "$line\t1\n";	
	}else{
		print "$line\t0\n";
	}	
}
close(TRAITS);