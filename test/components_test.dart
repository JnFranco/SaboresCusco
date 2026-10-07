import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabores_del_cusco/data/gastronomy_data.dart';
import 'package:sabores_del_cusco/models/dish.dart';
import 'package:sabores_del_cusco/widgets/category_chip.dart';
import 'package:sabores_del_cusco/widgets/dish_card.dart';
import 'package:sabores_del_cusco/widgets/experience_card.dart';
import 'package:sabores_del_cusco/widgets/section_title.dart';

/// Tests de Fase 2: componentes aislados en anchos controlados.
///
/// Verifican render + ausencia de excepciones de layout (overflow) en
/// 273px (límite 3 columnas), 320px y 390px (móvil).

Widget _wrap(Widget child, double width) {
  return MaterialApp(
    home: Scaffold(
      body: Center(child: SizedBox(width: width, child: child)),
    ),
  );
}

const Dish stressDish = Dish(
  name: 'Cuy al horno con relleno andino de hierbas y papas nativas del valle',
  description:
      'Cuy crocante al horno de leña acompañado de papas doradas, ensalada '
      'criolla, crema de huacatay de la casa y mote de la chacra.',
  imagePath: 'assets/images/cuy_horno.jpg',
  imageSemanticLabel: 'Cuy entero al horno con papas doradas',
  category: 'Platos',
  rating: 4.9,
  location: 'Picantería La Chomba, San Sebastián, Cusco',
  isFeatured: true,
);

void main() {
  for (final double width in <double>[273, 320, 390]) {
    testWidgets('DishCard $width px renderiza sin excepciones',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(const DishCard(dish: stressDish), width));
      await tester.pumpAndSettle();
      expect(find.textContaining('Cuy al horno'), findsOneWidget);
      expect(find.text('4.9'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ExperienceCard $width px renderiza sin excepciones',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrap(
          ExperienceCard(experience: GastronomyData.experiences[0]),
          width,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Mercado San Pedro'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Wrap de 8 chips en 320px no da overflow', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final c in GastronomyData.categories)
                    CategoryChip(category: c),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Platos'), findsOneWidget);
    expect(find.text('Experiencias'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SectionTitle muestra título + subtítulo', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionTitle(title: 'Platos', subtitle: '6 platos'),
        ),
      ),
    );
    expect(find.text('Platos'), findsOneWidget);
    expect(find.text('6 platos'), findsOneWidget);
  });
}
