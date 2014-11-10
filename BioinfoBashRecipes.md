# Bash programming for bioinformatics

Make sure you have your data in the directory.
```
cd ~/Research/Proj1
ls data
```

### 1. How many genes/chromsomes/contigs are in my fasta file?

The anatomy of a fasta file (from www.arabidopsis.org)
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

Another example (from www.arabidopsis.org)
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
$ sed 's/mitochondria/ChrM/' < Test.fas | sed 's/chloroplast/ChrC/' > data/TAIR10.new.fas
```


### 2. How many reads in a fastq file?

What is a fastq file? (data source http://www.ncbi.nlm.nih.gov/bioproject/PRJEB1937)

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

### 3. Working with SAM files.  

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

It's not aways number
```
$ grep -v "^@" data/SampleSam.sam | sort -k4 | head -n3
ERR274309.50888	0	Chr1	1000258	1	76M	*	0	0	CGAAAGTGGCACTTGTAAGACTTTGGCTGATGTTTTTAAAAGCCTTGTTTGTAAGAGAAGGGCGATATACATAGTC	IIHIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIIIIIGIDIIIIIIIIIIIIIIIIFIIIIIIHIIGIIIIHIGF	AS:i:0	XS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UU
ERR274309.50888	256	1	1000258	1	76M	*	0	0	CGAAAGTGGCACTTGTAAGACTTTGGCTGATGTTTTTAAAAGCCTTGTTTGTAAGAGAAGGGCGATATACATAGTC	IIHIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIIIIIGIDIIIIIIIIIIIIIIIIFIIIIIIHIIGIIIIHIGF	AS:i:0	XS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UU
ERR274309.20988	0	1	100642	0	12M2I2M2I58M	*	0	0	CTTTAAACTACTAATAATGGATTTTTGTTGTGTCTTAATGAAATAATGGGAGCAGCTGAAGCAAGAGCATTGTGGC	HHHHHHHBFG<GGGGGHGGGHGHHHHHDHDGGGDBGGGD<GDBGGDDDGD8ECEEG>GEED>GGDCGE@DCC>A<8	AS:i:-46	XS:i:-46	XN:i:0	XM:i:5	XO:i:XG:i:4	NM:i:9	MD:Z:2C1T2T1T0T61	YT:Z:UU



$ grep -v "^@" data/SampleSam.sam | sort -k4n | head
ERR274309.34957	16	Chr1	5224	1	76M	*	0	0	ACCGGGCCATACTCGTATAGATGATATTCCATCATTGAACATTATTGAGCCTTTGCACAATTATAAGGCACAAGAG	IIHIIIHIHIFHIGHIIIIIIGEIIIIIIIIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	AS:i:0	XS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UU
ERR274309.34957	272	1	5224	1	76M	*	0	0	ACCGGGCCATACTCGTATAGATGATATTCCATCATTGAACATTATTGAGCCTTTGCACAATTATAAGGCACAAGAG	IIHIIIHIHIFHIGHIIIIIIGEIIIIIIIIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	AS:i:0	XS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UU
ERR274309.52830	16	Chr1	5556	1	76M	*	0	0	AACTATCTCAAGAACATGATCATTGGTGTCTTGTTGTTCATCTCCGTCATTAGTTGGATCATTCTTGTTGGTTAAG	BFEEFDC>CC??;?B8@DFGG>?ECEDDAGADB@DDGGBG@DB@DB?EE<E<BEEB>?>AC>?B9>GDBGD>GDGG	AS:i:0	XS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UU
```


### 4. How many rows in gtf file are protein coding genes?

looking into your GFF file

```
Chr1	TAIR10	gene	3631	5899	.	+	.	ID=AT1G01010;Note=protein_coding_gene;Name=AT1G01010
Chr1	TAIR10	mRNA	3631	5899	.	+	.	ID=AT1G01010.1;Parent=AT1G01010;Name=AT1G01010.1;Index=1
Chr1	TAIR10	protein	3760	5630	.	+	.	ID=AT1G01010.1-Protein;Name=AT1G01010.1;Derives_from=AT1G01010.1
Chr1	TAIR10	exon	3631	3913	.	+	.	Parent=AT1G01010.1
Chr1	TAIR10	CDS	3760	3913	.	+	0	Parent=AT1G01010.1,AT1G01010.1-Protein;
Chr1	TAIR10	exon	3996	4276	.	+	.	Parent=AT1G01010.1
Chr1	TAIR10	CDS	3996	4276	.	+	2	Parent=AT1G01010.1,AT1G01010.1-Protein;
Chr1	TAIR10	exon	4486	4605	.	+	.	Parent=AT1G01010.1
Chr1	TAIR10	chromosome	1	30427671	.	.	.	ID=Chr1;Name=Chr1
Chr1	TAIR10	five_prime_UTR	3631	3759	.	+	.	Parent=AT1G01010.1
```

What types of features are in the GFF file?
```
$ cut -f3 data/SampleGFF.gff | sort | uniq -c | sort
   1 chromosome
   1 snRNA
  14 snoRNA
  27 miRNA
  87 ncRNA
 112 tRNA
 162 pseudogene
 162 pseudogenic_transcript
 234 pseudogenic_exon
 631 transposable_element_gene
33697 CDS
36828 exon
4705 gene
5164 three_prime_UTR
5835 five_prime_UTR
5854 protein
6486 mRNA
```

Let's check out non-coding RNA
```
$ grep 'ncRNA' data/SampleGFF.gff | head
Chr1	TAIR10	ncRNA	163431	166239	.	+	.	ID=AT1G01448.1;Parent=AT1G01448;Name=AT1G01448.1;Index=1
Chr1	TAIR10	ncRNA	163432	164687	.	+	.	ID=AT1G01448.2;Parent=AT1G01448;Name=AT1G01448.2;Index=1
Chr1	TAIR10	ncRNA	163419	164576	.	+	.	ID=AT1G01448.3;Parent=AT1G01448;Name=AT1G01448.3;Index=1
Chr1	TAIR10	ncRNA	665354	666367	.	+	.	ID=AT1G02952.1;Parent=AT1G02952;Name=AT1G02952.1;Index=1
Chr1	TAIR10	ncRNA	885941	887906	.	+	.	ID=AT1G03545.1;Parent=AT1G03545;Name=AT1G03545.1;Index=1
Chr1	TAIR10	ncRNA	1147781	1148435	.	+	.	ID=AT1G04295.1;Parent=AT1G04295;Name=AT1G04295.1;Index=1
Chr1	TAIR10	ncRNA	1194187	1196889	.	+	.	ID=AT1G04425.1;Parent=AT1G04425;Name=AT1G04425.1;Index=1
Chr1	TAIR10	ncRNA	1645875	1647162	.	+	.	ID=AT1G05562.1;Parent=AT1G05562;Name=AT1G05562.1;Index=1
Chr1	TAIR10	ncRNA	1820977	1821918	.	+	.	ID=AT1G06002.1;Parent=AT1G06002;Name=AT1G06002.1;Index=1
Chr1	TAIR10	ncRNA	1914943	1917661	.	-	.	ID=AT1G06265.1;Parent=AT1G06265;Name=AT1G06265.1;Index=1
```

How many ncRNAs are on the forward strand?
```
$ grep 'ncRNA' data/SampleGFF.gff | cut -f 7 | sort | uniq -c
  44 +
  43 -
```

How many uniq noncoding RNAs are there?
```
$ grep 'ncRNA' data/SampleGFF.gff | cut -f 9 | cut -d'=' -f 3 | cut -d';' -f1 | sort | uniq | wc -l 
      73
```

### 5. the almighty AWK

Any sequence pattern in your FASTQ reads?
Check out the first 4 mers.
```
$ awk '/^@ERR/{getline; print}' < data/SampleFastq.fastq | cut -c-4 | sort | uniq -c | sort
```

How about the last 4 mers?
```
$ awk '/^@ERR/{getline; print}' < data/SampleFastq.fastq | sed 's/^.*\(....\)$/\1/' | sort | uniq -c | sort
```

What are the read names that mapped from head to tail?
```
$ awk '{if ($6=="76M") print $1}' data/SampleSam.sam | sort | uniq | wc -l
    5327

$ awk '{if ($6=="76M") print $1}' data/SampleSam.sam | sort | uniq | head
```

Calculate gene length for all protein coding genes, or even average gene length.
```
$ awk '{if ($3=="protein") print $0}' data/SampleGFF.gff | head
Chr1	TAIR10	protein	3760	5630	.	+	.	ID=AT1G01010.1-Protein;Name=AT1G01010.1;Derives_from=AT1G01010.1
Chr1	TAIR10	protein	6915	8666	.	-	.	ID=AT1G01020.1-Protein;Name=AT1G01020.1;Derives_from=AT1G01020.1

$ awk '{if ($3=="protein") print $0}' data/SampleGFF.gff | awk '{print $5-$4}' | head
1870
1751

$ awk '{if ($3=="protein") print $0}' data/SampleGFF.gff | awk '{print $5-$4}' | head -2 |awk '{x+=$1}END{print x/NR}'
1810.5

```





