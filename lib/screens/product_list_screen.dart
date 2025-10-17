import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'user_management_screen.dart';
import 'login_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Logout'),
          content: const Text('Deseja realmente sair do aplicativo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProductList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserManagementScreen(),
                ),
              );
            },
            tooltip: 'Gerenciar Usuários',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }

  List<Product> _getProductList() {
    return [
      Product(
        id: 1,
        name: 'Notebook Dell',
        description: 'Notebook com processador i7, 16GB RAM',
        price: 3499.99,
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
      ),
      Product(
        id: 2,
        name: 'Mouse Logitech',
        description: 'Mouse sem fio com sensor óptico',
        price: 89.90,
        imageUrl: 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=400',
      ),
      Product(
        id: 3,
        name: 'Teclado Mecânico',
        description: 'Teclado mecânico RGB com switches azuis',
        price: 299.99,
        imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400',
      ),
      Product(
        id: 4,
        name: 'Monitor LG 24"',
        description: 'Monitor Full HD IPS 24 polegadas',
        price: 699.00,
        imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=400',
      ),
      Product(
        id: 5,
        name: 'Headset Gamer',
        description: 'Headset com som surround 7.1',
        price: 249.90,
        imageUrl: 'https://images.unsplash.com/photo-1599669454699-248893623440?w=400',
      ),
      Product(
        id: 6,
        name: 'Webcam HD',
        description: 'Webcam 1080p com microfone embutido',
        price: 199.00,
        imageUrl: 'https://images.unsplash.com/photo-1588508065123-287b28e013da?w=400',
      ),
      Product(
        id: 7,
        name: 'SSD 480GB',
        description: 'SSD SATA III com velocidade de leitura 550MB/s',
        price: 279.99,
        imageUrl: 'https://images.unsplash.com/photo-1531492746076-161ca9bcad58?w=400',
      ),
      Product(
        id: 8,
        name: 'Cadeira Gamer',
        description: 'Cadeira ergonômica com ajuste de altura',
        price: 899.00,
        imageUrl: 'https://images.unsplash.com/photo-1598550476439-6847785fcea6?w=400',
      ),
      Product(
        id: 9,
        name: 'Mesa para PC',
        description: 'Mesa com suporte para monitor e teclado',
        price: 449.90,
        imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=400',
      ),
      Product(
        id: 10,
        name: 'Hub USB 3.0',
        description: 'Hub com 4 portas USB 3.0',
        price: 59.90,
        imageUrl: 'https://images.unsplash.com/photo-1625948515291-69613efd103f?w=400',
      ),
    ];
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                product.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 120,
                    height: 120,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _formatPrice(product.price),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(price);
  }
}
