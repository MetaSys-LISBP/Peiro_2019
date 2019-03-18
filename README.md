# Supplementary code - Peiro et al., 2019.

## Content

This R script performs genome-scale flux balance analysis and flux variability analysis of *Escherichia coli* K-12 
during aerobic growth on DHA, as detailed in the following publication:

Chemical and metabolic controls on dihydroxyacetone metabolism lead to a suboptimal growth of *E. coli*

Peiro et al., submitted

All calculations are performed using the *E. coli* genome scale metabolic model iJO1366 (Orth et al., 2011, DOI: 10.1038/msb.2011.65). 
This model can be found in Biomodels database (http://www.ebi.ac.uk/biomodels/ ; ID MODEL1108160000) and BiGG
database (http://bigg.ucsd.edu ; ID iJO1366). It is also provided in folder 'iJO1366' in three different formats (SBML, TSV, and 
modelorg object provided in an RData file)

Details on the calculations can be found in the code (DHA.R).

## Dependencies

Some R packages (lattice, glpkAPI, Matrix, sybil) are required. They can be installed
with the following command in an R console:

```bash
$ install.packages(c("lattice", "glpkAPI", "Matrix", "sybil"))
```

## Usage

To run flux calculations as detailed in the publication:

- go to the code directory, e.g.:

```bash
$ cd /home/usr/data/Peiro_2019/
```

- open an R session:

```bash
$ R
```

- run calculations:

```bash
$ source("DHA.R")
```

The code is open-source, and available under GPLv3 license.

## Authors
Pierre Millard, Stéphanie Heux

## Contact
:email: Pierre Millard, millard@insa-toulouse.fr
:email: Stéphanie Heux, heux@insa-toulouse.fr
