FROM ubuntu:22.04 AS build
ARG VERSION=
WORKDIR /src
RUN apt-get update && \
    apt-get -y install build-essential automake autoconf libtool flex bison libboost-all-dev wget && \
    apt-get clean

RUN wget https://github.com/rcsoccersim/rcssserver/archive/rcssserver-$VERSION.tar.gz && \
    tar xfz rcssserver-$VERSION.tar.gz
RUN cd rcssserver-rcssserver-$VERSION && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    ldconfig

FROM ubuntu:22.04
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/bin /usr/local/bin
RUN ldconfig && \
    apt-get update && \
    apt-get install -y libboost-filesystem1.74.0 libboost-system1.74.0 && \
    apt-get clean
EXPOSE 6000/udp
CMD ["/usr/local/bin/rcssserver"]
