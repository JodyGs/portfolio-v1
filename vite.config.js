import glslify from 'rollup-plugin-glslify';
import { defineConfig } from 'vite'
import path from 'path'

const dirname = path.resolve()

export default defineConfig({
    root: 'sources',
    publicDir: '../public',
    build:
    {
        outDir: '../dist',
        emptyOutDir: true,
        sourcemap: true
    },
    plugins: [glslify({
        // Default
        include: [
            '**/*.vs',
            '**/*.fs',
            '**/*.vert',
            '**/*.frag',
            '**/*.glsl'
        ],
    
        // Undefined by default
        exclude: 'node_modules/**',
    
        // Enabled by default
        compress: true
    
        // The compress option also accepts a function with its first argument
        // being the string containing the glslified shader code.
        // The function is expected to return a string (or object) - the compressed shader
    })]
})