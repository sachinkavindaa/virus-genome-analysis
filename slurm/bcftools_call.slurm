#!/bin/sh
#SBATCH --time=1:00:00          # Run time in hh:mm:ss
#SBATCH --ntasks-per-node=8       # Maximum memory required per CPU (in megabytes)
#SBATCH --nodes=1
#SBATCH --mem=10G
#SBATCH --job-name=bcftools_call
#SBATCH --error=bcf_call_%a.err
#SBATCH --output=bcf_call_%a.out 
 
module load bowtie/2.2 tophat/2.1 samtools/1.17 bcftools/1.17 minimap2

bcftools mpileup -f /work/asci832/shared/mystery/reference/ncbi_dataset/data/GCF_000908395.1/GCF_000908395.1_Lone_Star_Virus_genomic.fasta sorted.bam | bcftools call -mv -Ov -o calls.vcf.gz

bcftools index calls.vcf.gz

bcftools view -O z -o calls_q10.vcf.gz -e 'QUAL<=10' calls.vcf.gz

gunzip -k calls_q10.vcf.gz

#bcftools view -O v -o calls_q10.vcf -i 'QUAL>=10' calls.vcf

