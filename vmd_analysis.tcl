#load the PSF file that was used for your simulation
mol new Positive_Control.psf type psf

#load the DCD file that you want to analyze - step value determines which frames to take from the simulation 
#a step value of 2 is the default, which means every other frame will be loaded 
mol addfile MD.dcd type dcd first 0 last -1 step 2 waitfor all

#RMSD calculation 

# wrap the trajectory to avoid RMSD calculation errors
pbc wrap -center com -centersel "protein" -compound residue -all

# Align to first frame or the frame you want to compare the rest of the frames to
set reference [atomselect top "protein and backbone" frame 0]
		
# the frame to be compared
set compare [atomselect top "protein and backbone"]

#get the number of frames of the trajectory 
set num_steps [molinfo top get numframes]

# get the correct num as the trajectory start from zero
set outfile [open rmsd.dat w]

for {set frame 0} {$frame < $num_steps} {incr frame} {
		# get the correct frame
		$compare frame $frame
		# compute the 4*4 matrix transformation that takes one set of coordinates onto the other 
		set trans_mat [measure fit $compare $reference]
		
		# do the alignment
		$compare move $trans_mat
		# compute the RMSD
		set rmsd [measure rmsd $compare $reference ]
		# print the RMSD
   puts $outfile "$frame    $rmsd"
}
close $outfile

# RMSF calculation

set num [expr {$num_steps - 1}]

set outfile [open rmsf.dat w]
set sel [atomselect top " protein and name CA"]
set rmsf [measure rmsf $sel first 0 last $num step 1]
for {set i 0} {$i < [$sel num]} {incr i} {
  puts $outfile "[expr {$i+1}] [lindex $rmsf $i]"
} 
close $outfile

# Salt bridges

#create folder to store all of the saltbridge calculation files 
file mkdir saltbridges
package require saltbr

#calculate the saltbridges
saltbr -sel [atomselect top protein] -log saltbridges.log -outdir ./saltbridges

#####Options for salt bridge:

# -upsel <yes|no> (update atom selections every frame? default: yes)
# -frames <begin:end> or <begin:step:end> or all or now (default: all)
# -ondist <cutoff distance between oxygen and nitrogen atoms> (default: 3.2)
# -comdist <cutoff distance between centers of mass of side chains> (default: none)
# -writefiles <yes|no> (default: yes)
#- outdir <output directory> (default: current)
# -log <log filename> (default: none)

# Radius of Gyration calculation
# first the following tcl functions must be loaded (Ref : http://www.ks.uiuc.edu/Research/vmd/vmd-1.7.1/ug/node182.html )
source ./gyr_radius.tcl
source ./center_of_mass.tcl

#name the output file
set outfile [open rgyr.dat w]
puts $outfile "i rad_of_gyr"
set nf [molinfo top get numframes] 
set i 0

#choose what you want to calculate the radius of gyration for, here it is for the protein
set prot [atomselect top "protein"] 
while {$i < $nf} {

    $prot frame $i
    $prot update

    set i [expr {$i + 1}]
    set rog [gyr_radius $prot]

    puts $outfile "$i $rog"

} 

close $outfile