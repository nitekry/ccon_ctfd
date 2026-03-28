const { resolve } = require("path");
import { defineConfig } from "vite";
import { CSSManifestPlugin } from "vite-manifest-css";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [CSSManifestPlugin()],
  build: {
    manifest: true,
    outDir: "static",
    rollupOptions: {
      input: {
        index: resolve(__dirname, "assets/js/index.js"),
        main: resolve(__dirname, "assets/scss/main.scss"),
      },
    },
  },
});
