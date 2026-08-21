# Build container for the Verto Communicator (verto_communicator -> dist/).
#
# This is a 2015-era Grunt 0.4 + Bower project. Three things break a plain
# `npm install && bower install && grunt build` on a current Debian, and all
# three are dealt with below:
#
#   1. bower.json pulls bootstrap-material-design over git://, a protocol
#      GitHub switched off in 2021 -> rewrite git:// to https://.
#   2. grunt-contrib-imagemin's optipng-bin / jpegtran-bin / gifsicle each try
#      to fetch a prebuilt 2015 binary from a URL at install time, and fall
#      back to compiling from source when that 404s or the arch has no build
#      -> install with --ignore-scripts and point their vendor/ paths at
#      Debian's own optipng, jpegtran and gifsicle.
#   3. package.json is all loose "^" ranges, so `npm install` now resolves
#      releases that no longer work with grunt 0.4 -> `npm ci` off the
#      committed package-lock.json.
#
# Node itself is not the problem: this tree builds on 14, 20 and 22 alike.
# 22 is pinned because it is the current LTS.
FROM node:22-bookworm

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      gifsicle \
      libjpeg-turbo-progs \
      optipng \
 && rm -rf /var/lib/apt/lists/*

RUN git config --global url."https://github.com/".insteadOf git://github.com/ \
 && git config --global --add safe.directory '*'

RUN npm install -g --no-audit --no-fund bower@1.8.14 grunt-cli@1.4.3

WORKDIR /work/verto_communicator

# Dependencies first, so editing sources does not reinstall them.
COPY verto_communicator/package.json verto_communicator/package-lock.json ./
RUN npm ci --ignore-scripts --no-audit --no-fund \
 && mkdir -p node_modules/optipng-bin/vendor \
             node_modules/jpegtran-bin/vendor \
             node_modules/gifsicle/vendor \
 && ln -sf /usr/bin/optipng  node_modules/optipng-bin/vendor/optipng \
 && ln -sf /usr/bin/jpegtran node_modules/jpegtran-bin/vendor/jpegtran \
 && ln -sf /usr/bin/gifsicle node_modules/gifsicle/vendor/gifsicle

COPY verto_communicator/bower.json ./
RUN bower install --allow-root --config.interactive=false

# src/index.html loads ../js/src/*.js, so the whole checkout is the context.
COPY . /work/

# `grunt build` runs the `revision` task, which shells out to git for the
# string shown in the About dialog; give it a repo when the build context has
# no .git (a tarball, say).
ARG GRUNT_FLAGS=
RUN git rev-parse --short HEAD >/dev/null 2>&1 \
    || ( cd /work \
         && git init -q \
         && git add -A \
         && git -c user.email=build@localhost -c user.name=build commit -qm "verto-client build" ) \
 && grunt build $GRUNT_FLAGS

# build.sh streams the result out of here; this makes a bare `docker run` useful
# too: docker run --rm <image> tar -C /work/verto_communicator/dist -cf - .
CMD ["ls", "-la", "/work/verto_communicator/dist"]
