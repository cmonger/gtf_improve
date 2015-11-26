#!/usr/bin/perl

use warnings;

$file= shift @ARGV;

open(fi, $file);
@text =<fi>;
close fi;

foreach (@text) {

	if (/^(>)\d+\s(.+)/){
		print $1;
		print $2;}
	else {print $_;}

}
