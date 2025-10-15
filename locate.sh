#!/usr/bin/env bash
set -euo pipefail
target=""
OUT=""
genome=""

usage() {
cat <<EOF
Usage: $(basename "$0") [options]

  -t  target fasta.fa                     [$target]
  -g  genome, where target is located.mmi [$genome]
  -h  help
be sure you are using minimap2, samtools
EOF

exit 1
}

while getopts ":g:p:a:b:r:t:c:n:o:h" opt; do
  case $opt in
    t) target=$OPTARG ;;
    g) genome=$OPTARG ;;
    h|\?) usage ;;
  esac
done

if [[ -z "$target" || -z "$genome" ]]; then
  echo "Error: Missing required arguments."
  usage
fi

minimap2 -x sr -t 8 $genome $target > hits.paf.tmp
awk '{print $6}' hits.paf.tmp | sort -u > read_ids_with_query.txt.tmp
samtools view -@ 8 -N read_ids_with_query.txt.tmp -b calls_with_insert.sorted.bam > motif_reads.bam.tmp
samtools index motif_reads.bam.tmp -o motif_reads.bam.bai.tmp
samtools view motif_reads.bam.tmp | awk '{print $3"\t"$4}'
rm -f *tmp*
