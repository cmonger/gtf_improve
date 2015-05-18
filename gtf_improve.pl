#!/usr/bin/perl

=begin GHOSTCODE

open fi, "<CH_Geneids_GeneNames.txt" or die;
@geneids = <fi>;
close fi;



#going to loop through every gene in the geneid list, count the number of gene matches then store them into a data frame

$ids = ();
foreach (@geneids) 
	{
	$number = () = $_ =~ /\s+(\w+)/g; #find the number of times this regex (amount of genes)is found
	if ($number = 1)
		{
	        if (/^(\w+)\s+(\w+)/)
			{
			$ids->{$1}->{"genename1"}= $2; 
			}
		else {print "error on line $_\n"};
		}
	elsif ($number = 2)
		{
		if (/^(\w+)\s+(\w+)\s+(\w+)/)
			{
			$ids->{$1}->{"genename1"}=$2;
			$ids->{$1}->{"genename2"}=$3;
			}
		else {print "error on line $_\n"}
		} 
	 elsif ($number = 3)
                {
                if (/^(\w+)\s+(\w+)\s+(\w+)\s+(\w+)/)
                        {
                        $ids->{$1}->{"genename1"}=$2;
                        $ids->{$1}->{"genename2"}=$3;
			$ids->{$1}->{"genename3"}=$4;
                        }
                else {print "error on line $_\n"}
                }
        elsif ($number = 4)
                {
                if (/^(\w+)\s+(\w+)\s+(\w+)\s+(\w+)\s+(\w+)/)
                        {
                        $ids->{$1}->{"genename1"}=$2;
                        $ids->{$1}->{"genename2"}=$3;
			$ids->{$1}->{"genename3"}=$4;
			$ids->{$1}->{"genename4"}=$5;
                        }
                else {print "error on line $_\n"}
                }
        elsif ($number = 5)
                {
                if (/^(\w+)\s+(\w+)\s+(\w+)\s+(\w+)\s+(\w+)\s+(\w+)/)
                        {
                        $ids->{$1}->{"genename1"}=$2;
                        $ids->{$1}->{"genename2"}=$3;
                        $ids->{$1}->{"genename3"}=$4;
                        $ids->{$1}->{"genename4"}=$5;
                        $ids->{$1}->{"genename5"}=$6;
                        }
                else {print "error on line $_\n"}
                }
	elsif ($number > 5) {print "more than 5 gene names on $_\n";}
	else {print "error on line $_\n";}
	}	

	
foreach (keys %$ids){print $ids->{$_}->{"genename1"}} ; #this syntax will allow me to refer to the gene names using the id as a key

=end GHOSTCODE
=cut

#The gene ID's and their corresponding gene names have now been read into memory and now we can read the gtf file and start searching this data for matching gene identifiers.

open fi, "cho_gtf.gtf"
@gtf= 

