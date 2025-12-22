import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";
import path from "path";
import { fileURLToPath } from "url";
import dotenv from "dotenv";
import replace from "@rollup/plugin-replace";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load .env
dotenv.config();

// Create a replacement map for all variables starting with THEME_
const themeReplacements = {};
Object.keys(process.env).forEach((key) => {
  if (key.startsWith("THEME_")) {
    themeReplacements[key] = process.env[key];
  }
});

const themeName = process.env.THEME_NAME || "theme-name";

export default defineConfig({
  plugins: [
    tailwindcss(),
    replace({
      values: themeReplacements,
      preventAssignment: true,
      // Target both sass and ts files
      include: ["assets/sass/**/*.sass", "assets/ts/**/*.ts"],
    }),
  ],
  css: {
    preprocessorOptions: {
      sass: {
        api: "modern-compiler",
      },
    },
  },
  build: {
    minify: false, // Keep output readable as requested
    outDir: path.resolve(__dirname, themeName),
    emptyOutDir: false,
    watch: {
      include: "assets/**",
    },
    rollupOptions: {
      input: {
        script: path.resolve(__dirname, "assets/ts/script.ts"),
        style: path.resolve(__dirname, "assets/sass/style.sass"),
      },
      output: {
        entryFileNames: "assets/js/[name].js",
        assetFileNames: (assetInfo) => {
          const actualNames = assetInfo.names || [];
          if (actualNames.some((name) => name.endsWith("style.css"))) {
            return "style.css";
          }
          return "assets/[name].[ext]";
        },
      },
    },
  },
});
