 pkgs_to_install <- c("ggplot2", "openxlsx", "tidyr", "reshape2", "dplyr", "tibble", "ggrepel", "Matrix", "igraph", "Rtsne", "plotly", "htmlwidgets", "RCircos", "heatmaply", "circlize", "RColorBrewer", "Hmisc","devtools")


# don't reinstall anything that's installed already
pkgs_to_install <- setdiff(pkgs_to_install, rownames(installed.packages()))

## Start the actual installation:
ok <- BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE) %in% rownames(installed.packages())
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

BiocManager::install("DEP")
library(devtools)
install_github("bartongroup/Proteus")
#suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))
