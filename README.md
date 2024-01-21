# MD-Simulation-Analysis-Scripts
 This repository contains scripts that can be used to analyze MD simulations in VMD and R.

 ## If you are running analysis on your local computer
 The vmd_analysis.tcl file contains code to calculate several characteristics of an MD simulation ran in NAMD including RMSD, RMSF, salt bridges, etc. In order to use this script, open the VMD desktop app and navigate to the Tk console. Once in the console, go to the folder containing your PSF and DCD files using cd /path/to/folder. Next, edit the second and fourth lines of the script to match the names of your PSF and DCD files. Once you are in the directory containing your files in the Tk console, you can use the command source vmd_analysis.tcl to run the script. This will run through the entire script, automatically calculating several characteristics and creating separate .dat (text) files containing the results of each analysis.  

 ## If you are running analysis on a High Performance Computer (HPC) or Supercomputer
 When running scripts on a supercomputer, it is necessary to submit a job submission script in the appropriate format, telling the HPC what you would like it to do. 