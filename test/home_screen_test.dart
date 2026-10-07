import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabores_del_cusco/screens/home_screen.dart';
import 'package:sabores_del_cusco/utils/app_theme.dart';
import 'package:sabores_del_cusco/widgets/dish_card.dart';
import 'package:sabores_del_cusco/widgets/experience_card.dart';

/// Tests de Fase 4: la composición funciona en 390 / 768 / 1024.
///
/// Regla de fase: primero constraints correctos, el pulido visual viene
/// en Fase 6. Aquí solo se verifica presencia de secciones + ausencia de
/// excepciones de layout.
///
/// Nota metodológica: se usa `tester.view.physicalSize` (viewport real)
/// en vez de sobreescribir `MediaQuery`, para que el ancho que ve
/// `MediaQuery` y el ancho real de renderizado coincidan. Sobreescribir
/// solo el MediaQuery a 1024 con viewport de 800 produce un falso
/// overflow (layout desktop en pantalla móvil).
void main() {
  Future<void> pumpHome(WidgetTester tester, double width, double height) async {
    tester.view.physicalSize = Size(width, height);
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

  testWidgets('Home 390: header compacto + 6 platos + 3 experiencias',
      (WidgetTester tester) async {
    await pumpHome(tester, 390, 844);
    // Header compacto: título sí, subtítulo no.
    expect(find.text('Sabores del Cusco'), findsWidgets);
    expect(find.text('Guía gastronómica'), findsNothing);
    expect(find.text('Pachamanca a la tierra cusqueña'), findsOneWidget);
    expect(find.text('Platos destacados'), findsOneWidget);
    expect(find.text('Experiencias gastronómicas'), findsOneWidget);
    expect(find.byType(DishCard), findsNWidgets(6));
    expect(find.byType(ExperienceCard), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home 768: header con subtítulo, grid 2 col',
      (WidgetTester tester) async {
    await pumpHome(tester, 768, 1024);
    expect(find.text('Guía gastronómica'), findsOneWidget);
    expect(find.byType(DishCard), findsNWidgets(6));
    expect(find.byType(ExperienceCard), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home 1024: desktop con hero horizontal y experiencias en fila',
      (WidgetTester tester) async {
    await pumpHome(tester, 1024, 768);
    expect(find.text('Guía gastronómica'), findsOneWidget);
    expect(find.text('Pachamanca a la tierra cusqueña'), findsOneWidget);
    expect(find.byType(DishCard), findsNWidgets(6));
    expect(find.byType(ExperienceCard), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });
}
