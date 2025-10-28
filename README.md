This script allows you to locate the sequence in the annotated genome .mmi file with long reads. 

  -t  target fasta.fa                     
  -g  genome, where target is located.mmi 
  -h  help

The result of the script is coordinates of your sequence in the genome, outputed in the shell. 
EXAMPLE OF USING THE SCRIPT
bash locate.sh -t probes.fa -g annotated_nanopore_genome.mmi 
