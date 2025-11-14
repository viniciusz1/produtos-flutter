import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/main.dart';

void main() {
  group('Teste de Integração - Fluxo Completo', () {
    testWidgets('Fluxo completo: Login -> Lista de Imóveis -> Logout', (WidgetTester tester) async {
      // Arrange - Iniciar o app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Assert - Verificar que está na tela de login
      expect(find.text('Imobiapp'), findsOneWidget);
      expect(find.text('Faça login para continuar'), findsOneWidget);

      // Act - Fazer login
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'usuario@teste.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'),
        'senha123',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();

      // Assert - Verificar que está na tela de imóveis
      expect(find.text('Imóveis'), findsOneWidget);
      expect(find.text('Apartamento 2 quartos - Centro'), findsOneWidget);

      // Act - Fazer logout
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      // Assert - Verificar diálogo de confirmação
      expect(find.text('Confirmar Logout'), findsOneWidget);

      // Act - Confirmar logout
      await tester.tap(find.text('Sair'));
      await tester.pumpAndSettle();

      // Assert - Verificar que voltou para tela de login
      expect(find.text('Faça login para continuar'), findsOneWidget);
    });

    testWidgets('Fluxo: Login -> Gerenciar Usuários -> Voltar', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Fazer login
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'admin@teste.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'),
        'admin123',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();

      // Act - Ir para gerenciamento de usuários
      await tester.tap(find.byIcon(Icons.people));
      await tester.pumpAndSettle();

      // Assert - Verificar que está na tela de usuários
      expect(find.text('Gerenciamento de Usuários'), findsOneWidget);

      // Act - Voltar
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Assert - Verificar que voltou para lista de imóveis
      expect(find.text('Imóveis'), findsOneWidget);
    });

    testWidgets('Validação de campos vazios no login', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Tentar fazer login sem preencher campos
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();

      // Assert - Verificar mensagens de erro
      expect(find.text('Por favor, insira seu email'), findsOneWidget);
      expect(find.text('Por favor, insira sua senha'), findsOneWidget);

      // Assert - Verificar que ainda está na tela de login
      expect(find.text('Faça login para continuar'), findsOneWidget);
    });

    testWidgets('Alternância de visibilidade da senha', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Preencher senha
      final passwordField = find.widgetWithText(TextFormField, 'Senha');
      await tester.enterText(passwordField, 'minhasenha');
      await tester.pump();

      // Assert - Verificar que ícone de visibilidade existe
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Act - Clicar no ícone de visibilidade
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();

      // Assert - Verificar que ícone mudou para visibility_off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);

      // Act - Clicar novamente no ícone
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      // Assert - Verificar que ícone voltou para visibility
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);
    });
  });
}
