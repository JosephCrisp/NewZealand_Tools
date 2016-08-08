#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;

# Author: Joseph Crisp
# Generates the Filter Combinations to be used in the Sensitivity Analysis

# Command Line Structure:
# perl GenerateFilters.pl > filterSettings.txt


####### Set the Range for the SNP Filter Thresholds #######

my $depthMin = 10;
my $depthMax = 50;
my $depthBy = 5;

my $hqMin = 0;
my $hqMax = 10;
my $hqBy = 2;

my $mqMin = 30;
my $mqMax = 30;
my $mqBy = 30;

my $supMin = 0.95;
my $supMax = 0.95;
my $supBy = 0.95;

my $covMin = 0.5;
my $covMax = 1.001;
my $covBy = 0.1;

my $proxMin = 0;
my $proxMax = 100;
my $proxBy = 10;

for(my $depth = $depthMin; $depth <= $depthMax; $depth += $depthBy){
	
	for(my $hq = $hqMin; $hq <= $hqMax; $hq += $hqBy){
		
		for(my $mq = $mqMin; $mq <= $mqMax; $mq += $mqBy){
		
			for(my $sup = $supMin; $sup <= $supMax; $sup += $supBy){
				
				for(my $cov = $covMin; $cov <= $covMax; $cov += $covBy){

					for(my $prox = $proxMin; $prox <= $proxMax; $prox += $proxBy){
					
						print "$depth\t$hq\t$mq\t$sup\t$cov\t$prox\n";
					}					
				}
			}
		}
	}
}
