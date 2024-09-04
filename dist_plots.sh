#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA
#adding this list so that I have the info of all the software I'm using in this environment
conda list -n QAA

#11_2H_both_S9_L008_R1_001.fastq.gz
/usr/bin/time -v ./dist_qscore.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz -l 101 -o S9_L008_R1

#11_2H_both_S9_L008_R2_001.fastq.gz
/usr/bin/time -v ./dist_qscore.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R2_001.fastq.gz -l 101 -o S9_L008_R2

#29_4E_fox_S21_L008_R1_001.fastq.gz
/usr/bin/time -v ./dist_qscore.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R1_001.fastq.gz -l 101 -o S21_L008_R1

#29_4E_fox_S21_L008_R2_001.fastq.gz
/usr/bin/time -v ./dist_qscore.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R2_001.fastq.gz -l 101 -o S21_L008_R2