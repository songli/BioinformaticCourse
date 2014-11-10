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
