#!/bin/sh
#SBATCH --time=6:00:00          # Run time in hh:mm:ss
#SBATCH --ntasks-per-node=4       # Maximum memory required per CPU (in megabytes)
#SBATCH --nodes=1
#SBATCH --mem=50G
#SBATCH --job-name=align_minimap2_lsv
#SBATCH --error=align_%a.err
#SBATCH --output=align_%a.out 
 
module load samtools/1.17 bcftools/1.17 minimap2

#gunzip seqs/seq*/fastq_pass/*.fastq.gz

#cat seqs/seq*/fastq_pass/*.fastq > all.fastq

minimap2 -t 4 -a -x map-ont /work/asci832/shared/mystery/reference/ncbi_dataset/data/GCF_000908395.1/GCF_000908395.1_Lone_Star_Virus_genomic.fasta /work/asci832/shared/mystery/seqs/all.fastq | samtools sort -o sorted.bam

samtools index sorted.bam


