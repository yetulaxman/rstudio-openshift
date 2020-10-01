# rstudio-openshift applications (Work in progress)

Rstudio-openshift applications is about building container-based data analytics tools by deploying mainly customised [RStudio](https://www.rstudio.com/) images in openshift and eventually make the applications available in notebooks environment at CSC. This repository contains openshift templates borrowed from other [CSC Github repository](https://github.com/CSCfi/rstudio-openshift).

Currently these efforts include:
- [rstudio for daki project](#rstudio-for-daki-project)
- [rstudio for basic data analysis course](#rstudio-for-basic-data-analysis-course) 

# rstudio for daki project

Rstudio dockerfile for daki project (rstudio-daki) includes latest version of R (v4.0.0) and rstudio along with the necessary R-packages. Many more R-packages to be included later. Current state of Dockerfile (*rstudio-daki.Dockerfile*) is available in *daki* folder.

### Deploying rstudio-daki on Rahti *via* commandline
Original openshift template (*rstudio-template.yaml*) was modified to include only rstudio, excluding shiny part for now and is renamed as *rstudio-daki-template.yaml*. Corresponding customised Dockerfile for openshift deployment (named as *Dockerfile*) is available in *daki* folder.

The following openshift command can be used to deploy rstudio-daki server on Rahti

* *oc process -f rstudio-daki-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

### Deployment of daki rstudio on Notebooks
...

# rstudio for basic data analysis course 
Rstudio dockerfile for basic data analyis course (rstudio-rda) includes latest version of rstudio, R (v4.0.2) and basic R-packages. Current state of Dockerfile (*rstudio-rda.Dockerfile*) is available in *rda* folder.

## Deploying rstudio-rda on Rahti *via* commandline
Please use  *rstudio-rda-template.yaml* template which will use *Dockerfile* available in *rda* folder for deployment on Rahti.

The following openshift command can be used to deploy rstudio-rda server on Rahti

* *oc process -f rstudio-rda-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

### Deployment of rstudio-rda on Notebooks
...



## Funding:

<img src="./Logos.png" width="80%">


