import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('User deve ser criado com todos os campos', () {
      // Arrange & Act
      final user = User(
        id: 1,
        name: 'João Silva',
        email: 'joao@example.com',
        allowedBrandIds: [1, 2, 3],
      );

      // Assert
      expect(user.id, 1);
      expect(user.name, 'João Silva');
      expect(user.email, 'joao@example.com');
      expect(user.allowedBrandIds, [1, 2, 3]);
    });

    test('User deve ter lista vazia de brands por padrão', () {
      // Arrange & Act
      final user = User(
        id: 2,
        name: 'Maria Santos',
        email: 'maria@example.com',
      );

      // Assert
      expect(user.allowedBrandIds, isEmpty);
    });

    test('User copyWith deve manter valores não alterados', () {
      // Arrange
      final user = User(
        id: 1,
        name: 'João Silva',
        email: 'joao@example.com',
        allowedBrandIds: [1, 2],
      );

      // Act
      final updatedUser = user.copyWith(name: 'João Souza');

      // Assert
      expect(updatedUser.id, 1);
      expect(updatedUser.name, 'João Souza');
      expect(updatedUser.email, 'joao@example.com');
      expect(updatedUser.allowedBrandIds, [1, 2]);
    });

    test('User copyWith deve atualizar todos os campos', () {
      // Arrange
      final user = User(
        id: 1,
        name: 'João Silva',
        email: 'joao@example.com',
        allowedBrandIds: [1, 2],
      );

      // Act
      final updatedUser = user.copyWith(
        id: 2,
        name: 'Maria Santos',
        email: 'maria@example.com',
        allowedBrandIds: [3, 4, 5],
      );

      // Assert
      expect(updatedUser.id, 2);
      expect(updatedUser.name, 'Maria Santos');
      expect(updatedUser.email, 'maria@example.com');
      expect(updatedUser.allowedBrandIds, [3, 4, 5]);
    });

    test('User copyWith deve permitir lista vazia de brands', () {
      // Arrange
      final user = User(
        id: 1,
        name: 'João Silva',
        email: 'joao@example.com',
        allowedBrandIds: [1, 2, 3],
      );

      // Act
      final updatedUser = user.copyWith(allowedBrandIds: []);

      // Assert
      expect(updatedUser.allowedBrandIds, isEmpty);
    });
  });
}

