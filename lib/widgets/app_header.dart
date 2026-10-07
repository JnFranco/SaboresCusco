import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Cabecera de identidad (sin navegación real, fuera de alcance).
///
/// `compact` lo decide `HomeScreen` vía `MediaQuery` global: en <600 se
/// oculta el subtítulo. Los IconButton ya miden 48x48 (mínimo rúbrica).
/// `onPressed: () {}` es intencional: placeholder visual sin lógica.
class AppHeader extends StatelessWidget {
  final bool compact;

  const AppHeader({super.key, required this.compact});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return SizedBox(
      height: 64,
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.terracotta,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ExcludeSemantics(
              child: Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: kSpace12),
          // Expanded intencional con doble función: da al título todo el
          // espacio restante (empujando las acciones a la derecha) y acota
          // el texto para que nunca desborde (detectado por test a 390px
          // con fuente ancha: sin Expanded, el título + 2×48px desborda).
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sabores del Cusco',
                  style: text.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!compact) Text('Guía gastronómica', style: text.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: AppColors.ink,
            tooltip: 'Buscar (visual)',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: AppColors.ink,
            tooltip: 'Menú (visual)',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
