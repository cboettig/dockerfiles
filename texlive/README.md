Basic use
----------

Link to the current working directory in order to run latex commands on files therein.
Specify the desired tex commands following the container name, for instance:

```
docker run -v $(pwd):/data -i --rm cboettig/texlive pdflatex foo.tex
```

Linking
------

Run the docker container providing the texlive binaries
as linked volume.  Note that even after the `texlive` container
has been downloaded that this is slow to execute due to the volume
linking flag (not really sure why that is). 

``` 
docker run --name tex -v /usr/local/texlive cboettig/texlive
```

Once the above task is complete, we can run other containers that
may want to make use of a LaTeX environment by linking, such 
as `rocker/rstudio` or `cboettig/pandoc` containers:

```
docker run --rm -i --volumes-from tex \
 -e PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux/ \
 cboettig/pandoc foo.md -o output.pdf
```


```
docker run -dP --volumes-from tex \
 -e PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux/ \
 rocker/rstudio
```

We can now log into RStudio, create a new Rnw file and presto, RStudio
discovers the tex compilers and builds us a pdf.  This does make our
Docker execution lines a bit long, but that's what [fig](www.fig.sh)
is for.  (Or a good ole Makefile).
