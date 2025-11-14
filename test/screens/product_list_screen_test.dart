import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/screens/product_list_screen.dart';
import 'package:consulta/screens/login_screen.dart';
import 'package:consulta/screens/user_management_screen.dart';

void main() {
  group('ProductListScreen Widget Tests', () {
    testWidgets('ProductListScreen deve exibir AppBar com título', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Assert
      expect(find.text('Imóveis'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('ProductListScreen deve exibir ícones de ação na AppBar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.people), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('ProductListScreen deve exibir lista de imóveis', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Apartamento 2 quartos - Centro'), findsOneWidget);
      expect(find.text('Casa com quintal - Bairro residencial'), findsOneWidget);
    });

    testWidgets('ProductListScreen deve navegar para UserManagementScreen', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.people));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(UserManagementScreen), findsOneWidget);
    });

    testWidgets('ProductListScreen deve mostrar diálogo de logout', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Confirmar Logout'), findsOneWidget);
      expect(find.text('Deseja realmente sair do aplicativo?'), findsOneWidget);
      expect(find.text('Cancelar'), findsOneWidget);
      expect(find.text('Sair'), findsOneWidget);
    });

    testWidgets('ProductListScreen deve cancelar logout', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProductListScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('ProductListScreen deve confirmar logout e voltar para login', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sair'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(ProductListScreen), findsNothing);
    });

    testWidgets('ProductListScreen deve exibir múltiplos imóveis', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Assert - verificar alguns imóveis da lista
      expect(find.text('Apartamento 2 quartos - Centro'), findsOneWidget);
      expect(find.text('Casa com quintal - Bairro residencial'), findsOneWidget);
      expect(find.text('Loft moderno - Região central'), findsOneWidget);

      // Scroll para ver mais
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();

      expect(find.text('Kitnet próxima à universidade'), findsOneWidget);
    });

    testWidgets('ProductListScreen deve ter estrutura de Cards', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      // Assert
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('ProductListScreen filtro por texto funciona', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductListScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Precondition: lista contém o item completo
      expect(find.text('Apartamento 2 quartos - Centro'), findsOneWidget);
      expect(find.text('Kitnet próxima à universidade'), findsOneWidget);

      // Act: digitar termo que só corresponde ao primeiro imóvel
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);
      await tester.enterText(searchField, 'Apartamento');
      await tester.pumpAndSettle();

      // Assert: somente o item correspondente permanece visível
      expect(find.text('Apartamento 2 quartos - Centro'), findsOneWidget);
      expect(find.text('Kitnet próxima à universidade'), findsNothing);

      // Act: limpar busca
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      // Assert: lista restaurada
      expect(find.text('Kitnet próxima à universidade'), findsOneWidget);
    });
  });
}
