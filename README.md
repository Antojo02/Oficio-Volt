OficioVolt — sitio Astro estático

Este directorio contiene el frontend público Astro de OficioVolt. El backend PHP se mantiene fuera de este repositorio y debe desplegarse en el hosting que sirve `send.php`, `consulta-bono` y `gestion-oficiovolt`.

Comandos:

```bash
npm ci
npm run build
npm run preview
```

Despliegue:

- En Vercel, usar `astro-site` como Root Directory, ejecutar `npm run build` y publicar `dist`.
- El backend PHP debe permanecer accesible bajo el mismo dominio o mediante un proxy configurado por el hosting.
- Configurar las variables/secretos SMTP y MySQL fuera de las rutas públicas.
- No versionar `node_modules` ni `dist`.
