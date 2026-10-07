import 'package:flutter/material.dart';

/// Título de sección con subtítulo descriptivo (sin botón falso "Ver todo").
///
/// Decisión informe Sec 3.1: `Column(crossStart)` con jerarquía
/// titleLarge 18/bold + bodySmall 12/gris. Marcado como header semántico
/// para lector de pantalla (criterio Sec 4.3).
class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: text.titleLarge),
          const SizedBox(height: 4),
          Text(subtitle, style: text.bodySmall),
        ],
      ),
    );
  }
}
