FROM ubuntu:trusty

RUN apt-get update && apt-get install -y --no-install-recommends haskell-platform cabal-install
RUN cabal update
RUN cabal install Cabal

ENV SRC_DIR /usr/share/src

ADD . ${SRC_DIR}
WORKDIR ${SRC_DIR}

RUN cabal install --only-dependencies
RUN cabal install --global

CMD ["/usr/local/bin/autentifica"]

