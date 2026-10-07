import 'package:flutter/material.dart';

import '../data/gastronomy_data.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/app_header.dart';
import '../widgets/category_chip.dart';
import '../widgets/dish_grid.dart';
import '../widgets/experience_card.dart';
import '../widgets/hero_section.dart';
import '../widgets/section_title.dart';

/// Pantalla principal (Fase 6: composición + pulido visual).
///
/// Ritmo vertical (P3): intra-sección 12, inter-sección 32, header→hero 24.
///
/// Responsabilidades del `MediaQuery` GLOBAL (informe Sec 4.1), distintas
/// del `LayoutBuilder` local de `DishGrid` y `HeroSection`:
/// - padding lateral 16 / 20 / 24 según ancho de pantalla.
/// - `compact` del header (subtítulo visible si >= 600).
/// - experiencias en `Row` de 3 si >= 900, `Column` si no.
/// - contenido centrado con `maxWidth: 1100` en desktop.
///
/// Estructura anti-overflow: `SafeArea > SingleChildScrollView > Column`
/// con `crossAxisAlignment.stretch` (ancho acotado en todo el árbol).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isTablet = screenWidth >= kBreakpointMobileMax;
    final bool isDesktop = screenWidth >= kBreakpointDesktopMin;
    final double lateralPadding =
        isDesktop ? kPaddingDesktop : isTablet ? kPaddingTablet : kPaddingMobile;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? kMaxContentWidth : double.infinity,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: lateralPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: kSpace8),
                    AppHeader(compact: !isTablet),
                    // P3: el hero domina; respira más que el resto (24).
                    const SizedBox(height: kSpace24),
                    const HeroSection(),
                    const SizedBox(height: kSpace32),
                    const SectionTitle(
                      title: 'Explora por antojo',
                      subtitle: '8 categorías de la cocina cusqueña',
                    ),
                    const SizedBox(height: kSpace12),
                    Wrap(
                      spacing: kSpace8,
                      runSpacing: kSpace8,
                      children: <Widget>[
                        for (final c in GastronomyData.categories)
                          CategoryChip(category: c),
                      ],
                    ),
                    const SizedBox(height: kSpace32),
                    const SectionTitle(
                      title: 'Platos destacados',
                      subtitle: '6 platos emblemáticos para probar',
                    ),
                    const SizedBox(height: kSpace12),
                    const DishGrid(dishes: GastronomyData.dishes),
                    const SizedBox(height: kSpace32),
                    const SectionTitle(
                      title: 'Experiencias gastronómicas',
                      subtitle: 'Mercados, picanterías y festividades',
                    ),
                    const SizedBox(height: kSpace12),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int i = 0;
                              i < GastronomyData.experiences.length;
                              i++) ...<Widget>[
                            if (i > 0) const SizedBox(width: kSpace16),
                            Expanded(
                              child: ExperienceCard(
                                experience: GastronomyData.experiences[i],
                              ),
                            ),
                          ],
                        ],
                      )
                    else
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (int i = 0;
                              i < GastronomyData.experiences.length;
                              i++) ...<Widget>[
                            if (i > 0) const SizedBox(height: kSpace16),
                            ExperienceCard(
                              experience: GastronomyData.experiences[i],
                            ),
                          ],
                        ],
                      ),
                    const SizedBox(height: kSpace32),
                    Container(
                      padding: const EdgeInsets.all(kSpace16),
                      decoration: BoxDecoration(
                        color: AppColors.terracottaDark,
                        borderRadius: BorderRadius.circular(kRadiusCard),
                      ),
                      child: Text(
                        'Sabores del Cusco · Interfaz estática IF616BIN',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: kSpace32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
