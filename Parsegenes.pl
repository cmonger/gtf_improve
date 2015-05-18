#!/usr/bin/perl

# Extract gene name from blast "PREDICTED" line
# MAJOR ASSUMPTION: the last () is the genename


$file = shift @ARGV;
system("grep -v '^#' $file > $file.interestinglines");

open(fi, "<$file.interestinglines");
@text = <fi>;
close fi;

@ids = ();
%id2gene_map = {};
for ($i = 0; $i < scalar(@text); $i++) {
	$line = $text[$i];

	#if ($line =~ /PREDICTED/) {
		@entries = split(/[\s]+/, $line);	#split the line with PREDICTED by spaces and assume the first entry is the ID
		$id = $entries[0];
	
		$candidate = "";	
		while ($line =~ m/\(([\w]+)\)/g) {
			#print "Matched bracket is $1 -- an alphanumeric word (may not have numbers) ", pos($line), "\n";
			
			$candidate = $1;
			# NOW only collect them if there are numbers
	
	    	}	

		
		# Wippeee we found a gene (i.e. a alphanumeric word inside brackets with no spaces)
		push(@ids, $id);
		$id2gene_map{$id} .= "\t$candidate";
	

	#}
}

# UNiqe the ids
@uniqueids = uniq( @ids );

# UNiqe the genes for each id
for ($i = 0; $i < scalar(@uniqueids); $i++) {
	$id = $uniqueids[$i];
	$genestring = $id2gene_map{$id};
	@geneentries = split(/\t/, $genestring);
	@uniqueentries = uniq( @geneentries );
	$id2gene_map{$id} = "";
	for ($j = 0; $j < scalar(@uniqueentries); $j++) {
		$id2gene_map{$id} .= $uniqueentries[$j];
		$id2gene_map{$id} .= "\t";
	}
}

# PRINT THE IDs and GENES
for ($i = 0; $i < scalar(@uniqueids); $i++) {
	$id = $uniqueids[$i];
	if (length($id2gene_map{$id}) > 0) {
		print $id, "\t", $id2gene_map{$id}, "\n";
	}
}





# function to remove duplicates
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
