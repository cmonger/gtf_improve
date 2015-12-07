#!/usr/bin/perl;
#use warnings;

#Perl script for combining the results of blastp on swissprot with the output of transdecoder using cufflinks input
#This allows retention of swissprot ids and gene names for better annotation
#craig monger 7/12/2015

#Usage ./annotateTransDecoderGffWithSp.pl threshold(INT) blast_outfmt6 transdecodergff > outfilename.gff
#E.G. perl annotateTransDecoderGffWithSp.perl 60 sp_blastp.outfmt6 transcripts.fasta.transdecoder.genome.gff3


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
	
#foreach (keys %$tidDatabase) #database debug test	
#		{
#		print $tidDatabase->{$_}->{"spid"}."\t".$tidDatabase->{$_}->{"name"}."\n" ;
#		} 


# Parse the gff file

foreach $line (@gffIn)
	{
        my @column = split( /\s+/, $line );
	if ($column[2] eq 'gene')
		{
		if ($line =~ /(\S+\t\S+\t\S+\t\S+\t\S+\t.\t.\t.\tID=\S+|.+;Name=)/)
			{
			$trimorf = $1 ;
			$ninth = $column[8];
			@splitter2 = split(/\|/, $ninth);
			$id = $splitter2[0];
			$id =~ s/ID=//g;
			chomp $id;
			print $trimorf.$tidDatabase->{$id}->{"name"}.";Dbxref=".$tidDatabase->{$id}->{"spid"}.";\n";
			}
		}
	elsif ($column[2] eq 'mRNA')
		{
		if ($line =~ /(\S+\t\S+\t\S+\t\S+\t\S+\t.\t.\t.\tID=\S+|.+;Name=)/)
			{
			$trimorf = $1 ;
			$ninth = $column[8];
			@splitter2 = split(/\|/, $ninth);
			$id = $splitter2[0];
			$id =~ s/ID=//g;
			chomp $id;
			print $trimorf.$tidDatabase->{$id}->{"name"}.";Dbxref=".$tidDatabase->{$id}->{"spid"}.";\n";
			}
		}
	else { print $line;}
	}

















