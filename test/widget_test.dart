import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_nacionales/features/home/home_page.dart';

void main() {
  testWidgets('La pantalla principal muestra sus secciones', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: HomePage()),
      ),
    );
    await tester.pump();
    expect(find.text('Metas Nacionales'), findsOneWidget);
    expect(find.text('Explora por pilar'), findsOneWidget);
    expect(find.text('Pilares de acción'), findsOneWidget);
  });
}
