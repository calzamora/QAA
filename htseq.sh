#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA
#adding this list so that I have the info of all the software I'm using in this environment
conda list -n QAA

#S9 stranded
/usr/bin/time -v htseq-count --stranded=yes \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/S9_L008_001Aligned.out.sam \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.112.gtf \
    > htseq_out_S9_stranded

#S9 reverse
/usr/bin/time -v htseq-count --stranded=reverse \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/S9_L008_001Aligned.out.sam \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.112.gtf \
    > htseq_out_S9_reverse

#S21 stranded
/usr/bin/time -v htseq-count --stranded=yes \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/S9_L008_001Aligned.out.sam \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.112.gtf \
    > htseq_out_S21_stranded

#S21 reverse
/usr/bin/time -v htseq-count --stranded=reverse \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/S21_L008_001Aligned.out.sam \
    /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.112.gtf \
    > htseq_out_S21_reverse