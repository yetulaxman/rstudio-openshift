# Rstudio-openshift applications (Work in progress)

Rstudio-openshift applications in this repository facilitate running containerised data analytics tools of Rstudio in CSC's [Rahti container cloud](https://rahti.csc.fi/) and [notebooks environment](https://notebooks.csc.fi/). This repository extends openshift templates developed in one of other [CSC Github repositories](https://github.com/CSCfi/rstudio-openshift) to build customised Rstudio applications. Custom images here are built in docker environment and can be tailored depending on your requirements. Our effort towards containerised Rstudio custom images here currently include:
- [Rstudio for DAKI project](#Rstudio-for-DAKI-project)
- [Rstudio for training environment](#Rstudio-for-training-environment) 

Once rstudio image is compatible for deploying in openshift environment, you can then use it to deploy in notebooks environment. One way to check it whether your custom images is compatible with openshift environment is to deploy the image in Rahti container cloud at CSC. Please follow the instructions for [deploying a pre-made rstudio image onto notebooks environment](#Deployment-of-rstudio-images-onto-notebooks-environment)

# Rstudio for DAKI project

Rstudio docker container for DAKI project (rstudio-daki) includes the latest version of R (v4.0.0), rstudio and required R-packages to help with various data analysis activities in the broad scope of DAKI project. Customised Dockerfile (file name: Dockerfile) which is meant for deploying on Rahti and eventually on notebooks environment is available in *daki-shiny* folder. 

In addition to opehshift Dockerfile mentioned above, other "*.dockerfile" is also included to generate a docker image that can be deployed on cPouta environment where users usually have previlized access rights. The image thus generated however may not be compatible either in openshift or notebooks enviroment.

### Deployment of rstudio-daki on Rahti *via* commandline
Original openshift template (i.e., *rstudio-template.yaml*) was renamed as *rstudio-daki-shiny-template.yaml* to deploy rstudio-daki on Rahti container cloud. 

Please use the following openshift command to deploy rstudio-daki server on Rahti:

* *oc process -f rstudio-daki-shiny-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*

# Rstudio for training environment 
Rstudio dockerfile for basic data analyis course (rstudio-rda) includes the latest version of rstudio, R (v4.0.2) and basic R-packages. Dockerfile (*rstudio-rda.dockerfile*) for building the custom image is available in *rda* folder.

## Deploying rstudio-rda on Rahti *via* commandline
Please use  *rstudio-shiny-template.yaml* template which will use *Dockerfile* available in *rda* folder for deployment on Rahti.

The following openshift command can be used to deploy rstudio-rda server on Rahti

* *oc process -f rstudio-shiny-template.yaml -p NAME="application-name" -p USERNAME="your-username" -p PASSWORD="your-password" | oc apply -f -*


# Deployment of Rstudio image onto notebooks environment

### Login to CSC Notebooks to set up a group

First, navigate to [CSC Notebooks](https://notebooks.csc.fi) service using your HAKA authentication. The landing page after logging in shows a dashboard with a list of Blueprints which are ready for lanching a notebook of your choice. However, if you do want a custom notebook for your rstudio, please request CSC for administrator rights (or [group ownership rights](http://cscfi.github.io/pebbles/group_owners_guide.html)) using CSC Notebooks. Once you have admin rights, you can see **Groups** and **Blueprints** in the menu on the top of the page. Click on the **Groups** tab and the  **Create a New Group** tab to create a group for your notebook

### Create a new Blueprint for your rstudio application

Click on the **Blueprints** tab in the top menu to access various *Templates* for creating a Blueprint. Choose *Rahti RStudio* and click **Create Blueprint**. The template is shown in the picture for the clarity. Select the group created in the *Select Group* menu. Add name and description for your Blueprint. In order to fill **openshift template url** field, please use imageready openshift templates (*-imageready.yaml file) available in this GitHub repository. Please note that you have to change URLs for your custom in imageready openshift templates before using them in creating **Blueprints** for notebooks

<img src="./Notebooks-deploy.png" width="50%">

# Usefull links
- [Apply for a new CSC project](https://my.csc.fi/)
- [Rahti container cloud](https://rahti.csc.fi/) 
- [notebooks environment](https://notebooks.csc.fi/)
- [Rahti Docker registry](https://registry-console.rahti.csc.fi/)
- [Request a new course](https://www.webropolsurveys.com/S/84118B6BD6E97501.par) on CSC notebooks

# Funding

<img src="./Logos.png" width="80%">


