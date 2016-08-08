#!/usr/bin/perl
# Searching files in a directory
use warnings;
use strict;
use Term::ANSIColor; # For Coloured Print Statements

# Author: Joseph Crisp
# Filtering the Recorded nucleotides according to Quality Metrics:
#		Read Depth
#		High Quality Base Depth
#		Mapping Quality
#		Allele Support
#		Proportion Isolates with Sufficient Coverage
#		Quality Score (QUAL)
#		FQ

# Command Line Run Structure: Should be ran in Directory with VCF Files
# perl FilterVariants.pl verbose DP HQDP MQ AlleleSupport propCoverage QUAL FQ merged.txt filteredSNPs.txt snpCoverage.txt

# MergedVCFs File Sample Information:
# #CHROM	Pos	Sample 1:Sample 2:Sample 3:...					\t
# 0			1 	2  		
# 				|		 
#				 ---->	DP	HQDP	MQ	QUAL	FQ	RefAlt		;
# 						0 	1  		2 	3		4	5

# Creates file where information for each SNP position is recorded (For each of the samples available):
# #CHROM	POS	Sample 1:Sample 2:Sample 3:...
# 0			1	2
#				|
#				 ---> 	DP	HQDP	MQ	AlleleSupport	AlleleCalled	QUAL	FQ		Result		;
# 						0 	1  		2 	3				5				6		7		8	

###########
# Filters #
###########

# Get the Filter thresholds from the Command Line options
my $verbose = shift @ARGV;

# Print out Help instructions if needed
if($verbose eq "-help" || $verbose eq ""){
	print color("green"), "Perl Script to filter the Variant Positions in the Merged VCF File.\n\nCommand Line Structure:\n";
	print "\tperl FilterVariants.pl DP HQDP MQ AlleleSupport propCoverage QUAL FQ merged.txt filteredSNPs.txt snpCoverage.txt\n", color("reset");
}else{

	my $dpFilter = shift @ARGV;
	my $hqdpFilter = shift @ARGV;
	my $mqFilter = shift @ARGV;
	my $supportFilter = shift @ARGV;
	my $propCovFilter = shift @ARGV;
	my $qualFilter = shift @ARGV;
	my $fqFilter = shift @ARGV;
	
	print "Filter Selection:\n" if $verbose == 1;
	print "\tDP = $dpFilter\n\tHQDP = $hqdpFilter\n\tMQ = $mqFilter\n\tSUP = $supportFilter\n\tCOV = $propCovFilter\n\tQUAL = $qualFilter\n\tFQ = $fqFilter\n" if $verbose == 1;

	###############
	# Preparation #
	###############

	####### Get Output File for Filtered Nucleotide Positions #######
	
	my $mergedFile = shift @ARGV; 
	open INPUT, $mergedFile or die "Couldn't open $mergedFile:$!"; # Attempt to open Current VCF File
	
	my $outputFilterFile = shift @ARGV; # Takes OUTPUT File name from Command Line Input
	open OUTPUTFILT, ">$outputFilterFile" or die "Couldn't open $outputFilterFile:$!"; # Assigns OUTPUTFILT File to Label and checks it can be Opened

	my $outputCoverageFile = shift @ARGV; # Takes OUTPUT File name from Command Line Input
	open OUTPUTCOV, ">$outputCoverageFile" or die "Couldn't open $outputCoverageFile:$!"; # Assigns OUTPUTCOV File to Label and checks it can be Opened

	print OUTPUTCOV "#CHROM\tPOS\tPropIsolatesWithSuffCov\tPropIsolateWithPosWithSuffCov\tNoIsolatesWithPos\n";
	
	print color("blue"), "Output File Checked. \n" if $verbose == 1;

	###################
	# Begin Filtering #
	###################

	print "Beginning Variant Filtering...\n" if $verbose == 1;
	
	# DP	HQDP	MQ	QUAL	FQ	RefAlt		;
	# 0 	1  		2 	3		4	5

	# Initialise the necessary variables
	my @snpInfo;
	my @isolateInfo;
	my $readDepth;
	my @hqBaseDepth;
	my $mappingQuality;
	my $qual;
	my $fq;
	my $ref;
	my $alt;
	
	# Initialise variables needed further calculations
	my $refProportion; # Proportion of HQ bases supporting Reference allele
	my $altProportion; 
	my $call;
	my @alleleHQDepth = (0) x 2;
	
	# Initialise variables to keep track of which isolates have coverage
	my $noIsolatesWithSufficientCoverage;
	my $noIsolatesWithPosNotPresent;
	my $noIsolatesWithPosPresent;
	my $proportionIsolatesWithSufficientCoverage;
	my $proportionIsolatesWithSufficientCoverageWherePresent;
	
	# Initialise an array to note the alleles of the sites removed
	my @nAlellesOfSitesRemoved = (0) x 4;
	
	# Initialise variables to store output
	my $result;
	my $resultInfo;
	my $outputLine;

	# Keep a count of the number of passed Variant Positions
	my $noPassedVPs = 0; # Note this counts VPs where at least one isolate passed the filtering criteria
	my $noVPs = 0;
	
	# Begin Reading the MergedVCFs file
	my $line;
	my @cols = ();
	while(<INPUT>){ # Read in each Line of Current VCF File
		$line = $_;
		chomp($line);
	
		# Print the VCF Header and Fields to File (Fields don't change)
		if($line =~ /^#/){
			print OUTPUTFILT "$line\n";
			next;
		}

		# Split the current line: #CHROM	POS	Sample 1:Sample 2:Sample 3:...
		@cols = split /\t/, $line;
		$outputLine = $cols[0] . "\t" . $cols[1] . "\t";
		$noVPs++;
	
		# Extract into Array SNP information for each Sample	
		@snpInfo = split /\:/, $cols[2];
	
		# Examine the SNP information from each of the isolates
		$noIsolatesWithSufficientCoverage = 0;
		$noIsolatesWithPosNotPresent = 0;
		for(my $pos = 0; $pos < scalar(@snpInfo); $pos++){
		
			# If there is no information available for the current sample then can't filter
			if($snpInfo[$pos] =~ /^----/){
				$outputLine = $outputLine . $snpInfo[$pos];
				$outputLine = $outputLine . "\:" if $pos < scalar(@snpInfo) - 1;
				$noIsolatesWithPosNotPresent++;
				next;
			}
			
			# Extract the Current Samples SNP Information
			# DP	HQDP	MQ	QUAL	FQ	RefAlt		;
			# 0 	1  		2 	3		4	5
			@isolateInfo = split /\;/, $snpInfo[$pos];
					
			# Store the quality Metrics
			$readDepth = $isolateInfo[0];
			@hqBaseDepth = split /\,/, $isolateInfo[1]; # ReferenceForward, ReferenceReverse, AlternateForward, AlternateReverse
			$mappingQuality = $isolateInfo[2];
			$qual = $isolateInfo[3];
			$fq = $isolateInfo[4];
			$ref = substr($isolateInfo[5], 0, 1);
			$alt = substr($isolateInfo[5], 1);
	
			# Calculate the Proportion of High Quality Bases supporting the Reference Allele
			$refProportion = 0;
			if($hqBaseDepth[0] + $hqBaseDepth[1] != 0){
				$refProportion = ($hqBaseDepth[0] + $hqBaseDepth[1]) / ($hqBaseDepth[0] + $hqBaseDepth[1] + $hqBaseDepth[2] + $hqBaseDepth[3]);
			}
		
			# Calculate the Proportion of High Quality Bases supporting the Alternate Allele
			$altProportion = 0;
			if($hqBaseDepth[2] + $hqBaseDepth[3] != 0){
				$altProportion = ($hqBaseDepth[2] + $hqBaseDepth[3]) / ($hqBaseDepth[0] + $hqBaseDepth[1] + $hqBaseDepth[2] + $hqBaseDepth[3]);
			}
		
			# Allocate Nucleotide Position - Either Ref or Alt Position
			$call = "NA"; 
			if($refProportion >= $altProportion){
				$call = "Ref";
				$alleleHQDepth[0] = $hqBaseDepth[0];
				$alleleHQDepth[1] = $hqBaseDepth[1];
			}else{
				$call = "Alt";
				$alleleHQDepth[0] = $hqBaseDepth[2];
				$alleleHQDepth[1] = $hqBaseDepth[3];
			}
			
		
			####### Apply the Filters #######
			$result = "Fail";
			
			# READ DEPTH
			if($readDepth >= $dpFilter){
				
				# HIGH QUALITY BASE DEPTH
				if($alleleHQDepth[0] >= $hqdpFilter && $alleleHQDepth[1] >= $hqdpFilter){
					
					# MAPPING QUALITY
					if($mappingQuality >= $mqFilter){
						
						# ALLELE SUPPORT
						if(($call eq "Ref" && $refProportion >= $supportFilter) || ($call eq "Alt" && $altProportion >= $supportFilter)){
							
							# QUALITY SCORE 
							if($qual >= $qualFilter){
									
								# FQ (FQ is negative)
								if($fq <= $fqFilter){
									
									$result = "Pass";
									$noIsolatesWithSufficientCoverage++;
								}
							}
						}
					}					
				}
			}
			
			# Where an Alternate position has passed but there is no alternate allele present set result to FAIL
			if($result eq "Pass" && $call eq "Alt" && $alt eq "."){
				$result = "Fail";
			}
		
			# Prepare the SNP filter information from the current sample DP	HQDP	MQ	AlleleSupport	AlleleCalled	QUAL	FQ		Result
			$resultInfo =  $readDepth . "\;" . $isolateInfo[1] . "\;" . $mappingQuality . "\;";
			if($call eq "Ref" && $result eq "Pass"){
				$resultInfo = $resultInfo . $refProportion . "\;" . $ref . "\;";
				
			}elsif($call eq "Alt" && $result eq "Pass"){
				$resultInfo = $resultInfo . $altProportion . "\;" . $alt . "\;";
				
			}else{
				$resultInfo = $resultInfo . $altProportion . "\;" . "N" . "\;";
			}
			$resultInfo = $resultInfo . $qual . "\;" . $fq . "\;" . $result;

			# Store the Filtering Results for the current isolate
			$outputLine = $outputLine . "$resultInfo";
		
			# Add in a separator if haven't reached the last isolate
			$outputLine = $outputLine . "\:" if $pos < scalar(@snpInfo) - 1;
		}	
	
		# SNP COVERAGE ACROSS ISOLATES
		$proportionIsolatesWithSufficientCoverage = $noIsolatesWithSufficientCoverage / scalar(@snpInfo);
		if( $proportionIsolatesWithSufficientCoverage >= $propCovFilter){
			print OUTPUTFILT "$outputLine\n";
			
			$noPassedVPs++ if $outputLine =~ /Pass/;
		
		# Record the allele of the site removed
		}else{
			
			if($ref eq 'A'){
				$nAlellesOfSitesRemoved[0]++;
			}elsif($ref eq 'C'){
				$nAlellesOfSitesRemoved[1]++;
			}elsif($ref eq 'G'){
				$nAlellesOfSitesRemoved[2]++;
			}elsif($ref eq 'T'){
				$nAlellesOfSitesRemoved[3]++;
			}else{
				print "ERROR!: Reference allele not recognised: $ref\n";
			}
		}
		$noIsolatesWithPosPresent = scalar(@snpInfo) - $noIsolatesWithPosNotPresent;
		$proportionIsolatesWithSufficientCoverageWherePresent = 0;
		$proportionIsolatesWithSufficientCoverageWherePresent = $noIsolatesWithSufficientCoverage / $noIsolatesWithPosPresent if $noIsolatesWithPosPresent != 0;
		
		
		# Print the Proportion of Isolates that have coverage at the current SNP
		print OUTPUTCOV "$cols[0]\t$cols[1]\t$proportionIsolatesWithSufficientCoverage\t$proportionIsolatesWithSufficientCoverageWherePresent\t$noIsolatesWithPosPresent\n";

	} # END
	close(INPUT);
	close(OUTPUTFILT);
	close(OUTPUTCOV);

	print color("green"), "Variant Filtering Complete.\n", color("reset") if $verbose == 1;
	my $noFiltered = $noVPs - $noPassedVPs;
	print "\t$noPassedVPs Variant Positions of $noVPs passed the filtering criteria ($noFiltered).\n";
	
	print "\nAllele Counts of removed sites:\n" if $verbose == 1;
	print "A\tC\tG\tT\n" if $verbose == 1;
	print "$nAlellesOfSitesRemoved[0]\t$nAlellesOfSitesRemoved[1]\t$nAlellesOfSitesRemoved[2]\t$nAlellesOfSitesRemoved[3]\n" if $verbose == 1;
}

