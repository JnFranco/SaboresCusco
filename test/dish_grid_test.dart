import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabores_del_cusco/data/gastronomy_data.dart';
import 'package:sabores_del_cusco/widgets/dish_card.dart';
import 'package:sabores_del_cusco/widgets/dish_grid.dart';

/// Tests de Fase 3: el responsive como COMPORTAMIENTO, no como matemática.
///
/// Matriz exigida:
/// 273→1, 390→1, 599→1, 600→2, 768→2, 899→2, 900→3, 1024→3.
/// Los bordes 599/600 y 899/900 detectan implementaciones con `>` en vez
/// de `>=` (error típico que muestra 1 col a 600px o 2 col a 900px).
void main() {
  test('columnsForWidth cubre la matriz + bordes', () {
    expect(DishGrid.columnsForWidth(273), 1);
    expect(DishGrid.columnsForWidth(390), 1);
    expect(DishGrid.columnsForWidth(599), 1);
    expect(DishGrid.columnsForWidth(600), 2);
    expect(DishGrid.columnsForWidth(768), 2);
    expect(DishGrid.columnsForWidth(899), 2);
    expect(DishGrid.columnsForWidth(900), 3);
    expect(DishGrid.columnsForWidth(1024), 3);
  });

  for (final double width in <double>[273, 390, 599, 600, 768, 899, 900, 1024]) {
    testWidgets('DishGrid a $width px: 6 cards sin excepciones',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: width,
                  child: const DishGrid(dishes: GastronomyData.dishes),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Las 6 cards existen (aunque alguna quede fuera de viewport,
      // pumpAndSettle las construye: Column+Row no hace lazy-loading,
      // a diferencia de GridView).
      expect(find.byType(DishCard), findsNWidgets(6));
      expect(tester.takeException(), isNull);
    });
  }
}
