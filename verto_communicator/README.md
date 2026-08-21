# Verto Communicator

AngularJS 1.3 app for FreeSWITCH mod_verto, built with Vite.

```
npm ci
npm run dev            # dev server on http://localhost:9001
npm run build          # static site in dist/
```

`npm run dev` serves over http://localhost, which counts as a secure context,
so getUserMedia works. Anywhere else the app has to be served over HTTPS.

Set the FreeSWITCH login the app starts with in `src/config.json`
(see `src/config.json.sample`), which is copied to the root of the build.

For a build that needs nothing but Docker, see `../build.sh`.
