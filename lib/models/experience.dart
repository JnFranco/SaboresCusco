/// Modelo de experiencia / lugar gastronómico.
///
/// Intencionalmente SEPARADO de [Dish]: tienen layouts distintos
/// (DishCard vertical vs ExperienceCard horizontal) y atributos
/// distintos (`duration` vs `rating/category`). Reutilizar Dish aquí
/// sería forzar abstracción y dificultar el informe.
class Experience {
  final String title;
  final String description;
  final String imagePath;

  /// Solo imágenes informativas llevan etiqueta (criterio Sec 4.3).
  final String imageSemanticLabel;

  final String location;

  /// Ej. "2-3 h", "Todo el día". Dato visual, sin lógica.
  final String duration;

  const Experience({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.imageSemanticLabel,
    required this.location,
    required this.duration,
  });
}
