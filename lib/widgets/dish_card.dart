import 'package:flutter/material.dart';

import '../models/dish.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Tarjeta vertical de plato (imagen 16:9 + cuerpo).
///
/// Decisiones para informe:
/// - Sec 3.2: `Container` con `BoxDecoration` (radius 16 + sombra 8%)
///   y `margin: zero` (el espaciado lo da el padre, no la card).
/// - Sec 3.3: `Row` inferior con `Expanded` SOLO en ubicación
///   (dato truncable); rating nunca se trunca (dato crítico).
/// - Sec 3.4: `Stack(clipBehavior: hardEdge)` para badge DESTACADO.
/// - Sec 4.2: nombre `maxLines:1`, descripción `maxLines:2`, ambos
///   con `ellipsis`. Sin anchos fijos: funciona a 273/320/390px.
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(kRadiusCard),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _DishImage(dish: dish),
          Padding(
            padding: const EdgeInsets.all(kSpace12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  dish.name,
                  style: text.titleMedium,
                  maxLines: kMaxLinesCardTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: kSpace4),
                Text(
                  dish.description,
                  style: text.bodyMedium,
                  maxLines: kMaxLinesCardDesc,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: kSpace8),
                Row(
                  children: <Widget>[
                    _Rating(rating: dish.rating),
                    const SizedBox(width: kSpace8),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const ExcludeSemantics(
                            child: Icon(
                              Icons.place,
                              size: 14,
                              color: AppColors.inkSecondary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              dish.location,
                              style: text.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Imagen 16:9 con badge superpuesto si `isFeatured`.
class _DishImage extends StatelessWidget {
  final Dish dish;

  const _DishImage({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            dish.imagePath,
            fit: BoxFit.cover,
            semanticLabel: dish.imageSemanticLabel,
            errorBuilder: (BuildContext context, Object error,
                StackTrace? stackTrace) {
              // Si falta el asset, muestra bloque terracota en vez de
              // romper el layout (evita crash en demo).
              return const ColoredBox(color: AppColors.terracotta);
            },
          ),
        ),
        if (dish.isFeatured)
          Positioned(
            top: kSpace8,
            left: kSpace8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpace8,
                vertical: kSpace4,
              ),
              decoration: BoxDecoration(
                // P5: "destacado" es un solo concepto = un solo token.
                // Dorado + texto tinta (6.9:1, verificado en Fase 5): es el
                // mismo badge del hero, coherente sobre foto o panel.
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(kRadiusBadge),
              ),
              child: Text(
                'DESTACADO',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.ink),
              ),
            ),
          ),
      ],
    );
  }
}

/// Rating con número + estrella decorativa excluida de semántica.
class _Rating extends StatelessWidget {
  final double rating;

  const _Rating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Valoración $rating de 5',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ExcludeSemantics(
            child: Icon(Icons.star, size: 16, color: AppColors.gold),
          ),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
          ),
        ],
      ),
    );
  }
}
