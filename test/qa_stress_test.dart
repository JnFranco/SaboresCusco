import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabores_del_cusco/data/gastronomy_data.dart';
import 'package:sabores_del_cusco/models/dish.dart';
import 'package:sabores_del_cusco/models/experience.dart';
import 'package:sabores_del_cusco/screens/home_screen.dart';
import 'package:sabores_del_cusco/utils/app_theme.dart';
import 'package:sabores_del_cusco/widgets/dish_card.dart';
import 'package:sabores_del_cusco/widgets/experience_card.dart';

/// Auditoría Fase 5: robustez antes del pulido visual.
///
/// Cubre: contraste WCAG (calculado, no declarado), targets 48x48,
/// semántica con criterio, contenido EXTREMO deliberadamente horrible,
/// anchos 320/600/899/900 y landscape 844x390.
void main() {
  // ---------- 1. Contraste WCAG 2.1 (texto normal >= 4.5:1) ----------
  double luminance(Color c) {
    double channel(int v) {
      final double s = v / 255;
      // Fórmula WCAG exacta (misma que la verificación Python del informe).
      return s <= 0.04045 ? s / 12.92 : math.pow((s + 0.055) / 1.055, 2.4).toDouble();
    }

    return 0.2126 * channel((c.r * 255).round()) +
        0.7152 * channel((c.g * 255).round()) +
        0.0722 * channel((c.b * 255).round());
  }

  double ratio(Color a, Color b) {
    final double x = luminance(a), y = luminance(b);
    final double hi = x > y ? x : y, lo = x > y ? y : x;
    return (hi + 0.05) / (lo + 0.05);
  }

  test('pares de color usados en código cumplen WCAG AA', () {
    // Texto principal / secundario sobre fondo y superficie.
    expect(ratio(AppColors.ink, AppColors.background), greaterThan(4.5));
    expect(ratio(AppColors.inkSecondary, AppColors.background), greaterThan(4.0));
    expect(ratio(AppColors.ink, AppColors.surface), greaterThan(4.5));
    // Chip seleccionado: blanco sobre terracota (+ negrita, no solo color).
    expect(ratio(Colors.white, AppColors.terracotta), greaterThan(4.5));
    // Badge: tinta sobre dorado (nunca blanco sobre dorado: ratio 2.4).
    expect(ratio(AppColors.ink, AppColors.gold), greaterThan(4.5));
    // Panel hero desktop: blanco sobre terracota oscuro.
    expect(ratio(Colors.white, AppColors.terracottaDark), greaterThan(4.5));
  });

  // ---------- 2. Targets táctiles 48x48 ----------
  testWidgets('acciones del header miden 48x48', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );
    await tester.pumpAndSettle();
    for (final icon in <IconData>[Icons.search, Icons.menu]) {
      // Se mide el IconButton (área táctil), no el Icon de 24px.
      final Finder button = find.ancestor(
        of: find.byIcon(icon),
        matching: find.byType(IconButton),
      );
      final Size size = tester.getSize(button);
      expect(size.width, 48.0, reason: 'ancho $icon');
      expect(size.height, 48.0, reason: 'alto $icon');
    }
    expect(tester.takeException(), isNull);
  });

  // ---------- 3. Semántica con criterio ----------
  testWidgets('títulos de sección son headers; imágenes tienen etiqueta',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );
    await tester.pumpAndSettle();
    final SemanticsNode titleNode =
        tester.getSemantics(find.text('Platos destacados'));
    expect(titleNode.flagsCollection.isHeader, isTrue);
    // Imagen informativa anuncia su contenido (no el nombre del archivo).
    expect(find.bySemanticsLabel('Plato de chiri uchu con cuy al horno, torreja de maíz y cochayuyo'),
        findsOneWidget);
    // Estrella decorativa excluida: el número existe una sola vez.
    expect(find.text('4.8'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // ---------- 4. Contenido extremo ----------
  const Dish horribleDish = Dish(
    name: 'Chiri Uchu tradicional cusqueño preparado con ingredientes '
        'andinos seleccionados',
    description:
        'Mezcla festiva de cuy al horno, gallina criolla, chorizo cusqueño, '
        'maíz tostado, queso fresco, torreja de maíz, algas y rocoto molido '
        'que se sirve fría durante la celebración del Corpus Christi en la '
        'plaza mayor de la ciudad imperial del Cusco.',
    imagePath: 'assets/images/chiri_uchu.jpg',
    imageSemanticLabel: 'Plato de chiri uchu con cuy al horno, torreja de maíz y cochayuyo',
    category: 'Platos',
    rating: 4.8,
    location: 'Asociación de picanterías tradicionales, San Sebastián, Cusco',
    isFeatured: true,
  );

  const Experience horribleExperience = Experience(
    title: 'Recorrido gastronómico completo por el mercado central de abastos',
    description:
        'Caminata guiada entre puestos de jugos naturales, panes chuta '
        'recién horneados, quesos andinos, hierbas aromáticas y dulces '
        'tradicionales con degustación incluida durante toda la mañana.',
    imagePath: 'assets/images/mercado_san_pedro.jpg',
    imageSemanticLabel: 'Pasillo del mercado San Pedro con frutas',
    location: 'Mercado Central de San Pedro, Cusco',
    duration: 'Toda la mañana',
  );

  Widget wrapInWidth(Widget child, double width) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(child: SizedBox(width: width, child: child)),
        ),
      ),
    );
  }

  for (final double w in <double>[273, 320, 390, 600, 899, 900, 1024]) {
    testWidgets('DishCard extremo a $w px sobrevive', (WidgetTester tester) async {
      tester.view.physicalSize = Size(w, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(wrapInWidth(const DishCard(dish: horribleDish), w));
      await tester.pumpAndSettle();
      expect(find.byType(DishCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ExperienceCard extremo a $w px sobrevive',
        (WidgetTester tester) async {
      tester.view.physicalSize = Size(w, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        wrapInWidth(
          const ExperienceCard(experience: horribleExperience),
          w,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ExperienceCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  // ---------- 5. HomeScreen en anchos extra + landscape ----------
  Future<void> pumpHome(WidgetTester tester, double w, double h) async {
    tester.view.physicalSize = Size(w, h);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
    );
    await tester.pumpAndSettle();
  }

  for (final Size s in <Size>[
    const Size(320, 568), // iPhone SE: Wrap al límite + hero Stack bajo.
    const Size(600, 960), // borde inferior tablet: grid 2 col.
    const Size(899, 1200), // borde superior tablet: aún 2 col + Stack.
    const Size(900, 1200), // borde desktop: hero Row + 3 col.
    const Size(844, 390), // landscape: scroll vertical absorbe altura.
  ]) {
    testWidgets('Home ${s.width.toInt()}x${s.height.toInt()} sin overflow',
        (WidgetTester tester) async {
      await pumpHome(tester, s.width, s.height);
      expect(find.byType(DishCard), findsNWidgets(6));
      expect(
        find.byType(ExperienceCard),
        findsNWidgets(3),
        reason: 'las 3 experiencias existen (Column o Row)',
      );
      expect(find.text('8 categorías de la cocina cusqueña'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Wrap de 8 chips cabe sin overflow a 320px', (WidgetTester tester) async {
    await pumpHome(tester, 320, 568);
    for (final c in GastronomyData.categories) {
      expect(find.text(c.label), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
}
