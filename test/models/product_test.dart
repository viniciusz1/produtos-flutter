import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('Product deve ser criado com todos os campos', () {
      // Arrange & Act
      final product = Product(
        id: 1,
        name: 'Notebook Dell',
        description: 'Notebook com processador i7',
        price: 3499.99,
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(product.id, 1);
      expect(product.name, 'Notebook Dell');
      expect(product.description, 'Notebook com processador i7');
      expect(product.price, 3499.99);
      expect(product.imageUrl, 'https://example.com/image.jpg');
    });

    test('Product deve aceitar preço zero', () {
      // Arrange & Act
      final product = Product(
        id: 2,
        name: 'Produto Grátis',
        description: 'Produto promocional',
        price: 0.0,
        imageUrl: 'https://example.com/free.jpg',
      );

      // Assert
      expect(product.price, 0.0);
    });

    test('Product deve aceitar preços decimais', () {
      // Arrange & Act
      final product = Product(
        id: 3,
        name: 'Mouse',
        description: 'Mouse sem fio',
        price: 89.99,
        imageUrl: 'https://example.com/mouse.jpg',
      );

      // Assert
      expect(product.price, 89.99);
    });
  });
}

