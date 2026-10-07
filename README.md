# Sabores del Cusco

Interfaz **estática** (StatelessWidget, sin estado ni navegación) de una
guía gastronómica del Cusco, para Desarrollo de Software II (IF616BIN).

## Contenido del repositorio

- `lib/` — código: models, datos estáticos, pantalla única y 7 widgets reutilizables.
- `assets/images/` — 10 fotografías reales (Wikimedia Commons, licencias libres). Atribución completa en [`ATTRIBUTIONS.md`](ATTRIBUTIONS.md).
- `test/` — 46 pruebas (contraste WCAG, targets 48×48, semántica, breakpoints, capturas).

## Verificación

```bash
flutter analyze   # 0 issues
flutter test      # 46/46
```

## Breakpoints

| Ancho | Columnas | Hero |
|---|---|---|
| < 600 | 1 | Stack con overlay |
| 600–899 | 2 | Stack con overlay |
| ≥ 900 | 3 | Row imagen + panel |