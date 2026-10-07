/// Modelo inmutable de plato / bebida / postre.
///
/// Dart idiomático: clase con campos `final`, constructor `const`,
/// parámetros `required` y `isFeatured` con valor por defecto.
/// Sin herencia: no existe jerarquía real que lo justifique (ver informe).
class Dish {
  /// Nombre visible. Incluye casos cortos y uno largo (45 caracteres)
  /// para probar `maxLines: 1 + ellipsis` en cards de ~273px.
  final String name;

  /// Descripción breve. Longitud variable (1 a 3 líneas) para probar
  /// `maxLines: 2 + ellipsis`.
  final String description;

  /// Ruta local, ej. `assets/images/chiri_uchu.jpg`.
  /// Se usa `Image.asset` (sin red) por decisión de demo offline.
  final String imagePath;

  /// Descripción de la imagen SOLO si es informativa.
  /// Criterio accesibilidad: se anuncia por lector; no duplicar texto visible.
  final String imageSemanticLabel;

  /// Debe coincidir con un [Category.label] de `gastronomy_data.dart`.
  final String category;

  /// 0.0 - 5.0. Se muestra siempre con número (color no decorativo).
  final double rating;

  /// Ej. "San Pedro, Cusco". Truncable con ellipsis (dato secundario).
  final String location;

  /// Si es true, la card muestra badge superpuesto con Stack+Positioned.
  final bool isFeatured;

  const Dish({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.imageSemanticLabel,
    required this.category,
    required this.rating,
    required this.location,
    this.isFeatured = false,
  });
}
