FROM alpine:latest AS build
RUN apk add --no-cache \
  build-base \
  clang \
  cmake \
  compiler-rt \
  curl \
  lld \
  perl \
  pkgconfig \
  upx
RUN mkdir /putty \
 && curl -s -L https://the.earth.li/~sgtatham/putty/latest/putty-0.82.tar.gz \
  | tar -xzvC/putty --strip-components=1
RUN cd /putty \
 && cmake -DCMAKE_EXE_LINKER_FLAGS='-static -s' . \
 && cmake --build . \
 && mkdir /putty-tools-static \
 && mv pageant plink pscp psftp psusan puttygen -t /putty-tools-static
RUN upx --lzma /putty-tools-static/*
FROM scratch
COPY --from=build /putty-tools-static /
