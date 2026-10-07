import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Chip visual de categoría para usar dentro de un `Wrap`.
///
/// Decisión informe Sec 3.4: el chip NO decide su ancho; el `Wrap` padre
/// lo posiciona. `isSelected` es solo visual (sin estado ni onTap real,
/// fuera del alcance estático). Accesibilidad: si el icono duplica el
/// label, se excluye de semántica para no anunciar dos veces.
class CategoryChip extends StatelessWidget {
  final Category category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final bool selected = category.isSelected;
    final Color bg = selected ? AppColors.terracotta : AppColors.surface;
    final Color fg = selected ? Colors.white : AppColors.ink;
    final Color border =
        selected ? AppColors.terracotta : AppColors.outline;

    final Widget icon = category.iconSemanticLabel.isEmpty
        // Icono redundante: el texto ya dice "Platos", no anunciar "icono".
        ? ExcludeSemantics(child: Icon(category.icon, size: 18, color: fg))
        : Icon(category.icon, size: 18, color: fg,
            semanticLabel: category.iconSemanticLabel);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpace12,
        vertical: kSpace8,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(kRadiusChip),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          const SizedBox(width: kSpace8),
          Text(
            category.label,
            // P6: tipografía desde el tema (labelLarge), no hardcodeada.
            style: text.labelLarge?.copyWith(
              color: fg,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
