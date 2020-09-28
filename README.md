# rstudio-daki (Work in progress)

Building data analytics tools using [RStudio](https://www.rstudio.com/) for notebooks environment at csc. This repository contains many openshift templates 
borrowed from other [CSC Github repository](https://github.com/CSCfi/rstudio-openshift).

## Customise rstudio with necessary packages for DAKI:

Rstudio dockerfile for daki project includes latest version of R (v4.0.0) and rstudio along with the basic necessary R-packages. Many more R-packages to be included later. Current state of Dockerfile (*rstudio-daki.Dockerfile*) is available in 'daki' folder.

## Deploying rstudio-daki on Rahti via Command line:
Original openshift template (*rstudio-template.yaml*) was modified to include only rstudioa and renamed as *rstudio-daki-template.yaml*. Dockerfile for daki project was daki folder.  The following command can be used to to deploy rstudio-daki on Rahti server:

* *oc process -f rstudio-daki-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

## Deployment of daki rstudio on Notebooks
