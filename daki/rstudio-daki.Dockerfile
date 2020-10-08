# modified dockerfile from rocker-version2 of Rocker Project
FROM rocker/r-ver:4.0.0

ENV S6_VERSION=v1.21.7.0
ENV RSTUDIO_VERSION=latest
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

# add this for working with notebooks
COPY userconf.sh /rocker_scripts/
COPY install_daki.sh /rocker_scripts/
COPY autodownload_and_configure.sh /etc/cont-init.d/zzz-autodownload-and-configure.sh

RUN /rocker_scripts/install_daki.sh
RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh

VOLUME /scripts
COPY open-data-examples /scripts/

EXPOSE 8787

CMD ["/init"]
