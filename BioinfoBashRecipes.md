# Bash programming for bioinformatics

Make sure you have your data in the directory.
```
cd ~/Research
ls data
```

### 1. How many genes/chromsomes/contigs are in my fasta file?

The anatomy of a fasta file
```
>Chr1 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
TTGTTTTGCTTCTTTGAAGTAGTTTCTCTTTGCAAAATTCCTCTTTTTTTAGAGTGATTTGGATGATTCAAGACTTCTC
GGTACTGCAAAGTTCTTCCGCCTGATTAATTATCCATTTTACCTTTGTCGTAGATATTAGGTAATCTGTAAGTCAACTC
>Chr2 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
CTCGACCAGGACGATGAATGGGCGATGAAAATCTATCGGGTTAGAGGAATGGTCGACCGGGTCCGAGAATTCGTCGACC
AGGACGAGGAGTGGTCGAGGATTTGTCGACCAGGAGTTGAAATCGTCGACCGGGTCCGAGAATTCGTCGACCAGGACGG
>Chr3 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
ACCCTAATCTTTAGTTCCTAGACCCTAAATCCATAATCCTTAATTCCTAAATTCCTAAATCCCTAATACTAAATCTCTA
AATCCCTAGCAATTTTCAAGTTTTGCTTGATTGTTGTAGGATGGTCCTTTCTCTTGTTTCTTCTCTGTGTTGTTGAGAT
```

Another example
```
>AT1G51370.2 | Symbols:  | F-box/RNI-like/FBD-like domains-containing protein | chr1:19045615-19046748 FORWARD LENGTH=346
MVGGKKKTKICDKVSHEEDRISQLPEPLISEILFHLSTKDSVRTSALSTKWRYLWQSVPGLDLDPYASSNTNTIVSFVES
...
EMLPTLLESCPKLESLILVMSSFNPS
>AT1G50920.1 | Symbols:  | Nucleolar GTP-binding protein | chr1:18870555-18872570 FORWARD LENGTH=671
MVQYNFKRITVVPNGKEFVDIILSRTQRQTPTVVHKGYKINRLRQFYMRKVKYTQTNFHAKLSAIIDEFPRLEQIHPFYG
...
ARRGEADRVIPTLRPKHLFSGKRGKGKTDRR
>AT1G36960.1 | Symbols:  | unknown protein; BEST Arabidopsis thaliana protein match is: unknown protein (TAIR:AT1G48095.1); Has 54 Blast hits to 54 pr
MTRLLPYKGGDFLGPDFLTFIDLCVQVRGIPLPYLSELTVSFIAGTLGPILEMEFNQDTSTYVAFIRVKIRLVFIDRLRF
...
```

Get the header lines.

```
$ grep '>' data/TAIR10.fas 
>Chr1 CHROMOSOME dumped from ADB: Jun/20/09 14:53; last updated: 2009-02-02
>Chr2 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
>Chr3 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
>Chr4 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
>Chr5 CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2009-02-02
>chloroplast CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2005-06-03
>mitochondria CHROMOSOME dumped from ADB: Jun/20/09 14:54; last updated: 2005-06-03

$ grep '>' data/TAIR10.fas  | wc -l
       7
```

To get only the chromosome name
```
$ grep '>' data/TAIR10.fas  | cut -d' ' -f1 | cut -d'>' -f2
Chr1
Chr2
Chr3
Chr4
Chr5
chloroplast
mitochondria
```

I would like to have ChrM instead of mitochondria, but the file is huge (300Mb) and I cannot open it in word. 
```
$ sed 's/mitochondria/ChrM/' < data/TAIR10.fas  > data/TAIR10.new.fas
```

Oh, I forget chloroplast
```
$ sed 's/mitochondria/ChrM/' < Test.fas | sed 's/chloroplast/ChrC/' > Test1.fas
```


### 2. How many reads in a fastq file?

What is a fastq file?

```
@ERR274309.996 HWI-B5-690_0070_FC:5:1:10722:1134#0 length=76
TGATAGTCAGAAACCTTCTCAACAAAATCGTTACCCAGTAACTGAGCTGCTCCCACATGATCCTCTTTAATCGGTT
+ERR274309.996 HWI-B5-690_0070_FC:5:1:10722:1134#0 length=76
IIIIIIIIIIIIIIIIIIIIIIIIIIHIIIIIIIIIIIDIIIBEIHI@FIIIHIGHHEGGFIIEGGGGGEEIGEDG
@ERR274309.997 HWI-B5-690_0070_FC:5:1:10854:1139#0 length=76
CCGGCGATGCGTCCTGGTCGGATGCGGAACGGAGCAATCCGGTCCGCCGATCGATTCGGGGCGTGGACCGACGCGG
+ERR274309.997 HWI-B5-690_0070_FC:5:1:10854:1139#0 length=76
IIIIIIHHIIIHIHIGEEGGEIFHIIHIIIGH@FB)9293BB@DDBEECC;EBB=ABB@ABBA*BB?BA@?@@:@@
```

How to count number of reads?
```
$ grep '^@' data/SampleFastq.fastq | wc -l
    1009

$ cat data/SampleFastq.fastq | echo $((`wc -l`/4))
1000

```

### 3. How many reads mapped ? 

What is a sam/bam file?

```
@HD	VN:1.0	SO:unsorted
@SQ	SN:Chr1	LN:7899921
@SQ	SN:1	LN:3949921
@PG	ID:bowtie2	PN:bowtie2	VN:2.2.4	CL:"/Users/song/Research/ExampleRNAseq/softwares/bowtie2-2.2.4/bowtie2-align-s --wrapper basic-0 -k 10 -x /Users/song/Research/ExampleRNAseq/data/chr1p -U /Users/song/Research/ExampleRNAseq/data/ERR274309.fastq"
ERR274309.54	16	Chr1	3124345	1	76M	*	0	0	TNNNNNCGNAANTTTGTCAACAAAGGCCTCATGTTTGTTTGTGTTCGTTTGTCTGAGCATGTAGGTGGAACTTATC	################?=>?<AAACD<D<DGCAA9EGDGGGEEB@BDDBBGGBEGGEEC>EG8GGDGGGGEGGGDG	AS:i:-7	XS:i:-7	XN:i:0	XM:i:7	XO:i:0	XG:i:0	NM:i:7	MD:Z:1A0A0A0A0A2C2A64	YT:Z:UU
ERR274309.54	272	1	3124345	1	76M	*	0	0	TNNNNNCGNAANTTTGTCAACAAAGGCCTCATGTTTGTTTGTGTTCGTTTGTCTGAGCATGTAGGTGGAACTTATC	################?=>?<AAACD<D<DGCAA9EGDGGGEEB@BDDBBGGBEGGEEC>EG8GGDGGGGEGGGDG	AS:i:-7	XS:i:-7	XN:i:0	XM:i:7	XO:i:0	XG:i:0	NM:i:7	MD:Z:1A0A0A0A0A2C2A64	YT:Z:UU
ERR274309.65	16	Chr1	7181157	255	76M	*	0	0	GNNNNNGACGANGATTAAGAAGTTGAAGTTGTGGTAGCGTAATATAGAAGGCTGCAAGGAATCTCTCGGATGTTTT	################HEEEF=:2=7<1(8;<FC>HHFHEFGDD@G?A?8.>>??CEGCEC8EDGEGHHHHHHGHH	AS:i:-6	XN:i:0	XM:i:6	XO:i:0	XG:i:0	NM:i:6	MD:Z:1A0G0G0A0A5T64	YT:Z:UU
```

How many reads?

```
$ grep -v '^@' data/SampleSam.sam | wc -l
    9996
$ wc -l data/SampleSam.sam 
   10000 data/SampleSam.sam
```

There could be one read map to more than one location though.
```
$ grep -v '^@' data/SampleSam.sam | cut -f1 | head

$ grep -v '^@' data/SampleSam.sam | cut -f1 | uniq | head

$ grep -v '^@' data/SampleSam.sam | cut -f1 | uniq | wc -l 

$ grep -v '^@' data/SampleSam.sam | cut -f1 | uniq -c | head

$ grep -v '^@' data/SampleSam.sam | cut -f1 | uniq -c | sort | awk '{print $1}' | sort | uniq -c
2586 1
2811 2
  23 3
 208 4
  11 5
 126 6
   6 7
   2 8
   2 9

```

How many reads map to Chr1 and how many map to 1?
```
$ grep -v '^@' data/SampleSam.sam | cut -f3 | sort | uniq -c 
3418 1
6578 Chr1

```

How many reads map from head to tail?
```
$ grep -v '^@' data/SampleSam.sam | cut -f6 | sort | uniq -c | sort | tail
  10 70M1I5M
  10 71M1I4M
  11 66M3I7M
  11 70M2I4M
  12 4M2I70M
  13 4M4I68M
  17 64M7I5M
  19 4M1I71M
  23 68M4I4M
9216 76M
```

How many insertions in the reads?
```
$ grep -v '^@' data/SampleSam.sam | cut -f6 | grep 'I' | wc -l
     647
```

SAM flag statistics. To check the meaning: [this link](http://broadinstitute.github.io/picard/explain-flags.html)
```
$ grep -v '^@' data/SampleSam.sam | cut -f2 | sort | uniq -c
2846 0
2929 16
2115 256
2106 272
```

### 4. How many rows in gtf file are protein coding genes?

```
```

### 5. How many reads are mapped from head to tail?

```
```

### 6. Why my bam file is not showing up in IGV?

```
```
