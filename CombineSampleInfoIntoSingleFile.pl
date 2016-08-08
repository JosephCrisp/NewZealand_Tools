#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Combines the sampling information from the two sequencing batches together

# Command Line Structure
# perl CombineSampleInfoIntoSingleFile.pl IsolatesRemoved.csv sampleInfo_WC-TAR.csv idLink_Sanger.csv sampleInfo_Sanger.csv outputSampleInfo.csv

# Isolates to be removed file structure:
# StrainID	SangerID	Reason					Removed
# AgR314				Mismatched with 315		YES
# AgR185	12754_8#77	VNTR and REA mismatch	YES
# 0			1			2						3

# WC and TAR sample info file structure:
# Sample name	year	HOST	Latitude	Longitude	LOCATION	AREA		REA TYPE	LatitudeNew	LongitudeNew	Source
# AgR288		2011	BOVINE	-42.724		170.978		HOKITIKA	WESTCOAST	1			-42.732		171.156			Farmed
# 0				1		2		3			4			5			6			7			8			9				10

# Sanger ID Link file structure:
# Lane		Sample			Supplier Name	Public Name	Strain	ERS			ERR
# 12754_7#1	2982STDY5763550	AgR1			AgR1		NA		ERS421950	ERR564260
# 0			1				2				3			4		5			6

# Sanger sample info file structure:
# AgR  #	[ ] ug/ml	yr isolatd	HOST	Latitude	Longitude	LOCATION	AREA		BST	PVU	BCL	RESTTYPE	Source	Comments
# AgR135	50			1992		BOVINE	-43.1566	172.73048	AMBERLEY	NORTH CANT.	A21	A8	A6	62			Farmed	4 bovine and 2 ferrets from Amberley 
# 0			1			2			3		4			5			6			7			8	9	10	11			12		13

# OUTPUT file structure:
# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area	REA	Source	Removed
# 0			1		2		3		4			5			6			7		8	9		10

#########################################
# Note which isolates are to be removed #
#########################################

# Open the Isolates Removed file
my $removedFile = shift @ARGV;
open REMOVED, $removedFile or die "Couldn't open $removedFile:$!";

# Initialise a hashtable to record the IDs of the isolates removed
my %removed = ();
my $fileID;

# Initialise the variables necessary to parse the file
my $line;
my @cols;

# Begin reading the file
while(<REMOVED>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^StrainID/;
	
	# Split the line into its columns
	@cols = split /,/, $line;
	
	# Get the correct ID for the isolate
	$fileID = $cols[0];
	$fileID = $cols[1] if $cols[1] ne "";
	
	# Store the ID of the isolate that was removed
	$removed{$fileID} = 1;
}
close(REMOVED);

##############################
# Initialise an output table #
##############################

my @outputTable = ();
my $outputPos = -1;

##########################
# WC and TAR Sample Info #
##########################

# Open the sample information file
my $sampleInfo = shift @ARGV;
open WC_TAR_INFO, $sampleInfo or die "Couldn't open $sampleInfo:$!";

# Begin reading the file
while(<WC_TAR_INFO>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^Sample/;
	
	# Split the line into its columns
	@cols = split /,/, $line;
	
	# Build the output line
	$outputPos++;
	$outputTable[$outputPos] = $cols[0] . ",NA," . $cols[1] . "," . $cols[2] . "," . $cols[8] . "," . $cols[9] . "," . $cols[5] . "," . $cols[6] . ",";
	$outputTable[$outputPos] = $outputTable[$outputPos] . $cols[7] . "," . $cols[10];
	
	# Check if this isolate is to be removed
	if(exists($removed{$cols[0]})){
		$outputTable[$outputPos] = $outputTable[$outputPos] . ",1";
	}else{
		$outputTable[$outputPos] = $outputTable[$outputPos] . ",0";
	}
}
close(WC_TAR_INFO);

##################
# Sanger ID Link #
##################

# Open the Sanger ID link file
my $linkFile = shift @ARGV;
open LINK, $linkFile or die "Couldn't open $linkFile:$!";

# Initialise a hashtable to store the ID pairs
my %sangerIDs = ();

# Begin reading the file
while(<LINK>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^Lane/;
	
	# Split the line into its columns
	@cols = split /,/, $line;
	
	# Store the ID pair in the hashtable
	$sangerIDs{$cols[2]} = $cols[0];
}
close(LINK);

######################
# Sanger Sample Info #
######################

# Open the Sanger sample info file
my $sangerInfo = shift @ARGV;
open SANGER_INFO, $sangerInfo or die "Couldn't open $sangerInfo:$!";

# Begin reading the file
while(<SANGER_INFO>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /Supplier/;
	
	# Split the line into its columns
	@cols = split /,/, $line;
	
	# Skip any isolates that aren't in the link hashtable
	next unless exists($sangerIDs{$cols[0]});
	
	# Build the output line
	$outputPos++;
	$outputTable[$outputPos] = $sangerIDs{$cols[0]} . "," . $cols[0] . "," . $cols[2] . "," . $cols[3] . "," . $cols[4] . "," . $cols[5] . ",";
	$outputTable[$outputPos] = $outputTable[$outputPos] . $cols[6] . "," . $cols[7] . "," . $cols[11] . "," . $cols[12];
	
		# Check if this isolate is to be removed
	if(exists($removed{$sangerIDs{$cols[0]}})){
		$outputTable[$outputPos] = $outputTable[$outputPos] . ",1";
	}else{
		$outputTable[$outputPos] = $outputTable[$outputPos] . ",0";
	}
}
close(SANGER_INFO);

##########################
# Print the Output Table #
##########################

# Open the output file
my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile:$!";

# Print a header into the file
print OUTPUT "FileID,AgRID,Year,Host,Latitude,Longitude,Location,Area,REA,Source,Removed\n";

# Print the combined sample information from output table
for(my $row = 0; $row < scalar(@outputTable); $row++){
	print OUTPUT "$outputTable[$row]\n";
}
close(OUTPUT);
