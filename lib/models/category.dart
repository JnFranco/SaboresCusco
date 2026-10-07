import 'package:flutter/material.dart';

/// Categoría del filtro visual (Wrap).
///
/// Nota: guarda [IconData] porque el chip siempre muestra icono + texto.
/// Es uso pertinente de MaterialIcons, no lógica de negocio.
/// `isSelected` es visual y const (sin estado): solo UN chip nace
/// seleccionado para demostrar el estilo activo en UI estática.
class Category {
  final String label;
  final IconData icon;

  /// Etiqueta semántica del icono SOLO si aporta (criterio Sec 4.3).
  /// Si el icono duplica el label ("Platos" + icono restaurante),
  /// el widget usará ExcludeSemantics; este campo quedará vacío.
  final String iconSemanticLabel;
  final bool isSelected;

  const Category({
    required this.label,
    required this.icon,
    this.iconSemanticLabel = '',
    this.isSelected = false,
  });
}
