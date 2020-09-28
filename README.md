# rstudio-daki (Work in progress)

Rstudio-daki is about building container-based data analytics tools using customised [RStudio](https://www.rstudio.com/) images in notebooks environment at CSC. This repository contains openshift templates 
borrowed from other [CSC Github repository](https://github.com/CSCfi/rstudio-openshift).

## Customise rstudio with necessary packages for DAKI

Rstudio dockerfile for daki project (rstudio-daki) includes latest version of R (v4.0.0) and rstudio along with basic necessary R-packages. Many more R-packages to be included later. Current state of Dockerfile (*rstudio-daki.Dockerfile*) is available in *daki* folder.

## Deploying rstudio-daki on Rahti *via* commandline
Original openshift template (*rstudio-template.yaml*) was modified to include only rstudio, excluding shiny part for now and is renamed as *rstudio-daki-template.yaml*. Corresponding customised Dockerfile for openshift deployment is available in *daki* folder.

The following openshift command can be used to deploy rstudio-daki  server on Rahti

* *oc process -f rstudio-daki-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

## Deployment of daki rstudio on Notebooks
