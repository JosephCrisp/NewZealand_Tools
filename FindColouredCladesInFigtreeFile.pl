#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Note the coloured clades in a FIGTREE NEXUS file

# Command Line Structure
# perl FindColouredCladesInFigtreeFile figtree.tree

# Figtree NEXUS file structure:
#	#NEXUS
#	begin taxa;
#		dimensions ntax=322;
#		taxlabels
#		AgR227-2001-CERVINE-KARAMEA-WESTCOAST[&!color=#-16776961]
#		AgR11-2009-BOVINE-OPUNAKE-TARANAKI[&!color=#-16776961]
#		AgR19-2009-BOVINE-OPUNAKE-TARANAKI[&!color=#-16776961]
#		'12755_8#8-2005-BOVINE-CHEVIOT-NORTHCANT.'[&!color=#-16776961]
#		'12754_8#55-2005-BOVINE-KAIKOURA-KAIKOURA'[&!color=#-16776961]
#		...
#		Ref-1997
#	;
#	end;
#	
#	begin trees;
#		tree TREE1 = [&R] (((((((AgR227-2001-CERVINE-KARAMEA-WESTCOAST:0.00234,...
#	end;
#
#	begin figtree;
#		set appearance.backgroundColorAttribute="Default";
#		set appearance.backgroundColour=#-1;
#		...
#	end;


# Open the figtree NEXUS tree file
my $nexus = shift @ARGV;
open NEXUS, $nexus or die "Couldn't open $nexus:$!";

# Initialise a hashtable to index the clades encountered
my %cladeIndices = (); # Key = colour assigned to clade
my $colour = "";
my $index = -1;
my $isolateId;

# Print a header into the output file
print "IsolateId\tCladeIndex\n";

# Initialise the necessary variables to parse the file
my $line;
my @parts;

# Initialise a variable to note whether we have found the taxa labels section
my $foundTaxaLabels = 0;

# Begin reading the NEXUS file
while(<NEXUS>){
	$line = $_;
	chomp($line);
	
	# Have we found the taxa labels section
	if($line =~ /taxlabels/){
		$foundTaxaLabels = 1;
	
	# Are we currently within the taxa labels block?
	}elsif($foundTaxaLabels == 1 && $line !~ /^;/){
		
		# If the line has "'" surround the isolate information, remove them
		$line =~ s/'//g;
		
		# Split the line to get at the colour		
		@parts = split /\[/, $line;
		
		# Skip isolates that weren't coloured
		next if scalar(@parts) == 1;
		
		# Extract the colour
		$colour = (split /#/, $parts[1])[1];
		$colour = substr($colour, 0, -2);
		
		# Check if colour has already been encountered and indexed
		unless(exists($cladeIndices{$colour})){
			$index++;
			$cladeIndices{$colour} = $index;
		}
		
		# Get the Isolate Information
		$isolateId = (split /-/, $parts[0])[0];
		$isolateId = (split /\t/, $isolateId)[1];
		
		
		# Print the Isolate's details and the index of the clade it was assigned to
		print "$isolateId\t$cladeIndices{$colour}\n";
		
	# Have we reached the end of the taxa labels block?
	}elsif($foundTaxaLabels == 1 && $line =~ /^;/){
		$foundTaxaLabels = 0;
	}
}
close(NEXUS);