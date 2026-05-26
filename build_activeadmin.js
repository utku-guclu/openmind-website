const esbuild = require("esbuild");
esbuild.build({
  entryPoints: ["active_admin_entry.js"],
  bundle: true,
  minify: true,
  outfile: "active_admin_bundle.js",
  format: "iife",
  external: ["jquery", "jquery-ui/*"],
}).catch(() => process.exit(1));
