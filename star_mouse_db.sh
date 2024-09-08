#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH -c 8

conda activate QAA
#adding this list so that I have the info of all the software I'm using in this environment
conda list -n QAA


/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
    --genomeDir /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --genomeFastaFiles /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.dna.primary_assembly.fa \
    --sjdbGTFfile /projects/bgmp/calz/bioinfo/Bi623/QAA/Mus_musculus.GRCm39.112.gtf