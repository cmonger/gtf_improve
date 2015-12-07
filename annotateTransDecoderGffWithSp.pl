#!/usr/bin/perl;
use warnings;

#Perl script for combining the results of blastp on swissprot with the output of transdecoder using cufflinks input
#This allows retention of swissprot ids and gene names for better annotation
#craig monger 7/12/2015

#Usage ./annotateTransDecoderGffWithSp.pl threshold(INT) blast_outfmt6 transdecodergff > outfilename.gff

#taking command line input variables
$threshold = shift;
$blastOut = shift;
$gff = shift;


#reading files into memory and closing filehandles
if (-e $blastOut) {
		  open(fi, $blastOut);
		  @blastIn = <fi>;
		  close fi;
		  }
else {print "\n Blast Swissprot output file not found, please check file exists \n" ; exit;}

if (-e $gff)      {
		  open(fi, $gff);
		  @gffIn = <fi>;
		  close fi;
                  }
else {print "\n Gff output file not found, please check file exists \n" ; exit;}

#Create dataframe of transcript ids and info from blast output

$tidDatabase = ();

foreach (@blastIn) 
	{
	if (/(\S+)\|\S+\tsp\|(\S+)\|(\S+)_\S+\t(\d+)/) #not sure if need to backslash pipes
		{
		if ($4 > $threshold)
				   {
				   $tidDatabase->{$1}->{"name"} = $3;
				   $tidDatabase->{$1}->{"spid"} = $2;
				   }
		}
	}
		
foreach (keys %$tidDatabase)
		{
		print $tidDatabase->{$_}->{"spid"}."\t".$tidDatabase->{$_}->{"name"}."\n" ;
		} 
# Read in the gff file
