## Example Sun Grid Engine (SGE) High Performance Computing (HPC) job submission script

##the line below this must be the first line in your submission script generally
#$ -S /bin/bash

##how much time is needed for your calculations to run (default is the maximum, 48 hours) 
##the more time you request, the longer it will likely take for your analysis to get out of the queue and start running
#$ -l h_rt=48:00:0


##Number of GPUs you want (1 is the maximum) - if you request a GPU, your wait times will be longer to get out of the queue 
##but your analysis will run faster. Usually not needed for running an analysis
#$ -l gpu=0

##memory required
#$ -l mem=8G

##name of calculation (the name that will appear in the queue and in the record of runs)
#$ -N PCA_Test

##number of cores needed for calculation. Tip: use multiples of 16 as there are 16 cores per node,
##this makes it easier for the queue system to allocate you job to the resources. Double check how many cores per node there are for
##your system 
#$ -pe mpi 16

##this tells the computer where to run the calculation, cwd stands for current working directory
##meaning that the code will be run in the directory that the submisson script is submitted
#$ -cwd

##these are modules and dependencies that R uses to run calculations and will need to be found in your HPC documentation

module load r/recommended
 
##Run vmd

Rscript PCA_Script.R