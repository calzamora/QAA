# RNA-seq Quality Assessment Assignment (QAA)
## Data: 
Library assignments:
```
/projects/bgmp/shared/Bi623/QAA_data_assignments.txt
```
my data assignment:\
29_4E_fox_S21_L008      11_2H_both_S9_L008

Demultiplexed, gzipped .fastq data:\
11_2H:
```
/projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz
```
```
/projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R2_001.fastq.gz 
```
29_4E:
```
/projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R1_001.fastq.gz
```
```
/projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R2_001.fastq.gz
```

## Part 1 - Read Quality Score Distributions: 
working dir:

/projects/bgmp/calz/bioinfo/Bi623/QAA

1) 
request interactive session:
```
srun --account=bgmp --partition=bgmp --time=1:00:00 --pty bash
```
QAA conda environment: 
```
$ conda create QAA
```
install FastQC:
```
$conda activate FastQC
$conda install FastQC
```
check version:
```
 $ fastqc --version 
FastQC v0.12.1
```
install python: 
```
$ conda install python
```
### running qc scripts
ok I'm going to run [dist_qscore.py](dist_qscore.py) I wrote in an SLURM script 
[dist_plots.sh](dist_plots.sh)

first run: 
```
$ sbatch dist_plots.sh 
Submitted batch job 15936344  
```
[First Slurm out](old_slurm/slurm-15936344.out)

failed because i need to pull in bioinfo module - ok copied it in try again: 
```
$ sbatch dist_plots.sh 
Submitted batch job 15936358
```
ok check its running: 
```
$ squeue -u calz
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          15936358      bgmp dist_plo     calz  R       0:39      1 n0351
```
ok while thats running im gunna figure out fastqc: 
https://hbctraining.github.io/Intro-to-rnaseq-hpc-salmon-flipped/lessons/05_qc_running_fastqc_interactively.html

make a directory to hold FastQC output: 
[fastqc](fastqc)

check fastqc manual: 
```
$ fastqc --help

            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

        fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN
```
well shoot error bc i dont have matplotlib [matplot lib error](old_slurm/slurm-15936358.out)

```
$ conda install matplotlib
```
and agian: 
```
 sbatch dist_plots.sh 
Submitted batch job 15936829
```
```
$ squeue -u calz
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          15936829      bgmp dist_plo     calz  R       0:52      1 n0351
```
worked: exit status 0 
[dist_plots successful](old_slurm/slurm-15936829.out)

ok I'm unsure if fastqc can run on zipped files so I am making a slurm for it: [fastqc_dist_plots.sh](fastqc_dist_plots.sh)
```
$ sbatch fastqc_dist_plots.sh 
Submitted batch job 15936836
```
[format error](old_slurm/slurm-15936836.out)

it errored because I used the 0f flag for the file not the format - remove and try again : 
```
$ sbatch fastqc_dist_plots.sh 
Submitted batch job 15936839
```