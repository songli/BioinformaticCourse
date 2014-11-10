# Working with HokieSpeed and other remote servers

## 1. Secure your data first

### 1.1 get data to raw data directory
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

Now try to remove one of the files:
```
bioinfo@bioinfo-VirtualBox:~/Research/Project1/rawdata$ rm SampleFastq.fastq 
rm: remove write-protected regular file ‘SampleFastq.fastq’? n
```

But you can remove the newly created Test.fastq file.

### 1.2 make symbolic links to your data

```
$ cd ../data
$ ln -s ../rawdata/SampleFastq.fastq
$ ln -s ../rawdata/SampleGFF.gff
$ ln -s ../rawdata/SampleSAM.sam
$ ln -s ../rawdata/TAIR10.fas
$ ls -l
```
* Don't use more space
* Same file can be accessed at multiple places
* Prevent human error

## 2. Get your data/folders to HokieSpeed

### 2.1 Make sure you are ready.
```
$ echo $HKP1
```

### 2.2 Open two or more terminals. 
press Ctrl + Shift + t will open one more terminal. 
```
ssh $HKSP1
```

### 2.3 There's more than one way to do it.

#### 2.3.1 SCP
```
$ scp makeProj.sh $HKSP1:~/
```
in another window, check that makeProj.sh is already in your home directory.

#### 2.3.2 SFTP
```
songli@hokiespeed1.arc.vt.edu's password: 
Connected to hokiespeed1.arc.vt.edu.
sftp> put makeProj.sh 
Uploading makeProj.sh to /home/songli/makeProj.sh
makeProj.sh                                   100%  177     0.2KB/s   00:00    
sftp> 
```
again, check in another window.

#### 2.3.3 rsync **Highly Recommended**
```
$ cd Research
$ rsync -ravz Project1 $HKSP1:~/Research/
songli@hokiespeed1.arc.vt.edu's password: 

sending incremental file list
Project1/
Project1/.test
Project1/data/
Project1/data/SampleGFF.gff
Project1/data/SampleSam.sam
Project1/rawdata/
Project1/rawdata/SampleFastq.fastq
Project1/rawdata/SampleGFF.gff
Project1/rawdata/SampleSam.sam
Project1/rawdata/TAIR10.fas
Project1/rawdata/Test.fastq

sent 2,782,536 bytes  received 195 bytes  505,951.09 bytes/sec
total size is 20,465,345  speedup is 7.35
```
The options for rsync:
* r: recursive, this makes the command copy all the sub folders
* a: archive mode, symbolic links copied by this method will not create new files
* v: verbose, make many text on the screen
* z: zip the file so it save transmit bandwidth and time


## 3. Running jobs on HokieSpeed

Introducing Advanced Research Computing [see](http://www.arc.vt.edu/)

The HPC model: 
* you login to head node, copy your data and script over.
* you submit your job request by a shell [script] (http://www.arc.vt.edu/resources/hpc/docs/hokiespeed_qsub_example.sh).
* a schedular will allocate appropriate resource for your job.
* the job will run in one or more compute nodes.

```
# Example script for simpleqsub.sh

#!/bin/bash

# Example qsub script for HokieSpeed

#PBS -W group_list=hokiespeed
#PBS -l walltime=01:00:00
#PBS -l nodes=1:ppn=1
#PBS -q normal_q
#PBS -A hokiespeed

module purge
module load gcc openmpi cuda
module add R python

# Change to the directory from which the job was submitted
cd ~/Research/

# Say "Hello world!"
echo "Hello world!"

# Run the program
./makeProj.sh pj1
sleep 30
./makeProj.sh pj2
sleep 30
./makeProj.sh pj3

echo "Done!"

exit;
```

Submit your job

```
[songli@hslogin1 Research]$ qsub simpleqsub.sh
50871.master.cluster
```

Check your job status

```
$ qstat

Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
50870.master               simpleqsub.sh    songli                 0 Q normal_q

```

When your job will run depends on the availability of the computing resources.

```
$ qstat

Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
50871.master               simpleqsub.sh    songli                 0 R normal_q
```

Check your results
```
$ ls -l
```

