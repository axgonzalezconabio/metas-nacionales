import 'package:flutter_test/flutter_test.dart';
import 'package:metas_nacionales/main.dart';

void main() {
  testWidgets(
    'La aplicación inicia correctamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MetasNacionalesApp());

      expect(
        find.text('Metas Nacionales de Biodiversidad'),
        findsOneWidget,
      );
    },
  );
}