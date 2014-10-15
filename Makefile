
# Run in parallel: make -j
FLAGS=--no-cache

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


ropensci: ~/Documents/code/ropensci/docker/ropensci/Dockerfile
	docker build $(FLAGS) -t cboettig/ropensci ~/Documents/code/ropensci/docker/ropensci/
ropensci-dev: ~/Documents/code/ropensci/docker/ropensci-dev/Dockerfile
	docker build $(FLAGS) -t cboettig/ropensci:dev ~/Documents/code/ropensci/docker/ropensci-dev/

strata: ~/Documents/code/dockerfiles/strata/Dockerfile ~/Documents/code/ropensci/docker/ropensci/Dockerfile
	docker build $(FLAGS) -t strata ~/Documents/code/dockerfiles/strata/


r-base: ~/Documents/code/rocker/debian/r-base/Dockerfile
	docker build $(FLAGS) -t rocker/r-base ~/Documents/code/rocker/debian/r-base
r-devel: ~/Documents/code/rocker/debian/r-devel/Dockerfile
	docker build $(FLAGS) -t rocker/r-devel ~/Documents/code/rocker/debian/r-devel
rstudio: ~/Documents/code/rocker/debian/rstudio/Dockerfile
	docker build $(FLAGS) -t rocker/rstudio ~/Documents/code/rocker/debian/rstudio
hadleyverse: ~/Documents/code/rocker/debian/hadleyverse/Dockerfile
	docker build $(FLAGS) -t rocker/hadleyverse ~/Documents/code/rocker/debian/hadleyverse










ubuntu-r-base: ~/Documents/code/rocker/ubuntu/r-base/Dockerfile
	docker build $(FLAGS) -t eddelbuettel/ubuntu-r-base ~/Documents/code/rocker/ubuntu/r-base
ubuntu-r-devel: ~/Documents/code/rocker/ubuntu/r-devel/Dockerfile
	docker build $(FLAGS) -t eddelbuettel/ubuntu-r-devel ~/Documents/code/rocker/ubuntu/r-devel
ubuntu-rstudio: ~/Documents/code/rocker/ubuntu/rstudio/Dockerfile
	docker build $(FLAGS) -t eddelbuettel/ubuntu-rstudio ~/Documents/code/rocker/ubuntu/rstudio
ubuntu-hadleyverse: ~/Documents/code/rocker/ubuntu/hadleyverse/Dockerfile
	docker build $(FLAGS) -t eddelbuettel/ubuntu-hadleyverse ~/Documents/code/rocker/ubuntu/hadleyverse


pull:
	docker pull rocker/r-base
	docker pull rocker/r-devel
	docker pull rocker/rstudio
	docker pull rocker/hadleyverse
	docker pull rocker/ropensci


# delete: docker rmi eddelbuettel/debian-r-base eddelbuettel/ubuntu-r-base eddelbuettel/debian-r-devel eddelbuettel/debian-rstudio eddelbuettel/ubuntu-r-devel eddelbuettel/ubuntu-rstudio eddelbuettel/debian-hadleyverse eddelbuettel/ubuntu-hadleyverse

clean:
	docker rm `docker ps -a -q`
	docker rmi `docker images -q --filter "dangling=true"`
