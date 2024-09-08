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
well shoot error bc i dont have matplotlib \
 [matplot lib error](old_slurm/slurm-15936358.out)

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
worked: exit status 0 \
**[dist_plots successful](slurm-15936829.out)**\
ok I'm unsure if fastqc can run on zipped files so I am making a slurm for it: **[fastqc_dist_plots.sh](fastqc_dist_plots.sh)**
```
	Command being timed: "./dist_qscore.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz -l 101 -o S9_L008_R1"
	User time (seconds): 313.13
	System time (seconds): 0.47
	Percent of CPU this job got: 97%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:21.41
```

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
ok it ran correctly and produced my plots! \
**[successful fastqc slurm](slurm-15939188.out)**

```
	Command being timed: "fastqc -o ./fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz"
	User time (seconds): 67.52
	System time (seconds): 3.15
	Percent of CPU this job got: 97%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:12.75
```

3. Run your quality score plotting script from your Demultiplexing assignment in Bi622. (Make sure you're using the "running sum" strategy!!) Describe how the `FastQC` quality score distribution plots compare to your own. If different, propose an explanation. Also, does the runtime differ? Mem/CPU usage? If so, why?

my y scale is much more zoomed in - therefore showing the variation in quality scire in much more minute detail, however it does give the impression that the low scores arem much worse on the quality scale than they are in reality due to this scale. 

FastQC is multithreaded.

**S21_L008_R1_001**

| Metric |  My Code     | FastQC (R1 + R2)|
| -------- | ------- | ------- |
| Runtime user/system  | 87.64/0.18    | 152.83/6.67    |
| Mem/CPU | 100%     | 98%    |
| Notes    | NA    | NA    |

**S21_L008_R2_001**

| Metric |  My Code     | FastQC (R1 + R2)|
| -------- | ------- | ------- |
| Runtime user/system  | 85.87/ 0.20   | 152.83/6.67    |
| Mem/CPU | 100%     | 98%    |
| Notes    | NA    | NA    |

**S9_L008_R1_001**
| Metric |  My Code     | FastQC (R1 + R2)|
| -------- | ------- | ------- |
| Runtime user/system  | 313.13/ 0.47   | 152.83/6.67    |
| Mem/CPU | 97%     | 98%    |
| Notes    | NA    | NA    |

**S9_L008_R1_001**
 Metric |  My Code     | FastQC (R1 + R2)|
| -------- | ------- | ------- |
| Runtime user/system  | 312.84/ 0.20   | 152.83/6.67    |
| Mem/CPU | 99%     | 98%    |
| Notes    | NA    | NA    |



**S9_L008_R2_001**
 Metric |  My Code     | FastQC (R1 + R2)|
| -------- | ------- | ------- |
| Runtime user/system  | 312.84/ 0.41   | 152.83/6.67    |
| Mem/CPU | 99%     | 98%    |
| Notes    | NA    | NA    |

4. Comment on the overall data quality of your two libraries. Go beyond per-base qscore distributions. Make and justify a recommendation on whether these data are of high enough quality to use for further analysis.

## Part 2 - Adapter Trimming comparison 
installations:
```
$ conda install cutadapt   
$ cutadapt --version                            
4.9                          
```
```
$ conda install trimmmomatic
$ trimmomatic -version 
0.39
```
### **cutadapt**
```
$ cutadapt --help
cutadapt version 4.9

Copyright (C) 2010 Marcel Martin <marcel.martin@scilifelab.se> and contributors

Cutadapt removes adapter sequences from high-throughput sequencing reads.

Usage:
    cutadapt -a ADAPTER [options] [-o output.fastq] input.fastq

For paired-end reads:
    cutadapt -a ADAPT1 -A ADAPT2 [options] -o out1.fastq -p out2.fastq in1.fastq in2.fastq
```
ok so how do i figure out what adaptor sequences were used? 

adapter seq from the readme: 

    R1: `AGATCGGAAGAGCACACGTCTGAACTCCAGTCA`
    
    R2: `AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT` 


[cutadapt.sh](cutadapt.sh)
```
$ sbatch cutadapt.sh 
Submitted batch job 16026127
```
that worked!\
[cutadapt_slurm_out](old_slurm/cutadadaptSlurmOut.out)

**Sanity check**
R1 is 5'-3'
R2 is 3'-5'

check if R1 adapter is in S9 R1 files 
```
 $ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz | grep AGATCGGAAGAGCACACGTCTGAACTCCAGTCA | wc -l 
 23629

```
check is R2 adapter is in S9 R2 files 
```
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R2_001.fastq.gz  | grep AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT | wc -l 
24496
```
check if R1 adapter is in S21 R1 files
```
 $ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R1_001.fastq.gz | grep AGATCGGAAGAGCACACGTCTGAACTCCAGTCA | wc -l 
 39701
```

check if R1 adapter is in S21 R2 files

```
$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R2_001.fastq.gz  | grep AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT | wc -l 
39929
```
make sure R1 adapters are not in R2 and visa versa 
```
 $ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R1_001.fastq.gz | grep AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT| wc -l 
0

$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/11_2H_both_S9_L008_R2_001.fastq.gz  | grep AGATCGGAAGAGCACACGTCTGAACTCCAGTCA| wc -l 
0

$ zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/29_4E_fox_S21_L008_R2_001.fastq.gz  | grep AGATCGGAAGAGCACACGTCTGAACTCCAGTCA| wc -l 
0
```
and that is all what i would expect yay : 


### trimmomatic
help page: 
http://www.usadellab.org/cms/?page=trimmomatic

slurm script:\
[trim.sh](trim.sh)

reran cutadapt to zip outputs: 
[cut_zip_slurm](old_slurm/cut_zip_slurm.out)

## Part 3 - alignments
```
$ conda install star
$ conda install numpy
$ conda install htseq
```

**mouse ensemble**

mouse db directory:\
**[Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b)](Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b)**

genome assembly:\
https://ftp.ensembl.org/pub/release-112/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna_rm.primary_assembly.fa.gz

gtf:\
https://ftp.ensembl.org/pub/release-112/gtf/mus_musculus/Mus_musculus.GRCm39.112.gtf.gz


ok I sbatched the wget for the assembly 
[wget](slurm-16027631.out)

ran the challange fastqc\
**[challange_fastqc.sh](challange_fastqc.sh)**
```
$ sbatch challange_fastqc.sh 
Submitted batch job 16029511
```

and saved it all to:\
**[challange_fastqc](challange_fastqc)**

so when i come back - i will make the mouse db and run star\
[star_mouse_db.sh](star_mouse_db.sh)\
[star_align.sh](star_align.sh)

```
$ sbatch star_mouse_db.sh
$ sbatch star_align.sh 
```

copied in mapped_counts.py from ps8 

added argparse and chmoded in this directory: 
```
12:03 PM calz QAA $ ./mapped_counts.py -f S21_L008_001Aligned.out.sam
Mapped Reads: 8883008
Unmapped Reads: 260800
12:03 PM calz QAA $ ./mapped_counts.py -f S9_L008_001Aligned.out.sam
Mapped Reads: 33637699
Unmapped Reads: 1293527
```

### HTseq count
https://htseq.readthedocs.io/en/release_0.11.1/count.html

htseq-count [options] <alignment_files> <gff_file> > [outfile]
" You should run htseq-count twice: once with `--stranded=yes` and again with `--stranded=reverse`. Use default parameters otherwise."

```
$ sbatch htseq.sh 
Submitted batch job 16037607
```