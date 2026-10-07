# Notas de estudio — Presentación Sabores del Cusco

Para practicar la presentación. Las diapositivas (PDF/HTML de 10 páginas) NO
llevan texto; esto es lo que dices en cada una. No memorices al pie de la
letra: las frases en **negrita** son las que dejan huella si te preguntan.

---

## 1. Portada

> "Nuestro proyecto se llama **Sabores del Cusco** y consiste en una guía
> gastronómica estática de platos y experiencias culinarias cusqueñas,
> presentada mediante una interfaz visual para la asignatura Desarrollo de
> Software II (IF616BIN)."

**Nota:** la captura de fondo es el hero real en 1280 px, extraída del informe.

---

## 2. ¿Qué desarrollamos?

> "La idea fue presentar platos y experiencias gastronómicas cusqueñas.
> Algo importante es que el alcance estaba **limitado a UI**. Por eso no
> implementamos backend, base de datos, autenticación ni lógica de negocio.
> Todo el contenido es estático y trabajamos principalmente con
> **StatelessWidget**."

**Si preguntan por qué solo UI:** *"Es una entrega de la Unidad I: fundamentos
de Dart, UI declarativa y UX. El estado, la navegación y la persistencia son
temas de unidades posteriores."*

Contenido que se muestra: hero, 8 categorías, 6 platos, 3 experiencias, footer.

---

## 3. Arquitectura de widgets

> "La pantalla principal se divide en varios componentes: el **header**, el
> **hero**, las **categorías**, la **cuadrícula de platos**, las
> **experiencias** y el **footer**.
> También separamos el código en `models`, `data`, `screens`, `widgets` y
> `utils`. La intención fue **no tener toda la interfaz en un solo archivo**
> y poder probar los componentes de forma aislada."

Árbol (si preguntan la estructura):
```
MaterialApp → HomeScreen
  ├── AppHeader (Row + Expanded + 2 IconButton)
  ├── HeroSection (LayoutBuilder local)
  ├── SectionTitle
  ├── Wrap de CategoryChip
  ├── DishGrid → Row de Expanded(DishCard)
  ├── ExperienceCard
  └── Footer
```

---

## 4. Widgets y composición

> "Aquí tratamos de seguir un principio importante: **no usar widgets solo
> para cumplir la rúbrica**.
> **Stack** tiene sentido en el Hero porque necesitamos colocar el texto
> encima de la imagen; **Wrap** tiene sentido para las categorías porque
> pueden ocupar varias líneas; y **Expanded** nos permite repartir el espacio
> disponible sin usar tamaños rígidos."

| Widget | Aplicación real |
|---|---|
| Container | cards, footer, superficies (BoxDecoration) |
| Row / Column | estructura general |
| Expanded | reparto de espacio (header, grid, hero) |
| Stack + Positioned | hero y badge DESTACADO |
| Wrap | 8 chips de categoría |
| LayoutBuilder | responsive local |
| MediaQuery | responsive global |

---

## 5. Responsive — la más importante

> "Una de las partes principales fue hacerlo responsive. En móvil tenemos
> **1 columna**, en tablet **2** y en desktop **3**.
> Pero no solo cambia la cantidad de columnas: también cambia la composición
> del **Hero** y la distribución de las **experiencias**."

**La frase que te hace quedar bien:**

> "Los breakpoints **no fueron escogidos** simplemente por ser tamaños
> típicos de dispositivos. Los calculamos considerando el ancho mínimo
> necesario para que una tarjeta mantenga legibles su título y sus
> metadatos."

Valores: `< 600 → 1`, `600–899 → 2`, `≥ 900 → 3`. Cálculo documentado:
**≈273 px por tarjeta** → `3×273 + 2×16 (gaps) + 2×24 (padding) = 900`.
Tests específicos en los bordes 599/600 y 899/900.

---

## 6. Hero adaptativo

> "En el Hero hicimos una adaptación más profunda.
> En móvil y tablet usamos un **Stack** porque el espacio horizontal es
> reducido, así que colocamos el contenido **sobre la imagen**.
> A partir de 900 px cambiamos la estructura completamente: usamos un **Row**
> que divide la imagen y el panel de información.
> Esto aprovecha mejor el espacio y **mejora el contraste**, porque en
> desktop ya no dependemos del texto sobre la fotografía."

```
Mobile / Tablet          Desktop
┌─────────────┐          ┌─────────┬─────────┐
│    IMAGEN   │          │ IMAGEN  │ TEXTO   │
│   + TEXTO   │          │ flex:5  │ flex:4  │
└─────────────┘          └─────────┴─────────┘
  Stack + overlay          Row + panel sólido
```

**Punto extra:** el informe identifica al Hero como la **sección con mayor
cambio compositivo**: no solo cambia la cantidad, cambia completamente la
estructura (layered → panel lateral).

---

## 7. Layout y prevención de errores

> "Una de las dificultades fue trabajar con las **restricciones de Flutter**.
> Inicialmente analizamos usar un `GridView` dentro del
> `SingleChildScrollView`, pero eso generaba **altura no acotada**
> (unbounded).
> Finalmente construimos nuestro `DishGrid` mediante **filas y Expanded**,
> donde cada tarjeta recibe un ancho acotado."

**Frase de cierre (está en el informe):**

> "La idea que aprendimos fue que **primero hay que acotar el espacio y
> después repartirlo**."

Herramientas adicionales que mencionar si preguntan:
`Expanded`, `Flexible`, `maxLines`, `TextOverflow.ellipsis`,
`ConstrainedBox`, `SingleChildScrollView`.

---

## 8. Accesibilidad y UX

> "También evaluamos accesibilidad. Calculamos los contrastes con **WCAG**
> y verificamos que los pares de colores cumplan el mínimo para texto
> normal (4.5:1). También verificamos que los botones tengan un área táctil
> de **48×48** y trabajamos la semántica de imágenes y encabezados."

**El detalle que demuestra QA real (si te preguntan):**

> "Encontramos una combinación que **no cumplía contraste**: blanco sobre
> dorado tenía **2.4:1**. Por eso cambiamos el texto del badge a tinta,
> llegando a **6.9:1**."

Ratios: tinta/fondo 15.4 · secundario/fondo 4.8 · blanco/terracota 5.2 ·
tinta/dorado 6.9 · blanco/terracota oscuro 9.4 · blanco/oliva 4.7.
Otros: 48×48, `semanticLabel`, `Semantics.header`, `ExcludeSemantics`,
color ≠ único indicador.

---

## 9. Pruebas y evidencias

> "Finalmente validamos con pruebas automatizadas: **46 de 46 tests**
> superados y `flutter analyze` → **0 issues**.
> Además de que el código compila, el grid se verificó en **ocho anchos**
> (273→1024 px) y generamos **capturas reales** de la pantalla en tres
> anchos. La robustez cubre overflow, contenido extremo, landscape,
> contraste WCAG y touch targets."

Lo verificado: breakpoints y bordes · overflow · contenido extremo ·
landscape · contraste WCAG · touch targets · semántica · Wrap · grid en 8
anchos. Evidencia visual en 390 / 768 / 1280.

---

## 10. Resultados y conclusión

> "¿Qué logramos? Una **UI estática** en Flutter + Dart con diseño responsive
> de 1, 2 y 3 columnas, un **hero adaptativo** según el espacio, acceso a
> **accesibilidad y contraste desde el diseño**, validado con **pruebas
> automatizadas y visuales**, y sin overflow en los anchos evaluados.
> ¿Qué aprendimos? Que el modelo de restricciones de Flutter es la base para
> lograr interfaces adaptables sin errores de layout; que los breakpoints se
> definen por **legibilidad**, no por dispositivos; y que una interfaz
> responsive **no consiste en reducir tamaños, sino en cambiar la composición**
> cuando el espacio lo requiere."

**Frase de cierre (última lámina, en grande):**

> "El objetivo no fue solo construir una interfaz que se vea bien, sino una
> interfaz que **mantenga su estructura, legibilidad y accesibilidad al
> cambiar de tamaño**."

No incluimos la nota de la rúbrica (20/20) en la diapositiva: la autoevaluación
queda para el informe, no para la exposición.

---

## 🎯 Las 5 cosas que TIENES que dominar

Si tienes poco tiempo, no memorices las 10 diapositivas. Memoriza esto:

1. **¿Qué hicieron?** — "Una guía gastronómica estática y responsive en Flutter."
2. **¿Por qué LayoutBuilder + MediaQuery?** — "MediaQuery para decisiones globales (ancho de pantalla) y LayoutBuilder para decisiones basadas en el espacio real disponible por componente."
3. **¿Por qué 600 y 900?** — "Porque calculamos el ancho mínimo de las cards: aproximadamente 273 px."
4. **¿Cuál fue el problema técnico más importante?** — "Las restricciones de Flutter, especialmente GridView dentro de SingleChildScrollView (altura unbounded)."
5. **¿Cómo saben que funciona?** — "46/46 tests, analyze limpio, pruebas de overflow, accesibilidad, breakpoints y capturas en 390, 768 y 1280."

---

## ⚠️ Errores que ya corregimos (no los digas tú)

- El informe decía "Vista escritorio — ancho 1280 px (**> 840**)" y el
  breakpoint real es **≥ 900**. Ya corregido en el MD y el PDF del informe.
- La portada del informe llevaba solo un integrante. Queda firmado **solo
  por Jean Franco** (confirmado). Si el docente espera tres nombres,
  ajustarlo antes de entregar.
- Las notas del orador **no están en las diapositivas**: están en este
  archivo, así nadie lee de la lámina.

---

## Checklist antes de presentar

- [ ] Diapositivas abren correctamente (`PRESENTACION_SaboresCusco.pdf`, 10 págs, 16:9).
- [ ] Proyecto subido a github.com/JnFranco/SaboresCusco.
- [ ] Informe (`INFORME_TECNICO.pdf`) coincide con la versión corregida.
- [ ] Dominas las 5 ideas clave (arriba).
- [ ] Tienes capturas a mano: 390 / 768 / 1280.