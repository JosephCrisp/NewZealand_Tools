#!/usr/bin/perl
use warnings;
use strict;

my $proximityFilt = 10;
my $sequencePos = 10;
my @positions = (1, 20, 35, 45, 46, 47, 69, 78, 135, 137, 145);


my @remove = (0) x ($sequencePos + 1);

for(my $i = 0; $i < ($sequencePos + 1); $i++){

	# Apply the proximity filtered
	if(($i != 0 && $positions[$i] - $positions[$i - 1] <= $proximityFilt) ||
	($i != $sequencePos && $positions[$i + 1] - $positions[$i] <= $proximityFilt)){
		
		$remove[$i] = 1;
	}
}


print "$output1\n$output2\n";