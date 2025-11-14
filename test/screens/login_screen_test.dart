import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/screens/login_screen.dart';
import 'package:consulta/screens/product_list_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen deve exibir todos os elementos', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Assert
      expect(find.text('Imobiapp'), findsOneWidget);
      expect(find.text('Faça login para continuar'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);
    });

    testWidgets('LoginScreen deve mostrar ícone de imóvel', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.house), findsOneWidget);
    });

    testWidgets('LoginScreen deve validar campos vazios', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Act
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Por favor, insira seu email'), findsOneWidget);
      expect(find.text('Por favor, insira sua senha'), findsOneWidget);
    });

    testWidgets('LoginScreen deve permitir entrada de texto no email', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Act
      final emailField = find.widgetWithText(TextFormField, 'Email');
      await tester.enterText(emailField, 'teste@email.com');
      await tester.pump();

      // Assert
      expect(find.text('teste@email.com'), findsOneWidget);
    });

    testWidgets('LoginScreen deve permitir entrada de texto na senha', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Act
      final passwordField = find.widgetWithText(TextFormField, 'Senha');
      await tester.enterText(passwordField, 'senha123');
      await tester.pump();

      // Assert
      expect(find.text('senha123'), findsOneWidget);
    });

    testWidgets('LoginScreen deve alternar visibilidade da senha', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Act - encontrar o campo de senha
      final passwordField = find.widgetWithText(TextFormField, 'Senha');
      await tester.enterText(passwordField, 'senha123');
      await tester.pump();

      // Verificar que o ícone de visibilidade existe
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tocar no ícone de visibilidade
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();

      // Assert - verificar que o ícone mudou para visibility_off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    });

    testWidgets('LoginScreen deve navegar para ProductListScreen ao fazer login', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Act - preencher os campos
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'teste@email.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), 'senha123');
      await tester.pump();

      // Tocar no botão de login
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();

      // Assert - verificar que navegou para a tela de imóveis
      expect(find.byType(ProductListScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('LoginScreen deve ter ícones nos campos de entrada', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outlined), findsOneWidget);
    });
  });
}
