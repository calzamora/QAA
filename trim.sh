#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA
#adding this list so that I have the info of all the software I'm using in this environment
conda list -n QAA

#S9 L008 
/usr/bin/time -v trimmomatic PE \
    -threads 32 \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/cutadapt_out/S9_L008_R1_001.fastq.gz \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/cutadapt_out/S9_L008_R2_001.fastq.gz \
    trimmomatic/S9_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    trimmomatic/S9_L008_R1_001_TRIMMED_UNPAIRED.fastq.gz \
    trimmomatic/S9_L008_R2_001_TRIMMED_PAIRED.fastqc.gz \
    trimmomatic/S9_L008_R2_001_TRIMMED_UNPAIRED.fastq.gz \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

#S21
/usr/bin/time -v trimmomatic PE \
    -threads 32 \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/cutadapt_out/S21_L008_R1_001.fastq.gz \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/cutadapt_out/S21_L008_R2_001.fastq.gz \
    trimmomatic/S21_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    trimmomatic/S21_L008_R1_001_TRIMMED_UNPAIRED.fastq.gz \
    trimmomatic/S21_L008_R2_001_TRIMMED_PAIRED.fastqc.gz \
    trimmomatic/S21_L008_R2_001_TRIMMED_UNPAIRED.fastq.gz \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
