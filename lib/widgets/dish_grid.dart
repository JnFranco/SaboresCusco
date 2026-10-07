import 'package:flutter/material.dart';

import '../models/dish.dart';
import '../utils/constants.dart';
import 'dish_card.dart';

/// Grid responsive de platos SIN `GridView` (decisión informe Sec 4.2).
///
/// Problema: `GridView` dentro de un `SingleChildScrollView` crea altura
/// no acotada (unbounded) y obliga a `shrinkWrap + NeverScrollable`,
/// que rompe el modelo de constraints y el rendimiento.
/// Decisión: `LayoutBuilder` local + `Column` de `Row`s con `Expanded`.
/// Cada card recibe ancho acotado `(ancho - gaps) / columnas`, por eso
/// `DishCard` nunca desborda a 273px.
///
/// Columnas (informe Sec 4.1, justificadas por card mínima ~273px):
/// - < 600  → 1 columna.
/// - 600-899 → 2 columnas.
/// - >= 900 → 3 columnas.
class DishGrid extends StatelessWidget {
  final List<Dish> dishes;

  /// Separación entre tarjetas (horizontal y vertical).
  static const double gap = kSpace16;

  const DishGrid({super.key, required this.dishes});

  /// Función pura y testeable: ancho disponible → columnas.
  /// Los bordes 600 y 900 son inclusivos hacia arriba.
  static int columnsForWidth(double maxWidth) {
    if (maxWidth >= kBreakpointDesktopMin) return 3;
    if (maxWidth >= kBreakpointMobileMax) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Si el ancho no está acotado (uso incorrecto), cae a 1 columna
        // en vez de romper: comportamiento defensivo, no solución visual.
        final double maxWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : 0;
        final int columns = columnsForWidth(maxWidth);

        final List<List<Dish>> rows = <List<Dish>>[];
        for (int i = 0; i < dishes.length; i += columns) {
          final int end =
              (i + columns > dishes.length) ? dishes.length : i + columns;
          rows.add(dishes.sublist(i, end));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int r = 0; r < rows.length; r++) ...<Widget>[
              if (r > 0) const SizedBox(height: gap),
              _GridRow(dishes: rows[r], columns: columns),
            ],
          ],
        );
      },
    );
  }
}

/// Una fila del grid: N cards con `Expanded` + relleno vacío si la última
/// fila queda incompleta (alinea a la izquierda, sin estirar cards).
class _GridRow extends StatelessWidget {
  final List<Dish> dishes;
  final int columns;

  const _GridRow({required this.dishes, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < columns; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: DishGrid.gap),
          if (i < dishes.length)
            Expanded(child: DishCard(dish: dishes[i]))
          else
            // Espaciador que ocupa el lugar de una card ausente.
            const Expanded(child: SizedBox.shrink()),
        ],
      ],
    );
  }
}
