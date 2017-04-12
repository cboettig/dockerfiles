FROM cboettig/labnotebook:3.3.1 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN apt-get update && apt-get -y install -t unstable r-cran-rjags librsvg2-dev \
  && install2.r --error \
     -r "http://www.bioconductor.org/packages/release/bioc" \
     -r "http://cran.rstudio.com" \
     FKF \
     dlm \
     KFAS \
     mcmc \
     MDPtoolbox \
     igraph \
     sde \
     FastGP \
     rbenchmark \
     PVAClone \
     triangle \
     bbmle \
     nlstools \
     drc \
     RNeXML \
     geiger \
     phytools \
  && installGithub.r \
    yihui/servr \ 
    cboettig/earlywarning \
    cboettig/pdg_control \
    cboettig/multiple_uncertainty \
    cboettig/knitcitations \
    cboettig/regimeshifts  \
    ropensci/rgpdd \
    cboettig/nonparametric-bayes \
    cboettig/pmc \
    rich-iannone/DiagrammeR \
    nimble-dev/nimble/packages/nimble@stable \
    cboettig/gpmanagement \
    ropensci/rfishbase \
    cloudyr/aws.signature \
    cloudyr/aws.s3 \
    ropensci/RNeXML \
    richfitz/drat.builder \
    ropensci/ropkgs \
    cboettig/Sxslt \
    ropensci/EML \
  && install2.r --repo http://packages.ropensci.org --error \
    rrdf \
  && rm -rf /tmp/downloaded_packages

# break cache first
COPY Dockerfile /tmp/Dockerfile
RUN rm -rf /data && git clone https://github.com/cboettig/2015 /data

