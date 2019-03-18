# 2019-03-15 millard@insa-toulouse.fr, heux@insa-toulouse.fr
#
# Genome-scale analysis of DHA metabolism in Escherichia coli K-12
#
# This script is provided as supplementary information of Peiro et al. (2019).
#
# Some R packages (lattice, glpkAPI, Matrix, sybil) are required. They can be installed
# with the following command in an R console:
#
#     install.packages(c("lattice", "glpkAPI", "Matrix", "sybil"))
#
# Copyright 2019, INRA, France
# License: GNU General Public License v3


############################
### INITIALIZE R SESSION ###
############################

# Clean the session
rm(list=ls(all=TRUE))

# Load required libraries
library(lattice)
library(glpkAPI)
library(Matrix)
library(sybil)
#library(sybilSBML)

# Go to working directory
#setwd("D:/GIT/Peiro_2019/Peiro_2019")
setwd(file.path(getwd(), "iJO1366"))


##########################################
### LOAD THE MODEL AND SET CONSTRAINTS ###
##########################################

# Load E. coli genome scale metabolic model iJO1366 (Orth et al., 2011, DOI: 10.1038/msb.2011.65)
#
# This model can be found in Biomodels database (http://www.ebi.ac.uk/biomodels/ ; ID MODEL1108160000) and BiGG
# database (http://bigg.ucsd.edu ; ID iJO1366). It is also provided in folder 'iJO1366' in three different formats
# that can be loaded as follow:
#
#   # read SBML model (requires library sybilSBML, which has been removed from CRAN but is still available on GitHub):
#       model_ecoli <- readSBMLmod("iJO1366.xml")
#
#   # load modelorg object from an RData file:
#       load(file="iJO1366.RData")
#
#   # read TSV model (see sybil documentation for details):
model_ecoli <- readTSVmod(prefix = "iJO1366", quoteChar = "\"")

# Constrain uptake fluxes (DHA, formate, acetate and glycolate) to experimental values (in mmol/gDW/h, as detailed in Peiro et al., 2019)
model_ecoli <- changeBounds(model_ecoli,
                            c("EX_dha(e)", "EX_glc(e)", "EX_for(e)", "EX_glyclt(e)", "EX_ac(e)"),
                            lb = c(-5.2, 0, -3.21, -1.02, -0.07),
                            ub = c(-5.2, 0, -3.21, -1.02, -0.07))


######################
### MODEL ANALYSIS ###
######################

# List of reactions of interest (as shown in Figure 2 in Peiro et al., 2019)
react <- c("DHAtex", "Ec_biomass_iJO1366_core_53p95M","DHAPT","GLYCDx", "GLYK", "G3PD5","G3PD2","F6PA" ,"PFK","FBA","TPI","GAPD")

# Get optimal flux distribution and perform flux variability analysis
fba <- optimizeProb(model_ecoli, algorithm = "mtf")
fba_flx <- getFluxDist(fba, react=checkReactId(model_ecoli, react)@react_pos)

# Perform flux variability analysis (with growth > 95% of optimal growth rate)
fva <- fluxVar(model = model_ecoli, react = react, percentage = 95, verboseMode = 0)
fva_flx <- mod_obj(fva)

# Gather results
res_abs <- matrix(c(fva_flx, fba_flx), ncol=3, nrow=length(react), dimnames=list(reaction=react, flux=c("min", "max", "opt")))
res_rel <- res_abs/5.2

# Display intracellular fluxes (min, max, opt) relative to DHA uptake
print(res_rel)




