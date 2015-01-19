
# Run in parallel: make -j
FLAGS=--no-cache

pull:
	docker pull r-base
	docker pull rocker/r-base
	docker pull rocker/rstudio
	docker pull rocker/r-devel
	docker pull rocker/ropensci
	docker pull rocker/hadleyverse:latest
	docker pull cboettig/labnotebook
	docker pull cboettig/strata
	docker pull cboettig/nonparametric-bayes
	docker pull cboettig/pdg-control
	docker pull rocker/rstudio-daily:latest
	docker pull rocker/rstudio-daily:verse

all:
	$(MAKE) rocker 
	$(MAKE) post-rocker


rocker: 
	$(MAKE) r-base 
	$(MAKE) r-devel rstudio
	$(MAKE) hadleyverse

post-rocker: 
	$(MAKE) ropensci
	$(MAKE) strata
	$(MAKE) labnotebook


ropensci: ~/Documents/code/ropensci/docker/ropensci/Dockerfile
	docker build $(FLAGS) -t rocker/ropensci ~/Documents/code/ropensci/docker/ropensci/
ropensci-dev: ~/Documents/code/ropensci/docker/ropensci-dev/Dockerfile
	docker build $(FLAGS) -t rocker/ropensci:dev ~/Documents/code/ropensci/docker/ropensci-dev/

strata: ~/Documents/code/dockerfiles/strata/Dockerfile
	docker build $(FLAGS) -t cboettig/strata ~/Documents/code/dockerfiles/strata/

labnotebook: ~/Documents/lab-notebook/cboettig.github.io/_build/Dockerfile 
	docker build $(FLAGS) -t cboettig/labnotebook ~/Documents/lab-notebook/cboettig.github.io/_build/Dockerfile 


r-base: ~/Documents/code/rocker-org/rocker/r-base/Dockerfile
	docker build $(FLAGS) -t rocker/r-base ~/Documents/code/rocker-org/rocker/r-base
r-devel: ~/Documents/code/rocker-org/rocker/r-devel/Dockerfile
	docker build $(FLAGS) -t rocker/r-devel ~/Documents/code/rocker-org/rocker/r-devel
rstudio: ~/Documents/code/rocker-org/rocker/rstudio/Dockerfile
	docker build $(FLAGS) -t rocker/rstudio ~/Documents/code/rocker-org/rocker/rstudio
hadleyverse: ~/Documents/code/rocker-org/hadleyverse/Dockerfile
	docker build $(FLAGS) -t rocker/hadleyverse ~/Documents/code/rocker-org/hadleyverse


