#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements
use List::Util qw(shuffle); # For shuffle command

# Author: Joseph Crisp
# Finding Spatially and temporally matched possum and cattle isolates

# Command Line Run Structure: Should be ran in Directory with VCF Files
# perl FindSpatiallyAndTemporallyMatchedPairs.pl clade isolateClades.txt combinedSampleInfo.csv matchedIsolates.csv

# IsolateClades.txt file structure:
# IsolateId		CladeIndex
# 12754_7#10	0
# 0				1

# Sample information file structure:
# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area	REA	Source	Removed
# 0			1		2		3		4			5			6			7		8	9		10

###############################################
# Note the isolates within the selected clade #
###############################################

# Get the clade number from the command line
my $clade = shift @ARGV;

# Open the isolate clades file
my $isolateClades = shift @ARGV;
open CLADES, $isolateClades or die "Couldn't open $isolateClades:$!";

# Initialise the ncessary variables to parse the file
my $line;
my @cols;

# Initialise a hashtable to record the isolates in the clade
my %isolatesInClade = ();

# Begin reading the isolate clades file
while(<CLADES>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^IsolateId/;
	
	# Split the line into its columns
	@cols = split /\t/, $line;
	
	# Skip isolates that aren't in selected clade
	next if $cols[1] != $clade;
	
	# Store of the IDs of the isolates in the selected clade
	$isolatesInClade{$cols[0]} = 1;
}
close(CLADES);


#####################################################################
# Define thresholds for defining a spatial and temporal association	#
my $spatialThreshold = 40;	#40km								#
my $temporalThreshold = 3;	#3yrs								#
#####################################################################

# Open the sample info file
my $sampleInfo = shift @ARGV;
open INFO, $sampleInfo or die "Couldn't open $sampleInfo:$!";

# Initialise a matrix to store the isolate information
my @isolateInfo = ();
my $index = -1;

# Initialise the necessary variables to parse the file
my @parts;

# Begin reading the sample info file
while(<INFO>){
	$line = $_;
	chomp($line);
	
	# Skip the header line
	next if $line =~ /^FileID/;
	
	# Split the isolates's information into an array
	@cols = split /,/, $line;
	
	# Store the current isolates information
	$index++;
	@{$isolateInfo[$index]} = @cols;
}
close(INFO);

# Shuffle the order of the isolate information - to ensure this has no weight in the selection process
@isolateInfo = shuffle @isolateInfo;

##### Find a spatially and temporally matched cattle isolate for every wildlife isolate

# Open an output file
my $output = shift @ARGV;
open OUTPUT, ">$output" or die "Couldn't open $output:$!";
print OUTPUT "ID,Year,Species,Latitude,Longitude\n";

# Initialise Pi - for use in calculating spatial distances
my $pi = atan2(1,1) * 4;

# Initialise a hashtable to record which cattle isolates have already been paired up
my %pairedCattle = ();

# Initialise variables to store the calculated spatial and temporal distances
my $spatialDistance = 0;
my $temporalDistance = 0;

# Initialise an array to store the information of the matched isolates
my @matched = ();
my $pos = -1;
my $min;

# Initialise variables to get the sample ID and year
my $name;

# Initialise a variable to keep count of the number of pairs we find
my $nPairs = 0;

# Initialise arrays to store the sorted matched isolate IDs
my @srtedBySpatial = ();
my @srtedByTemporal = ();

# FileID	AgRID	Year	Host	Latitude	Longitude	Location	Area	REA	Source	Removed
# 0			1		2		3		4			5			6			7		8	9		10

# Compare the isolates to one another
for(my $i = 0; $i < scalar(@isolateInfo); $i++){
	
	# Skip isolates that aren't in the selected clade
	next unless exists($isolatesInClade{$isolateInfo[$i][0]});
	
	# Skip the isolate if it is to be removed
	next if $isolateInfo[$i][10] == 1;
	
	# Select wildlife
	next if $isolateInfo[$i][3] eq "BOVINE";
	
	# Reset the matched isolate information
	@matched = ();
	$pos = -1;
	
	for(my $j = 0; $j < scalar(@isolateInfo); $j++){
	
		# Skip isolates that aren't in the selected clade
		next unless exists($isolatesInClade{$isolateInfo[$j][0]});
	
		# Skip the isolate if it is to be removed
		next if $isolateInfo[$j][10] == 1;
	
		# Select cattle
		next if $isolateInfo[$j][3] ne "BOVINE";
		
		# Skip any cattle that have already been matched
		next if exists($pairedCattle{$isolateInfo[$j][0]});
		
		# Calculate the spatial distance
		$spatialDistance = 0;
		if($isolateInfo[$i][4] != $isolateInfo[$j][4] || $isolateInfo[$i][5] != $isolateInfo[$j][5]){
			$spatialDistance = distance($isolateInfo[$i][4], $isolateInfo[$i][5], $isolateInfo[$j][4], $isolateInfo[$j][5]);
		}
		
		# Calculate the temporal distance
		$temporalDistance = $isolateInfo[$i][2] - $isolateInfo[$j][2];
		if($temporalDistance < 0){
			$temporalDistance = $isolateInfo[$j][2] - $isolateInfo[$i][2];
		}
		
		# Only interested in cattle that are within the spatial and temporal thresholds for association
		next unless $spatialDistance <= $spatialThreshold && $temporalDistance <= $temporalThreshold;
		
		# Store the information for the current cattle isolate
		$pos++;
		@{$matched[$pos]} = ($isolateInfo[$j][0], $temporalDistance, $spatialDistance, $j);
	}
	
	# Skip isolate that we weren't able to find any matched cattle
	next if scalar(@matched) == 0;
	
	# If only one matched cattle isolate was found - pair these isolates
	if(scalar(@matched) == 1){

		# Print out the information for the wildlife isolate
		print OUTPUT "$isolateInfo[$i][0],$isolateInfo[$i][2],$isolateInfo[$i][3],$isolateInfo[$i][4],$isolateInfo[$i][5]\n";
		
		# Print out the information for the cattle isolate
		print OUTPUT "$isolateInfo[$matched[0][3]][0],$isolateInfo[$matched[0][3]][2],$isolateInfo[$matched[0][3]][3],$isolateInfo[$matched[0][3]][4],$isolateInfo[$matched[0][3]][5]\n";
		
		# Record that a pair was found
		@{$pairedCattle{$matched[0][0]}} = 1;
		$nPairs++;
		
		next;
	}
	
	# Sort the matched cattle isolates by temporal distance
	@srtedByTemporal = sort { $matched[$a][1] <=> $matched[$b][1] } 0 .. $#matched;
	
	# Sort the matched cattle isolates by spatial distance
	@srtedBySpatial = sort { $matched[$a][2] <=> $matched[$b][2] } 0 .. $#matched;
	
	## Note the total index of each matched individual according to their temporal and spatial distance whilst
	## accounting for the fact that individuals in the srted temporal and spatial arrays may have the same temporal or spatial distances
	
	# Note the index based upon sorted temporal distances
	$index = 0;
	$matched[$srtedByTemporal[0]][4] = $index;
	for(my $x = 1; $x < scalar(@srtedByTemporal); $x++){
		
		if($matched[$srtedByTemporal[$x]][1] > $matched[$srtedByTemporal[$x - 1]][1]){
			$index++;
		}
		$matched[$srtedByTemporal[$x]][4] = $index;
	}
	
	# Add the index based upon sorted spatial distances
	$index = 0;
	$matched[$srtedBySpatial[0]][4] += $index;
	for(my $x = 1; $x < scalar(@srtedBySpatial); $x++){
		
		if($matched[$srtedBySpatial[$x]][2] > $matched[$srtedBySpatial[$x - 1]][2]){
			$index++;
		}
		$matched[$srtedBySpatial[$x]][4] += $index;		
	}
	
	## Pick the paired cattle isolate for the current wildlife isolate
	$min = 9999999;
	$index = 0;
	for(my $x = 0; $x < scalar(@matched); $x++){
		if($matched[$x][3] < $min){
			$min = $matched[$x][4];
			$index = $x;
		}
	}
	
	# Record which cattle isolate was selected
	@{$pairedCattle{$matched[$index][0]}} = 1;
	$nPairs++;

	# Print out the information for the wildlife isolate
	print OUTPUT "$isolateInfo[$i][0],$isolateInfo[$i][2],$isolateInfo[$i][3],$isolateInfo[$i][4],$isolateInfo[$i][5]\n";
	
	# Print out the information for the cattle isolate
	print OUTPUT "$isolateInfo[$matched[$index][3]][0],$isolateInfo[$matched[$index][3]][2],$isolateInfo[$matched[$index][3]][3],$isolateInfo[$matched[$index][3]][4],$isolateInfo[$matched[$index][3]][5]\n";
}
close(OUTPUT);

print "Number of pairs found = $nPairs\n";

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