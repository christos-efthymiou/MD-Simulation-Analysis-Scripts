#load the PSF file that was used for your simulation
mol new SCR20_K1230R_Neg_Control_100ns_Test3_QwikMD.psf type psf

#load the DCD file that you want to analyze - step value determines which frames to take from the simulation 
#a step value of 2 is the default, which means every other frame will be loaded 
mol addfile MD.dcd type dcd first 0 last -1 step 2 waitfor all