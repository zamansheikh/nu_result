import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) =>{
  let outDir = 'dist';
  if (mode === 'github') {
    outDir = 'docs';
  } else if (mode === 'netlify') {
    outDir = 'dist';
  }
  //this is for github with custom domain
  return {
    base: mode === 'github' ? '/nu_result/' : '/',
    plugins: [react()],
    build: {
      outDir, // Use the determined output directory
    },
  };
});
