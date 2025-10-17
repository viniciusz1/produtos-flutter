import 'package:flutter/material.dart';
import '../models/user.dart';
import 'assign_brands_screen.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    // Dados mockados de usuários
    setState(() {
      _users = [
        User(
          id: 1,
          name: 'João Silva',
          email: 'joao.silva@email.com',
          allowedBrandIds: [1, 2],
        ),
        User(
          id: 2,
          name: 'Maria Santos',
          email: 'maria.santos@email.com',
          allowedBrandIds: [1, 3, 4],
        ),
        User(
          id: 3,
          name: 'Pedro Oliveira',
          email: 'pedro.oliveira@email.com',
          allowedBrandIds: [],
        ),
        User(
          id: 4,
          name: 'Ana Costa',
          email: 'ana.costa@email.com',
          allowedBrandIds: [2, 3],
        ),
      ];
    });
  }

  void _navigateToAssignBrands(User user) async {
    final updatedUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(
        builder: (context) => AssignBrandsScreen(user: user),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        final index = _users.indexWhere((u) => u.id == updatedUser.id);
        if (index != -1) {
          _users[index] = updatedUser;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Usuários'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _users.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  user.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(user.email),
                  const SizedBox(height: 4),
                  Text(
                    '${user.allowedBrandIds.length} marca(s) atribuída(s)',
                    style: TextStyle(
                      color: user.allowedBrandIds.isEmpty
                          ? Colors.red[700]
                          : Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => _navigateToAssignBrands(user),
                tooltip: 'Atribuir marcas',
              ),
            ),
          );
        },
      ),
    );
  }
}

