## gtf_improve

 a tool for parsing gtf files and blast input and collating the information for a better annotated gtf 
 
 
 
 
## Usage

1) Use a de novo transcriptome assembly algorithm which outputs a gtf file<br>
2) Extract the transcripts from the gtf with gtf_to_fasta (cufflinks suite)<br>
3) Perform local blast on nt database with ' -max_target_seqs-outfmt '7seqid stitle''<br>
4) Run the Parsegenes.pl script on blast output to extract gene names<br>
5) Parse this and append the gene names to the gtf with gtf_improve.pl<br>
