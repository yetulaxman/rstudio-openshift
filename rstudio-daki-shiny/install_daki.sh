#!/bin/bash

set -e

# always set this for scripts but don't declare as ENV..
export DEBIAN_FRONTEND=noninteractive

apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    gdal-bin \
    lbzip2 \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libjq-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    lsb-release \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev \
    vim \
    nano \
    gawk \
    whois 

# lwgeom 0.2-2 and 0.2-3 have a regression which prevents install on ubuntu:bionic
## permissionless PAT for builds
UBUNTU_VERSION=${UBUNTU_VERSION:-`lsb_release -sc`}

if [ ${UBUNTU_VERSION} == "bionic" ]; then 
  R -e "Sys.setenv(GITHUB_PAT='0e7777db4b3bb48acb542b8912a989b8047f6351' \; remotes::install_github('r-spatial/lwgeom')"
fi


## Somehow foreign is messed up on CRAN between 2020-04-25 -- 2020-05-0?  
##install2.r --error --skipinstalled --repo https://mran.microsoft.com/snapshot/2020-04-24 foreign

install2.r --error --skipinstalled \
    gstat \
    hdf5r \
    lidR \
    spatstat \
    spatialreg \
    tidync \
    geoR \
    tidyverse\
    lubridate \
    scales \
    stringi \
    corrplot \
    RColorBrewer \
    openxlsx \
    readxl \
    randomForest \
    rpart \
    rpart.plot \
    raster \
    rgdal \
    sf \
    mapview \
    leaflet \
    leaflet.extras \
    sparklyr \
    iptools \
    Rwhois \
    jsonlite \
    httr \
    BiocManager \
    PROJ \
    sotkanet \
    jsonlite \
    pxweb \
    rjstat \
    devtools \
    remotes

R  -e "devtools::install_github('rOpenGov/vipunen')"
R  -e "devtools::install_github('rOpenGov/fmi2')"
R  -e "devtools::install_github('rOpenGov/hetu')"
R  -e "remotes::install_github('ropengov/statfi')"
R  -e "remotes::install_git('https://github.com/ropengov/digitransit')"
R  -e "remotes::install_github('ropengov/vipunen')"
R  -e "devtools::install_github('ropengov/sorvi')"
R  -e "devtools::install_github('ropengov/rqog')"
R  -e "devtools::install_github('ropengov/helsinki')"
R  -e "devtools::install_github('ropengov/openthl')"
R -e "remotes::install_github('ropengov/geofi')"

#R -e "BiocManager::install('GDAL')"
rm -r /tmp/downloaded_packages
