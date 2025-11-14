// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/main.dart';
import 'package:consulta/screens/login_screen.dart';

void main() {
  testWidgets('App deve iniciar e exibir tela de login', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that login screen is displayed
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Imobiapp'), findsOneWidget);
    expect(find.text('Faça login para continuar'), findsOneWidget);
  });
}
