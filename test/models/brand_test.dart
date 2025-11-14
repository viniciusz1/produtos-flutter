import 'package:flutter_test/flutter_test.dart';
import 'package:consulta/models/brand.dart';

void main() {
  group('Brand Model Tests', () {
    test('Brand deve ser criado com todos os campos', () {
      // Arrange & Act
      final brand = Brand(
        id: 1,
        name: 'Dell',
        logoUrl: 'https://example.com/dell-logo.png',
      );

      // Assert
      expect(brand.id, 1);
      expect(brand.name, 'Dell');
      expect(brand.logoUrl, 'https://example.com/dell-logo.png');
    });

    test('Brand deve aceitar nomes diferentes', () {
      // Arrange & Act
      final brands = [
        Brand(id: 1, name: 'Apple', logoUrl: 'url1'),
        Brand(id: 2, name: 'Samsung', logoUrl: 'url2'),
        Brand(id: 3, name: 'LG', logoUrl: 'url3'),
      ];

      // Assert
      expect(brands.length, 3);
      expect(brands[0].name, 'Apple');
      expect(brands[1].name, 'Samsung');
      expect(brands[2].name, 'LG');
    });

    test('Brand deve aceitar logoUrl vazio', () {
      // Arrange & Act
      final brand = Brand(
        id: 1,
        name: 'GenericBrand',
        logoUrl: '',
      );

      // Assert
      expect(brand.logoUrl, isEmpty);
    });
  });
}

