# Verto Client

The community version of the verto client example code.

[FreeSWITCH](https://github.com/signalwire/freeswitch) and mod_verto is needed to run this demo.

This needs to be fleshed out more.

It would be nice to develop a web app here that implements a web phone.
Do not base it on the demo because it was just tossed together.

To run jshint:

```
cd js
npm install
grunt
```

## Building the Verto Communicator

```
cd verto_communicator
npm ci
npm run build          # static site in verto_communicator/dist
npm run dev            # dev server on http://localhost:9001
```

Or without a local Node, in Docker:

```
./build.sh          # static site lands in ./out
./build.sh --help   # --out DIR, --no-cache
```

Serve the output over HTTPS (WebRTC requires it, `localhost` excepted); default
login is in `config.json` next to `index.html`.

## Docs

https://evoluxbr.github.io/verto-docs/

## Directories

- demo: audio only WebRTC demo
- video_demo: demo with video support
- video_demo-live_canvas: video demo with live canvas feature
- verto_communicator: nearly full featured video conference demo

## Others

- [@xswitch/rtc](https://www.npmjs.com/package/@xswitch/rtc) is a successor of the verto client SDK, with es6, most docs in Chinese though.
- Theres some demos on https://git.xswitch.cn/xswitch/xcc-examples/src/branch/master/webrtc
- Live demos also available on https://xswitch.cn/demo/ and https://xswitch.cn/demo2/ which can you used to test connect to your own FreeSWITCH.
