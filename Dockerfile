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
 && upx --best pageant plink pscp psftp psusan puttygen
RUN mkdir /putty-tools-static \
 && cp \
    /putty/pageant \
    /putty/plink \
    /putty/pscp \
    /putty/psftp \
    /putty/psusan \
    /putty/puttygen \
    /putty-tools-static
FROM scratch
COPY --from=build /putty-tools-static /
