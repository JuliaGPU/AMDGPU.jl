import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import mathjax3 from "markdown-it-mathjax3";
import footnote from "markdown-it-footnote";
import path from 'path'

function getBaseRepository(base: string): string {
  if (!base || base === '/') return '/';
  const parts = base.split('/').filter(Boolean);
  return parts.length > 0 ? `/${parts[0]}/` : '/';
}

const baseTemp = {
  base: '/dev/',// TODO: replace this in makedocs!
}

const navTemp = {
  nav: [
{ text: 'Home', link: '/index' },
{ text: 'Tutorials', collapsed: false, items: [
{ text: 'Quick Start', link: '/tutorials/quickstart' },
{ text: 'Performance Tips', link: '/tutorials/perf' },
{ text: 'Profiling', link: '/tutorials/profiling' }]
 },
{ text: 'API', collapsed: false, items: [
{ text: 'Devices', link: '/api/devices' },
{ text: 'Streams', link: '/api/streams' },
{ text: 'Kernel Programming', link: '/api/kernel_programming' },
{ text: 'Exceptions', link: '/api/exceptions' },
{ text: 'Memory', link: '/api/memory' },
{ text: 'Host-Call', link: '/api/hostcall' },
{ text: 'Printing', link: '/api/printing' },
{ text: 'Intrinsics', link: '/api/intrinsics' }]
 }
]
,
}

const nav = [
  ...navTemp.nav,
  {
    component: 'VersionPicker'
  }
]

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: '/dev/',// TODO: replace this in makedocs!
  title: 'AMDGPU.jl',
  description: 'Documentation for AMDGPU.jl',
  lastUpdated: true,
  cleanUrls: true,
  outDir: '../1', // This is required for MarkdownVitepress to work correctly...
  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['script', {src: `${getBaseRepository(baseTemp.base)}versions.js`}],
    // ['script', {src: '/versions.js'], for custom domains, I guess if deploy_url is available.
    ['script', {src: `${baseTemp.base}siteinfo.js`}]
  ],
  
  vite: {
    define: {
      __DEPLOY_ABSPATH__: JSON.stringify('/'),
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, '../components')
      }
    },
    optimizeDeps: {
      exclude: [ 
        '@nolebase/vitepress-plugin-enhanced-readabilities/client',
        'vitepress',
        '@nolebase/ui',
      ], 
    }, 
    ssr: { 
      noExternal: [ 
        // If there are other packages that need to be processed by Vite, you can add them here.
        '@nolebase/vitepress-plugin-enhanced-readabilities',
        '@nolebase/ui',
      ], 
    },
  },
  markdown: {
    math: true,
    config(md) {
      md.use(tabsMarkdownPlugin),
      md.use(mathjax3),
      md.use(footnote)
    },
    theme: {
      light: "github-light",
      dark: "github-dark"}
  },
  themeConfig: {
    outline: 'deep',
    logo: { src: '/logo.png', width: 24, height: 24},
    search: {
      provider: 'local',
      options: {
        detailedView: true
      }
    },
    nav,
    sidebar: [
{ text: 'Home', link: '/index' },
{ text: 'Tutorials', collapsed: false, items: [
{ text: 'Quick Start', link: '/tutorials/quickstart' },
{ text: 'Performance Tips', link: '/tutorials/perf' },
{ text: 'Profiling', link: '/tutorials/profiling' }]
 },
{ text: 'API', collapsed: false, items: [
{ text: 'Devices', link: '/api/devices' },
{ text: 'Streams', link: '/api/streams' },
{ text: 'Kernel Programming', link: '/api/kernel_programming' },
{ text: 'Exceptions', link: '/api/exceptions' },
{ text: 'Memory', link: '/api/memory' },
{ text: 'Host-Call', link: '/api/hostcall' },
{ text: 'Printing', link: '/api/printing' },
{ text: 'Intrinsics', link: '/api/intrinsics' }]
 }
]
,
    editLink: { pattern: "https://https://github.com/JuliaGPU/AMDGPU.jl/edit/master/docs/src/:path" },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/JuliaGPU/AMDGPU.jl' }
    ],
    footer: {
      message: 'Made with <a href="https://luxdl.github.io/DocumenterVitepress.jl/dev/" target="_blank"><strong>DocumenterVitepress.jl</strong></a><br>',
      copyright: `© Copyright ${new Date().getUTCFullYear()}.`
    }
  }
})
