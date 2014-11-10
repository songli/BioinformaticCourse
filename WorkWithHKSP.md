# Working with HokieSpeed and other remote servers

## 1. First secure your data

```
$ cd ~/Research/Project1
$ cd rawdata
$ wget http://tinyurl.com/lathambio/SampleSam.sam
$ wget http://tinyurl.com/lathambio/SampleGFF.gff
$ wget http://tinyurl.com/lathambio/SampleFastq.fastq
$ wget http://tinyurl.com/lathambio/TAIR10.fas

$ ls -lh
```

You will see something like this:

```
total 20224
-rw-r--r--  1 song  staff   268K Nov  9 18:58 SampleFastq.fastq
-rw-r--r--  1 song  staff   7.1M Nov  9 18:58 SampleGFF.gff
-rw-r--r--  1 song  staff   2.5M Nov  9 18:58 SampleSam.sam
-rw-r--r--  1 song  staff    11K Nov  9 18:58 TAIR10.fas

```
Notice that the all the files are "rw-" for the user. **You want to keep your data safe from yourself !**.

```
$ chmod a-w *
$ ls -lh
$ head -200 SampleFastq.fastq > Test.fastq
```





