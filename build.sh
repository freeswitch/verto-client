#!/bin/sh
# Build the Verto Communicator in Docker and drop the finished static site in
# ./out . Needs nothing on the host but Docker.
#
#   ./build.sh                 build, output to ./out
#   ./build.sh --out /srv/vc   output somewhere else
#   ./build.sh --debug         skip minification (readable JS for debugging)
#   ./build.sh --no-cache      rebuild the image from scratch
set -eu

# Git Bash rewrites arguments that look like paths, which mangles the
# container-side paths handed to docker. Turn that off, and never pass a host
# path to docker: the build context is "." and the output is streamed via tar.
MSYS_NO_PATHCONV=1
MSYS2_ARG_CONV_EXCL='*'
export MSYS_NO_PATHCONV MSYS2_ARG_CONV_EXCL

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
image=verto-communicator-build
out_dir=$script_dir/out
dist_dir=/work/verto_communicator/dist
grunt_flags=
no_cache=
force=0

usage() {
    sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'
    cat <<'USAGE'

Options:
  -o, --out DIR    where to put the built files (default: ./out)
  -t, --tag NAME   docker image tag to build (default: verto-communicator-build)
      --debug      build unminified/unmangled JS (grunt build --debug)
      --no-cache   pass --no-cache to docker build
  -f, --force      overwrite the output directory even if it looks unrelated
  -h, --help       this text
USAGE
}

need_arg() {
    [ "$2" -ge 2 ] || { echo "build.sh: $1 needs an argument" >&2; exit 2; }
}

while [ $# -gt 0 ]; do
    case $1 in
        -o|--out)   need_arg "$1" $#; out_dir=$2; shift 2 ;;
        -t|--tag)   need_arg "$1" $#; image=$2;   shift 2 ;;
        --debug)    grunt_flags=--debug; shift ;;
        --no-cache) no_cache=--no-cache; shift ;;
        -f|--force) force=1; shift ;;
        -h|--help)  usage; exit 0 ;;
        *)          echo "build.sh: unknown option: $1" >&2; usage >&2; exit 2 ;;
    esac
done

command -v docker >/dev/null 2>&1 || {
    echo "build.sh: docker not found in PATH" >&2
    exit 1
}

# Only clobber an output directory that is empty or holds a previous build.
if [ -d "$out_dir" ] && [ -n "$(ls -A "$out_dir" 2>/dev/null)" ] \
   && [ ! -f "$out_dir/index.html" ] && [ "$force" -eq 0 ]; then
    echo "build.sh: $out_dir is not empty and does not look like a previous" >&2
    echo "          build; move it aside or re-run with --force." >&2
    exit 1
fi

cd "$script_dir"

echo "==> docker build -t $image"
# shellcheck disable=SC2086
docker build $no_cache --build-arg GRUNT_FLAGS="$grunt_flags" -t "$image" .

echo "==> extracting $dist_dir to $out_dir"
rm -rf "$out_dir"
mkdir -p "$out_dir"
docker run --rm "$image" tar -C "$dist_dir" -cf - . | tar -xf - -C "$out_dir"

[ -f "$out_dir/index.html" ] || {
    echo "build.sh: build produced no index.html - see the output above" >&2
    exit 1
}

echo
echo "Built $(find "$out_dir" -type f | wc -l | tr -d ' ') files ($(du -sh "$out_dir" | cut -f1)) in $out_dir"
echo "Serve that directory over HTTPS (WebRTC needs a secure origin) and edit"
echo "config.json there for the FreeSWITCH login it should default to."
