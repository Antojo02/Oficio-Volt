OficioVolt — Astro prototype

This folder is a minimal Astro site created from the existing `WEB_COPIA` copy.

What I created:
- `package.json` with `astro` dependency and scripts (`dev`, `build`, `preview`)
- `astro.config.mjs` basic config
- `src/layouts/Layout.astro` base layout (header/footer)
- `src/pages/index.astro` converted home page with contact form pointing to `/send.php`

Important next steps you must do manually:
1. Copy the `assets/` folder from the root copy into `astro-site/public/assets` so images, icons and `main.css` are available to the Astro site. Example:

   cp -r ../assets ./public/

2. Install dependencies and run dev server:

```bash
cd WEB_COPIA/astro-site
npm install
npm run dev
```

3. Convert additional pages (pages under root and `/en/`) into `src/pages/` files. The existing HTML can be used as source content.

4. Decide what to do with PHP pages (e.g. keep `send.php` in the parent folder and use form `action="/send.php"`). The Astro dev server can proxy requests in production or you can run Astro build and deploy behind the PHP host.

If you want, I can:
- Extract the shared header from all pages into the layout (I can scan pages in the copy and create `Layout.astro` with more complete markup). 
- Convert more pages automatically (start with `/en/index.html` and a few service pages).

Which next step do you want me to take? (reply with the number)
1) Copy `assets/` into `astro-site/public` now.
2) Extract full header from copy and update `Layout.astro`.
3) Convert more pages automatically (specify which).
4) Nothing more for now.
