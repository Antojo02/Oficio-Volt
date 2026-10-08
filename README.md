OficioVolt - sitio Astro estático y backend PHP en IONOS

Este directorio contiene el frontend público Astro de OficioVolt. El despliegue principal previsto es IONOS: se genera `dist` y se publica junto a `send.php`, `consulta-bono`, `gestion-oficiovolt` e `includes`. Vercel solo puede usarse como preview porque no ejecuta PHP por defecto.

Comandos:

```bash
npm ci
npm run build
npm run preview
```

Despliegue principal en IONOS:

- Ejecutar `npm ci` y `npm run build` dentro de `astro-site`.
- Publicar el contenido de `dist` como raíz web junto al backend PHP.
- Mantener `includes` protegido por `.htaccess` y, si el plan lo permite, fuera de `public_html`.
- Configurar PHP, PDO_MySQL, MySQL/MariaDB, HTTPS y SMTP en IONOS.
- Mantener secretos fuera del repositorio y no subir configuraciones reales.
- Probar `/`, `/contacto/`, `/en/`, `/consulta-bono/` y `/gestion-oficiovolt/` antes del cambio DNS.

Preview opcional en Vercel:

- Usar `astro-site` como Root Directory, ejecutar `npm run build` y publicar `dist`.
- Los formularios PHP no funcionaran en Vercel sin un proxy hacia IONOS.
- No versionar `node_modules` ni `dist`.
