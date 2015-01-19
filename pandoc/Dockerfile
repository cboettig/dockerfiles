FROM haskell:latest
RUN cabal update \
	&& cabal install --prefix=/opt/cabal \
		pandoc \
		pandoc-citeproc \
  && chown -R root:staff /opt/cabal 
ENV PATH $PATH:/root/.cabal/bin


CMD ["pandoc"]
