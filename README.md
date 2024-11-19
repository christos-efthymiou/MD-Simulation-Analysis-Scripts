# MD Simulation Analysis Scripts

This repository offers a collection of scripts designed to facilitate the analysis of Molecular Dynamics (MD) simulations using [Visual Molecular Dynamics (VMD)](https://www.ks.uiuc.edu/Research/vmd/) and [R](https://www.r-project.org/). These tools assist in calculating various properties such as Root Mean Square Deviation (RMSD), Root Mean Square Fluctuation (RMSF), salt bridges, hydrogen bonds, and solvent accessible surface area (SASA).

## Repository Contents

- **`vmd_analysis.tcl`**: A Tcl script for VMD to compute multiple characteristics of MD simulations, including RMSD, RMSF, salt bridges, etc.
- **`center_of_mass.tcl`**: Calculates the center of mass for specified groups of atoms.
- **`gyr_radius.tcl`**: Computes the radius of gyration for selected atom groups.
- **`hpc_submission_script`**: A sample job submission script tailored for High Performance Computing (HPC) environments using Sun Grid Engine.
- **`PCA_script.r`**: An R script to perform principal component analysis (PCA) on a trajectory and output the results to a CSV file. 

## Prerequisites

- **VMD**: Ensure that [VMD](https://www.ks.uiuc.edu/Research/vmd/) is installed on your system.
- **R**: For scripts utilizing R, install [R](https://www.r-project.org/) and the necessary packages.

## Usage

### Local Analysis

1. **Prepare Your Files**: Place your Protein Structure File (PSF) and DCD trajectory files in a designated directory, along with the `center_of_mass.tcl`, `gyr_radius.tcl`, and `vmd_analysis.tcl` files.
2. **Edit the Script**: Open `vmd_analysis.tcl` and modify the fifth and sixth lines to specify the names of your PSF and DCD files.
3. **Run VMD**:
   - Launch VMD.
   - Open the Tk Console within VMD.
   - Navigate to the directory with all the required files using the command:
     ```tcl
     cd /path/to/your/directory
     ```
   - Source the analysis script:
     ```tcl
     source vmd_analysis.tcl
     ```
4. **Output**: The script will execute the analyses and generate `.dat` files containing the results for each calculated property. These can be opened in Excel or OriginPro for plotting.

### HPC or Supercomputer Analysis

1. **Transfer Files**: Upload your PSF, DCD, `vmd_analysis.tcl`, `center_of_mass.tcl`, `gyr_radius.tcl`, and `hpc_submission_script` to a directory on the HPC system.
2. **Edit the Analysis Script**: Modify the fifth and sixth lines of `vmd_analysis.tcl` to match your PSF and DCD filenames.
3. **Edit the Submission Script**: Adjust `hpc_submission_script` to set the job name, number of cores, and other parameters as required.
4. **Load VMD Module**: Follow your HPC's documentation to load the VMD module. This typically involves a command such as:
   ```bash
   module load vmd
   ```
5. **Submit the job**: Use the following command to submit the job:
   ```bash
   qsub hpc_submission_script
   ```
6. **Output**: Upon completion, the analysis results will be available in the specified output directory.

### PCA Analysis in R 
Follow the same steps as above, but use the `PCA_Script.r` and `R_hpc_submission_script.sh` files instead. PCA will be performed on the trajectory and a CSV file will contain the results of the analysis which can then be plotted in Excel or OriginPro. 

## Notes 
- Ensure that all file paths and filenames are correctly specified in the scripts.
- Review and modify the scripts as needed to align with your specific simulation parameters and analysis requirements.
- For detailed information on VMD scripting and capabilities, refer to the VMD User's Guide.

## Acknowledgements
These scripts were developed using information and tutorials available online. Contributions and improvements are welcome.

For any questions or suggestions, please feel free to open an issue or submit a pull request.