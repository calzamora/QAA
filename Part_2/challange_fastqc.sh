#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA
#adding this list so that I have the info of all the software I'm using in this environment
conda list -n QAA

#11_2H_both_S9_L008_R1 + 2 TRIMMED
/usr/bin/time -v fastqc \
    -o ./challange_fastqc \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S9_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S9_L008_R2_001_TRIMMED_PAIRED.fastqc.gz

#29_4E_fox_S21_L008_R1 +2 TRIMMED
/usr/bin/time -v fastqc \
    -o ./challange_fastqc \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S21_L008_R1_001_TRIMMED_PAIRED.fastqc.gz \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/trimmomatic/S21_L008_R2_001_TRIMMED_PAIRED.fastqc.gz
