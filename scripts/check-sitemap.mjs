import { existsSync, readFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';

const pagesRoot = join(process.cwd(), 'src', 'pages');
const sitemapPath = join(process.cwd(), 'public', 'sitemap.xml');
const excludedRoutes = new Set([
  '/404/',
  '/consulta-bono/',
  '/demo-cliente/',
  '/gestion-oficiovolt/',
  '/bono-confirmado/',
  '/intervencion-rapida-confirmado/',
  '/urgencia-confirmado/',
  '/visita-tecnica-confirmado/'
]);

function collectRoutes(directory, prefix = '') {
  const routes = [];
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const fullPath = join(directory, entry.name);
    if (entry.isDirectory()) {
      routes.push(...collectRoutes(fullPath, `${prefix}/${entry.name}`));
    } else if (entry.name === 'index.astro') {
      const route = `${prefix || ''}/`.replaceAll('//', '/');
      routes.push(route === '//' ? '/' : route);
    }
  }
  return routes;
}

if (!existsSync(sitemapPath)) {
  console.error('No existe public/sitemap.xml');
  process.exit(1);
}

const sourceRoutes = new Set(collectRoutes(pagesRoot));
const sitemapRoutes = new Set(
  [...readFileSync(sitemapPath, 'utf8').matchAll(/<loc>https?:\/\/[^<\/]+(\/[^<]*)<\/loc>/g)]
    .map((match) => `${match[1].replace(/\/+$/, '') || ''}/`)
);
const expectedRoutes = new Set([...sourceRoutes].filter((route) => !excludedRoutes.has(route)));
const missing = [...expectedRoutes].filter((route) => !sitemapRoutes.has(route));
const stale = [...sitemapRoutes].filter((route) => !sourceRoutes.has(route));

if (missing.length || stale.length) {
  if (missing.length) console.error(`Rutas ausentes del sitemap:\n${missing.join('\n')}`);
  if (stale.length) console.error(`Rutas del sitemap sin página Astro:\n${stale.join('\n')}`);
  process.exit(1);
}

console.log(`Sitemap válido: ${sitemapRoutes.size} rutas públicas comprobadas.`);
