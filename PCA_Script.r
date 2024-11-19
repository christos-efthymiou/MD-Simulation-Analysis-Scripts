# Load the required libraries
library(bio3d)

# Set the file paths
dcd <- "all_combined.dcd"
pdb <- "backbone.pdb"

# Read the trajectory and reference structure
traj <- read.dcd(dcd)
ref <- read.pdb(pdb)

# Select CA atoms
ca.inds <- atom.select(ref, string = "calpha")

# Superpose trajectory onto the reference structure
xyz <- fit.xyz(fixed = ref$xyz, mobile = traj, fixed.inds = ca.inds$xyz, mobile.inds = ca.inds$xyz)

# Perform PCA analysis
pc <- pca.xyz(xyz[, ca.inds$xyz])
print(pc)
plot(pc, col=bwr.colors(nrow(xyz)) )
write.csv(pc$z[,1:3], file="pca_results.csv", quote=FALSE)

# Extract PCA coordinates for a specific range (e.g., residues 100 to 150)
#residues_range <- 100:150
#pca_coords <- pc$au[residues_range, 3]

# Find residues with identical PCA coordinates
#residues_with_identical_coords <- residues_range[duplicated(pca_coords)]

# Plot the trajectory coordinates for the identified residues
#par(mfrow = c(1, 1))  # Reset the plot layout

#for (residue_index in residues_with_identical_coords) {
#  coordinates <- traj[, ca.inds$xyz[atom2xyz(residue_index)]]
#  plot(coordinates, type = "l", main = paste("Residue", residue_index), xlab = "Frame", ylab = "Coordinate")
#}

#traj[, ca.inds$xyz[atom2xyz(residues_with_identical_coords[1])]]

hc <- hclust(dist(pc$z[,1:2]))
grps <- cutree(hc, k=2)
plot(pc, col=grps)

plot.bio3d(pc$au[,1], ylab="PC1 (A)", xlab="Residue Position", typ="l")
points(pc$au[,2], typ="l", col="blue")

p1 <- mktrj.pca(pc, pc=1, b=pc$au[,1], file="pc1.pdb")
p2 <- mktrj.pca(pc, pc=2,b=pc$au[,2], file="pc2.pdb")
