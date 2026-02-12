import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';
import replace from '@rollup/plugin-replace';
import react from '@vitejs/plugin-react';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load .env
dotenv.config();

// Create a replacement map for all variables starting with THEME_
const themeReplacements = {};
Object.keys(process.env).forEach((key) => {
	if (key.startsWith('THEME_')) {
		themeReplacements[key] = process.env[key];
	}
});

const themeName = process.env.THEME_NAME || 'theme-name';

export default defineConfig({
	base: '',
	server: {
		watch: {
			ignored: (filepath) => {
				const normalized = filepath.split(path.sep).join('/');
				const themePath = `/${themeName}/`;
				return (
					normalized.includes(themePath) ||
					filepath.includes('.DS_Store')
				);
			},
		},
	},
	plugins: [
		react(),
		tailwindcss(),
		replace({
			values: themeReplacements,
			preventAssignment: true,
			// Target both scss and ts files
			include: ['assets/sass/**/*.scss', 'assets/ts/**/*.{ts,tsx}'],
		}),
	],
	css: {
		preprocessorOptions: {
			scss: {
				api: 'modern-compiler',
			},
		},
	},
	build: {
		minify: true,
		cssMinify: true,
		outDir: path.resolve(__dirname, themeName, 'dist'),
		emptyOutDir: true,
		rollupOptions: {
			input: {
				script: path.resolve(__dirname, 'assets/ts/script.tsx'),
				style: path.resolve(__dirname, 'assets/sass/style.scss'),
				'admin-script': path.resolve(
					__dirname,
					'assets/ts/admin-script.tsx'
				),
				'admin-style': path.resolve(
					__dirname,
					'assets/sass/admin-style.scss'
				),
			},
			output: {
				entryFileNames: '[name].js',
				chunkFileNames: 'chunks/[name]-[hash].js',
				assetFileNames: (assetInfo) => {
					if (assetInfo.name && assetInfo.name.endsWith('.css')) {
						return '[name].css';
					}
					return '[name]-[hash][extname]';
				},
				manualChunks: {
					'vendor-react': ['react', 'react-dom'],
					'vendor-swiper': ['swiper'],
					'vendor-utils': ['lucide-react'],
				},
			},
		},
	},
});
