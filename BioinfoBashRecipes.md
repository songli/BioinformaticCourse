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

```


```

### 3. How many reads mapped to how many places?

```
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
