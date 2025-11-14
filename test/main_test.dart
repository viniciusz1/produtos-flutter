import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/main.dart';
import 'package:consulta/screens/login_screen.dart';

void main() {
  group('MyApp Tests', () {
    testWidgets('MyApp deve iniciar com LoginScreen', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Assert
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('MyApp deve ter título correto', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Get MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Assert
      expect(app.title, 'Imobiapp');
    });

    testWidgets('MyApp deve usar Material3', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Get MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Assert
      expect(app.theme?.useMaterial3, true);
    });

    testWidgets('MyApp deve ter tema configurado', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Get MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Assert
      expect(app.theme, isNotNull);
      expect(app.theme?.colorScheme, isNotNull);
    });

    testWidgets('MyApp deve configurar AppBar theme', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Get MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Assert
      expect(app.theme?.appBarTheme, isNotNull);
      expect(app.theme?.appBarTheme.foregroundColor, Colors.white);
    });
  });
}
