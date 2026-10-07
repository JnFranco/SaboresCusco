import 'package:flutter/material.dart';

import '../data/gastronomy_data.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Hero con DOS composiciones reales (informe Sec 4.1).
///
/// - < 900: `Stack` editorial con overlay (única opción legible a 360px).
/// - >= 900: `Row` dividido imagen + panel sólido (elimina el problema de
///   contraste sobre foto y permite 3 líneas de descripción).
/// La decisión es LOCAL (`LayoutBuilder`), independiente del `MediaQuery`
/// global de `HomeScreen`. Sin tamaños de fuente hardcodeados por
/// dispositivo: solo cambian altura y composición.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : 0;
        if (maxWidth >= kBreakpointDesktopMin) {
          return const _HeroHorizontal();
        }
        final double height =
            maxWidth >= kBreakpointMobileMax ? kHeroHeightTablet : kHeroHeightMobile;
        return _HeroStack(height: height);
      },
    );
  }
}

/// Versión móvil/tablet: foto full-bleed + degradado + texto superpuesto.
class _HeroStack extends StatelessWidget {
  final double height;

  const _HeroStack({required this.height});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      // P2: misma familia de radios que desktop (20) y cards (16).
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kRadiusHero),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              GastronomyData.heroImage,
              fit: BoxFit.cover,
              semanticLabel: GastronomyData.heroImageSemantic,
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return const ColoredBox(color: AppColors.terracottaDark);
              },
            ),
          ),
          // Overlay funcional (no decorativo): garantiza contraste del
          // texto blanco sobre foto (criterio Sec 4.3).
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0x00000000),
                    Color(0xB3000000),
                  ],
                  stops: <double>[0.4, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: kSpace16,
            right: kSpace16,
            bottom: kSpace16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpace8,
                    vertical: kSpace4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(kRadiusBadge),
                  ),
                  child: Text(
                    'DESTACADO SEMANAL',
                    style: text.labelSmall?.copyWith(
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(height: kSpace8),
                Text(
                  GastronomyData.heroTitle,
                  style: text.headlineSmall?.copyWith(color: Colors.white),
                  maxLines: kMaxLinesHeroTitleMobile,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: kSpace4),
                Text(
                  GastronomyData.heroDescription,
                  style: text.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: kMaxLinesHeroDescMobile,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: kSpace8),
                Row(
                  children: <Widget>[
                    const ExcludeSemantics(
                      child: Icon(Icons.star, size: 16, color: AppColors.gold),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      GastronomyData.heroRating.toStringAsFixed(1),
                      style: text.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: kSpace12),
                    const ExcludeSemantics(
                      child: Icon(
                        Icons.place,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        GastronomyData.heroLocation,
                        style: text.bodySmall?.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}

/// Versión desktop: imagen + panel sólido (sin overlay).
class _HeroHorizontal extends StatelessWidget {
  const _HeroHorizontal();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      height: kHeroHeightDesktop,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusHero),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Image.asset(
              GastronomyData.heroImage,
              fit: BoxFit.cover,
              height: double.infinity,
              semanticLabel: GastronomyData.heroImageSemantic,
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return const ColoredBox(color: AppColors.terracottaDark);
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.terracottaDark,
              padding: const EdgeInsets.all(kSpace24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpace8,
                      vertical: kSpace4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(kRadiusBadge),
                    ),
                    child: Text(
                      'DESTACADO SEMANAL',
                      style: text.labelSmall?.copyWith(color: AppColors.ink),
                    ),
                  ),
                  const SizedBox(height: kSpace12),
                  Text(
                    GastronomyData.heroTitle,
                    style: text.displaySmall?.copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: kSpace8),
                  Text(
                    GastronomyData.heroDescription,
                    style: text.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    maxLines: kMaxLinesHeroDescDesktop,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: kSpace12),
                  Text(
                    '${GastronomyData.heroRating.toStringAsFixed(1)} · ${GastronomyData.heroLocation}',
                    style: text.bodySmall?.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
