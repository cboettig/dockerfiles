FROM haskell:latest
RUN cabal update \
	&& cabal install \
		pandoc \
		pandoc-citeproc
ENV PATH $PATH:/root/.cabal/bin

CMD ["pandoc"]
