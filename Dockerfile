FROM ubuntu:18.04 AS build
ARG VERSION=15.4.0
WORKDIR /root
RUN apt update && \
    apt -y install autoconf bison clang flex libboost-dev libboost-all-dev libc6-dev make wget
RUN wget https://github.com/rcsoccersim/rcssserver/archive/rcssserver-$VERSION.tar.gz && \
    tar xfz rcssserver-$VERSION.tar.gz && \
    cd rcssserver-rcssserver-$VERSION && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    ldconfig

FROM ubuntu:18.04
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/bin /usr/local/bin
RUN ldconfig && \
    apt update && \
    apt install -y libboost-filesystem1.65.1 libboost-system1.65.1
EXPOSE 6000/udp
CMD ["/usr/local/bin/rcssserver"]

