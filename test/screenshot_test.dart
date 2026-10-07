import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabores_del_cusco/screens/home_screen.dart';
import 'package:sabores_del_cusco/utils/app_theme.dart';

/// Herramienta Fase 6: exporta la Home real a PNG para inventario visual.
///
/// Ventanas: 390x844, 768x1024, 1280x800 (top + mid). Salida en
/// `build/screenshots/`. Usa runAsync para fuentes/imagen (tiempo real) y
/// pumps acotados en vez de pumpAndSettle (que no converge con cargas async).
void main() {
  Future<void> loadFonts() async {
    final String base =
        '${Platform.environment['USERPROFILE']}\\tools\\flutter\\bin\\cache\\artifacts\\material_fonts';
    final FontLoader roboto = FontLoader('RobotoTest');
    for (final String f in <String>[
      'roboto-regular.ttf',
      'roboto-medium.ttf',
      'roboto-bold.ttf',
    ]) {
      final ByteData bytes =
          ByteData.sublistView(File('$base\\$f').readAsBytesSync());
      roboto.addFont(Future<ByteData>.value(bytes));
    }
    await roboto.load();
    final ByteData icons = ByteData.sublistView(
      File('$base\\materialicons-regular.otf').readAsBytesSync(),
    );
    await (FontLoader('MaterialIcons')
          ..addFont(Future<ByteData>.value(icons)))
        .load();
  }

  Future<void> shot(
    WidgetTester tester,
    double width,
    double height,
    String name, {
    double scrollDown = 0,
  }) async {
    tester.view.physicalSize = Size(width, height);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.runAsync(loadFonts);
    final ThemeData theme = AppTheme.light.copyWith(
      textTheme: AppTheme.light.textTheme.apply(fontFamily: 'RobotoTest'),
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: const RepaintBoundary(
          key: Key('shot'),
          child: HomeScreen(),
        ),
      ),
    );
    // Deja tiempo real para que decodeen las imágenes JPEG.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 800)),
    );
    for (int i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 120));
    }
    if (scrollDown > 0) {
      await tester.drag(
        find.byType(SingleChildScrollView),
        Offset(0, -scrollDown),
      );
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 600)),
      );
      for (int i = 0; i < 4; i++) {
        await tester.pump(const Duration(milliseconds: 120));
      }
    }
    final (ui.Image image, ByteData? bytes) = (await tester.runAsync(() async {
      final RenderRepaintBoundary boundary = tester
          .element(find.byKey(const Key('shot')))
          .renderObject!
          as RenderRepaintBoundary;
      final ui.Image img = await boundary.toImage(pixelRatio: 1);
      final ByteData? data =
          await img.toByteData(format: ui.ImageByteFormat.png);
      return (img, data);
    }))!;
    expect(bytes, isNotNull, reason: 'no se pudo rasterizar $name');
    final Directory dir = Directory('build/screenshots');
    dir.createSync(recursive: true);
    File(
      '${dir.path}/$name.png',
    ).writeAsBytesSync(bytes!.buffer.asUint8List());
    image.dispose();
  }

  testWidgets('shots 390', (WidgetTester tester) async {
    await shot(tester, 390, 844, 'home_390_top');
    await shot(tester, 390, 844, 'home_390_mid', scrollDown: 900);
  });

  testWidgets('shots 768', (WidgetTester tester) async {
    await shot(tester, 768, 1024, 'home_768_top');
    await shot(tester, 768, 1024, 'home_768_mid', scrollDown: 1100);
  });

  testWidgets('shots 1280', (WidgetTester tester) async {
    await shot(tester, 1280, 800, 'home_1280_top');
    await shot(tester, 1280, 800, 'home_1280_mid', scrollDown: 800);
  });
}
