#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA

#S9
/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S9_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    trimmomatic/S9_L008_R2_001_TRIMMED_PAIRED.fastqc.gz \
    --genomeDir /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --outFileNamePrefix S9_L008_001

#S21
/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S21_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S21_L008_R2_001_TRIMMED_PAIRED.fastqc.gz \
    --genomeDir /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --outFileNamePrefix S21_L008_001