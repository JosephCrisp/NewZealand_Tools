#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements

##########################################
# Inter-Sample Epidemiological Distances #
##########################################

# Command Line Structure:
# perl GenerateEpiVariables.pl combinedisolateInfo.csv merged.txt epiVariables.txt

# Variables used to Describe the Genetic Distance
#	Spatial Distance
#	Temporal Distance
#	Same Species?
#	Same Location?
#	Same Area?
#	Same REA type?

# combinedisolateInfo.csv file structure:
# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area		REA	Source	Removed
# AgR288	NA		2011	BOVINE	-42.7324	171.15633	HOKITIKA	WESTCOAST	1	Farmed	0
# 0			1		2		3		4			5			6			7			8	9		10

# Output Structure (Note very important that ORDER matches)
# Will Print the Information for each Sample to Sample Comparison
# Spatial	Temporal	Species	Location	Area	REA
#	-		-			-		-			-		-		
# 	-		-			-		-			-		-


####### Retrieve the Sample Information #######

# Here Only interested in the Header Line: 
#	#CHROM	POS	AgR111_S8_1.vcf:AgR121_S1_2.vcf:AgR122_S41_3.vcf:...
# 	0		1	2 

# Note also that the Order of the Sample Names will define the order of the output distance matrices and the Variable Information

# Read in the sample information file
my $infoFile = shift @ARGV;
open INFO, $infoFile or die "Couldn't open $infoFile:$!";

# Read the sample information file
my $line;
my @cols;
my %isolateInfo = ();

while(<INFO>){
	$line = $_;
	next if $line =~ /^Sample/;
	chomp($line);
	@cols = split /\,/, $line;
	
	@{$isolateInfo{$cols[0]}} = @cols; 
	
}
close(INFO);

####### Read the Merged VCFs file #######

my $mergedFile = shift @ARGV;
open MERGED, $mergedFile or die "Couldn't open $mergedFile:$!";

# Initialise an array to store the sample IDs
my @isolateIDs = ();
my $isolateID;
my @parts;

# Get the Sample Names From the VCF File
while(<MERGED>){
	if($_ =~ /^#CHROM/){
	
		$line = $_;
		chomp($line);
		@cols = split /\:/, (split /\t/, $line)[2]; # Select the VCF file names
		
		# Get the sample ID from each VCF file 
		for(my $i = 0; $i < scalar(@cols); $i++){
			
			@parts = split /\_/, $cols[$i];
			$isolateID = $parts[0];
			$isolateID = $parts[0] . "_" . $parts[1] if $parts[0] !~ /^AgR/ && $parts[0] !~ /^Ref/ && $parts[0] !~ /^N/;
			
			$isolateIDs[$i] = $isolateID;
		}
		
		last; # Finish Reading File
	}
}
close(MERGED);

####### Compare each of the isolates to one another #######

# Print out a Header into the EpiVariables.txt file
my $outputFile = shift @ARGV;
open OUTPUT, ">$outputFile" or die "Couldn't open $outputFile:$!";

print OUTPUT "Spatial\tTemporal\tSpecies\tLocation\tArea\tREA\n";

# Initialise the necessary variables
my @infoI = ();
my @infoJ = ();
my $spatialDist;
my $tempDist;
my $species;
my $location;
my $area;
my $rea;
my $pi = atan2(1,1) * 4;

# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area		REA	Source	Removed
# 0			1		2		3		4			5			6			7			8	9		10
for(my $i = 0; $i < scalar(@isolateIDs); $i++){

	# Get sample Info for I
	@infoI = @{$isolateInfo{$isolateIDs[$i]}};
	
	for(my $j = 0; $j < scalar(@isolateIDs); $j++){
	
		# Make the comparison once and avoid self comparisons
		next if $i >= $j;
		
		# Get sample info for J
		@infoJ = @{$isolateInfo{$isolateIDs[$j]}};
		
		# Calculate the Spatial Distance
		$spatialDist = 0;
		$spatialDist = distance($infoI[4], $infoI[5], $infoJ[4], $infoJ[5]) unless $infoI[4] == $infoJ[4] && $infoI[5] == $infoJ[5];
		
		# Calculate the Temporal Distance
		$tempDist = 0;
		if($infoI[2] > $infoJ[2]){
			$tempDist = $infoI[2] - $infoJ[2];
		}else{
			$tempDist = $infoJ[2] - $infoI[2];
		}
		
		# Are the sampled species the same?
		$species = 0;
		if($infoI[3] eq $infoJ[3]){
			$species = 1;
		}
		
		# Are the sampling locations the same?
		$location = 0;
		if($infoI[6] eq $infoJ[6]){
			$location = 1;
		}
		
		# Are the sampling areas the same?
		$area = 0;
		if($infoI[7] eq $infoJ[7]){
			$area = 1;
		}
		
		# Are the REA types the same?
		$rea = 0;
		if($infoI[8] eq $infoJ[8]){
			$rea = 1;
		}
		
		# Print out the results from the comparison
		print OUTPUT "$spatialDist\t$tempDist\t$species\t$location\t$area\t$rea\n";	
	}
}
close(OUTPUT);


####### Methods for calculating the distance between latitude and longitude points #######
# Taken Directly from: http://www.geodatasource.com/developers/perl
sub distance {

	my ($lat1, $lon1, $lat2, $lon2) = @_;
    my $theta = $lon1 - $lon2;
    my $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
	$dist  = acos($dist);
	$dist = rad2deg($dist);
	$dist = $dist * 60 * 1.1515; # Miles
	$dist = $dist * 1.609344; # Kilometres
	
    return ($dist);

}

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#:::  This function get the arccos function using arctan function   :::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub acos {
    my ($rad) = @_;
    my $ret = atan2(sqrt(1 - $rad**2), $rad);
    return $ret;
}

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#:::  This function converts decimal degrees to radians             :::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub deg2rad {
	my ($deg) = @_;
    return ($deg * $pi / 180);
}

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#:::  This function converts radians to decimal degrees             :::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub rad2deg {
	my ($rad) = @_;
    return ($rad * 180 / $pi);
}
