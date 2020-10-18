# rstudio-openshift applications (Work in progress)

Rstudio-openshift applications facilitate running container-based data analytics tools in CSC's [Rahti container cloud](https://rahti.csc.fi/) and [notebooks environment](https://notebooks.csc.fi/). This repository contains openshift templates borrowed from other [CSC Github repository](https://github.com/CSCfi/rstudio-openshift). Rstudio custom images can be tailored depending on the requirement and are built using docker container environment.

Rstudio applications currently include:
- [rstudio for DAKI project](#rstudio-for-DAKI-project)
- [rstudio for training environment](#rstudio-for-training-environment) 

Once rstudio is image compatible for deploying in openshift environment, you can then deploy in Notebooks environment. Please follow the intrsuctions for [deploying rstudio images onto notebooks environment](deploying-rstudio-images-onto-notebooks-environment)

# rstudio for DAKI project

Rstudio docker image for DAKI project (rstudio-daki) includes the latest version of R (v4.0.0), rstudio and required R-packages to help various data analysis activities in the broad scope of DAKI project. Current state of Dockerfile is available in *daki* folder. In addition ".dockerfile" is also included to generate a docker image that can be deployed on cPouta application where users usually have previlized access rights. The image thus generated however may not be compatible either openshift or notebooks enviroment.

### Deploying rstudio-daki on Rahti *via* commandline
Original openshift template (i.e., *rstudio-template.yaml*) was modified to exclude shiny part and is renamed as *rstudio-daki-template.yaml*. The customised Dockerfile for openshift deployment (named as *Dockerfile*) is available in *daki* folder.

The following openshift command can be used to deploy rstudio-daki server on Rahti

* *oc process -f rstudio-daki-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

In case you want to include shiny part as well, please use the following openshift command:

* *oc process -f rstudio-daki-shiny-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

# rstudio for training environment 
Rstudio dockerfile for basic data analyis course (rstudio-rda) includes latest version of rstudio, R (v4.0.2) and basic R-packages. Current state of Dockerfile (*rstudio-rda.Dockerfile*) is available in *rda* folder.

## Deploying rstudio-rda on Rahti *via* commandline
Please use  *rstudio-rda-template.yaml* template which will use *Dockerfile* available in *rda* folder for deployment on Rahti.

The following openshift command can be used to deploy rstudio-rda server on Rahti

* *oc process -f rstudio-rda-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

# Deploying rstudio images onto notebooks environment




## Funding

<img src="./Logos.png" width="80%">


