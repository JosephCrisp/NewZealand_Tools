#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Convert the Sequence FASTA File to a NEXUS File format and Create an accompanying TRAITS File

# Command Line Structure
# perl AddSamplingInfoToPhylipTree.pl combinedSamplingInfo.csv phylip_ML.tree output.tree

# Combined Smapling Info file structure:
# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area		REA	Source	Removed
# AgR288	NA		2011	BOVINE	-42.7324	171.15633	HOKITIKA	WESTCOAST	1	Farmed	0
# 0			1		2		3		4			5			6			7			8	9		10

# Phylip tree file structure:
# (AgR126_199:0.00060,(AgR225_199:-0.00014,((AgR222_198:0.00055,
# (AgR111_198:0.00028,(AgR121_198:-0.00028,AgR12...
# 12754_8#78:0.00265):0.00000):0.00000):0.00000):0.00000);

# Adding following info to tree:
# ID-YEAR-HOST-LOCATION-AREA-REA
# 0  2	  3	   6		7	 8

# Open the isolate traits file
my $info = shift @ARGV;
open INFO, $info or die "Couldn't open $info:$!";

# Initialise a hashtable to store the isolate information. key will equal the first 10 chararacters of isolateID_year
my %isolateInfo = ();
my $key;
my $year;
my $id;

# Initialise the necessary variables to parse the file
my $line;
my @cols;
my @parts;

# Begin reading the isolate traits file
while(<INFO>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^FileID/;
	
	# Split the current line into its columns
	@cols = split /\,/, $line;
	
	# Remove spaces from the columns
	for(my $i = 0; $i < scalar(@cols); $i++){
		@parts = split / /, $cols[$i];
		$cols[$i] = $parts[0];
		for(my $x = 1; $x < scalar(@parts); $x++){
			$cols[$i] = $cols[$i] . "" . $parts[$x];
		}
	}
	
	# Store the current isolate's sampling information: ID-YEAR-HOST-LOCATION-AREA-REA
	$isolateInfo{$cols[0]} = $cols[0] . "-" . $cols[2] . "-" . $cols[3] . "-" . $cols[6] . "-" . $cols[7] . "-" . $cols[8];
}
close(INFO);

# Open the phylip tree file (newick tree split across multiple lines)
my $tree = shift @ARGV;
open TREE, $tree or die "Couldn't open $tree:$!";

# Initialise a variable to store the newick tree
my $newickTree = "";

# Begin reading the phylip tree file
while(<TREE>){
	$line = $_;
	chomp($line);
	
	$newickTree = $newickTree . $line;
}
close(TREE);

# Replace the tip labels of newick string with isolateID-year-species-location-area
foreach $key (keys %isolateInfo){
	$newickTree =~ s/$key:/$isolateInfo{$key}:/g;
	
	print "$isolateInfo{$key}\n";
}

# Print the newick tree back out to file
my $output = shift @ARGV;
open OUTPUT, ">$output" or die "Couldn't open $output:$!";
print OUTPUT "$newickTree\n";
close(OUTPUT);