import { execSync } from 'node:child_process';
import { defineConfig } from 'vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';

// Shown in the About dialog. Replaces the old grunt revision/preprocess pair.
function gitRevision() {
  try {
    return execSync('git rev-parse --short HEAD', { encoding: 'utf8' }).trim();
  } catch {
    return 'unknown';
  }
}

export default defineConfig({
  // Relative asset URLs, so the app can be served from a sub-directory.
  base: './',
  define: {
    __GIT_REVISION__: JSON.stringify(gitRevision()),
  },
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    sourcemap: true,
  },
  server: {
    port: 9001,
    // http://localhost is a secure context, so getUserMedia works as is.
  },
  plugins: [
    // Fetched at runtime by AngularJS ($routeProvider templates,
    // angular-translate, configService, ringtones), so they have to keep their
    // paths instead of being hashed into assets/.
    viteStaticCopy({
      targets: [
        { src: 'src/partials', dest: '.' },
        { src: 'src/locales', dest: '.' },
        { src: 'src/sounds', dest: '.' },
        { src: 'src/images', dest: '.' },
        { src: 'src/img', dest: '.' },
        { src: 'src/config.json', dest: '.' },
        { src: 'src/contributors.txt', dest: '.' },
      ],
    }),
  ],
});
