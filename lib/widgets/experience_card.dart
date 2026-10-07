import 'package:flutter/material.dart';

import '../models/experience.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Tarjeta horizontal de experiencia (foto cuadrada + textos).
///
/// Decisión informe: layout DISTINTO a `DishCard` a propósito (Row en vez
/// de Column) para que la app no parezca un catálogo. `Expanded` en la
/// columna de texto permite que el título/descripción usen el ancho
/// restante y trunquen con ellipsis a 273px sin overflow.
class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: kExperienceImageSize,
            height: kExperienceImageSize,
            child: Image.asset(
              experience.imagePath,
              fit: BoxFit.cover,
              semanticLabel: experience.imageSemanticLabel,
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return const ColoredBox(color: AppColors.olive);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kSpace12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    experience.title,
                    style: text.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: kSpace4),
                  Text(
                    experience.description,
                    style: text.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: kSpace8),
                  Row(
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
                          experience.location,
                          style: text.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: kSpace8),
                      Flexible(
                        child: Text(
                          experience.duration,
                          style: text.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
