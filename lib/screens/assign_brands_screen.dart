import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/brand.dart';

class AssignBrandsScreen extends StatefulWidget {
  final User user;

  const AssignBrandsScreen({
    super.key,
    required this.user,
  });

  @override
  State<AssignBrandsScreen> createState() => _AssignBrandsScreenState();
}

class _AssignBrandsScreenState extends State<AssignBrandsScreen> {
  late List<int> _selectedBrandIds;
  List<Brand> _availableBrands = [];

  @override
  void initState() {
    super.initState();
    _selectedBrandIds = List.from(widget.user.allowedBrandIds);
    _loadBrands();
  }

  void _loadBrands() {
    // Dados mockados de imobiliárias
    setState(() {
      _availableBrands = [
        Brand(
          id: 1,
          name: 'Imobiliária Costa',
          logoUrl: 'https://via.placeholder.com/80?text=Costa',
        ),
        Brand(
          id: 2,
          name: 'Imóveis & Cia',
          logoUrl: 'https://via.placeholder.com/80?text=I&C',
        ),
        Brand(
          id: 3,
          name: 'Lar Perfeito',
          logoUrl: 'https://via.placeholder.com/80?text=Lar',
        ),
        Brand(
          id: 4,
          name: 'Residencial Prime',
          logoUrl: 'https://via.placeholder.com/80?text=Prime',
        ),
        Brand(
          id: 5,
          name: 'Casa Fácil',
          logoUrl: 'https://via.placeholder.com/80?text=Casa',
        ),
      ];
    });
  }

  void _toggleBrand(int brandId) {
    setState(() {
      if (_selectedBrandIds.contains(brandId)) {
        _selectedBrandIds.remove(brandId);
      } else {
        _selectedBrandIds.add(brandId);
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedBrandIds = _availableBrands.map((b) => b.id).toList();
    });
  }

  void _deselectAll() {
    setState(() {
      _selectedBrandIds.clear();
    });
  }

  void _saveAndReturn() {
    final updatedUser = widget.user.copyWith(
      allowedBrandIds: _selectedBrandIds,
    );
    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atribuir Imobiliárias'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveAndReturn,
            tooltip: 'Salvar',
          ),
        ],
      ),
      body: Column(
        children: [
          // Cabeçalho com informações do usuário
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        widget.user.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${_selectedBrandIds.length} de ${_availableBrands.length} imobiliárias selecionadas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Botões de ação rápida
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectAll,
                    icon: const Icon(Icons.select_all),
                    label: const Text('Selecionar Todas'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _deselectAll,
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpar Seleção'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lista de imobiliárias
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _availableBrands.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final brand = _availableBrands[index];
                final isSelected = _selectedBrandIds.contains(brand.id);

                return Card(
                  elevation: isSelected ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => _toggleBrand(brand.id),
                    title: Text(
                      brand.name,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    secondary: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          brand.logoUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.business,
                              color: Colors.grey[400],
                              size: 30,
                            );
                          },
                        ),
                      ),
                    ),
                    activeColor: Theme.of(context).colorScheme.primary,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                );
              },
            ),
          ),

          // Botão de salvar fixo no rodapé
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _saveAndReturn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Salvar Atribuições',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
