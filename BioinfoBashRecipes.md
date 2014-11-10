# Bash programming for bioinformatics

Make sure you have your data in the directory.
```
cd ~/Research
ls data
```

### 1. How many genes/chromsomes/contigs are in my fasta file?

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


### How many reads in a fastq file?

```
```

### How many reads mapped to how many places?

```
```

### How many rows in gtf file are protein coding genes?

```
```

### How many reads are mapped from head to tail?

```
```

### Why my bam file is not showing up in IGV?

```
```
