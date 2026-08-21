# Build container for the Verto Communicator (verto_communicator -> dist/).
#
# The app is AngularJS 1.3 built with Vite. Nothing here is exotic; the
# container exists so a build needs only Docker, and so the output is
# reproducible from the committed package-lock.json.
FROM node:22-bookworm-slim

# git: vite.config.js stamps the short commit into the About dialog. It falls
# back to "unknown" when the build context has no .git.
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && git config --global --add safe.directory '*'

WORKDIR /work/verto_communicator

# Dependencies first, so editing sources does not reinstall them.
COPY verto_communicator/package.json verto_communicator/package-lock.json ./
RUN npm ci --no-audit --no-fund

# src/main.js imports ../../js/src/*.js (the verto client library), so the whole
# checkout is the build context.
COPY . /work/

RUN npm run build

# build.sh streams the result out of here; this makes a bare `docker run` useful
# too: docker run --rm <image> tar -C /work/verto_communicator/dist -cf - .
CMD ["ls", "-la", "/work/verto_communicator/dist"]
