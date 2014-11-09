# BASH scripting for bioinformatics

## 1. Hello World!

### 1.1 your first bash script.

```
$ cd ~/Research/Project1/scripts
$ touch HelloWorld.sh
$ nano HelloWorld.sh
```
within nano, enter the content your HelloWorld.sh

```
#!/bin/bash
echo Hello World
```
save the file:
* ctrl+o
* enter
* ctrl+x

There is one more thing.

```
$ chmod +x HelloWorld.sh
$ ./HelloWorld.sh
Hello World
```

### 1.2 introducing variables.

```
$ cd ~/Research/Project1/scripts
$ touch HelloWorld.1.sh
$ nano HelloWorld.1.sh
```

within nano, enter the following
```
#!/bin/bash    
echo "Hello" $1  
hello="Hello World!"
echo $hello
```

Make HelloWorld.1.sh executable and run it.

```
$ ./HelloWorld.1.sh yourname
Hello yourname
Hello World!

```
$1 is the first command line variable
$hello is a variable defined in the script


## 2. Automatic creation of your project library.

let's do it again, create your working directory.
```
cd ~/Research
touch makeProj.sh
nano makeProj.sh
```

edit the content of the makeProj.sh
```
#!/bin/bash 

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Usage: makeProj.sh [project name]"
    exit 1
fi

cd ~/Research
ProjDir=Project_$1
mkdir $ProjDir
cd $ProjDir
mkdir data
mkdir rawdata
mkdir scripts
mkdir results
mkdir documents
mkdir figures
```

make the shell script executable and run it
```
chmod +x makeProj.sh
./makeProj.sh NewPj
ls
```

## 3. BASH Util: grep

## 4. BASH Util: sort and uniq

## 5. BASH Util: sed

## 6. BASH Util: awk

