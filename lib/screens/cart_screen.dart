import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogged = AuthService.isUserLoggedIn();

    if (!isLogged) {
      return const Scaffold(
        body: Center(
          child: Text(
            '🔒 Inicia sesión para ver tu carrito de compras',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    // Simulación de carrito con productos
    final List<Map<String, dynamic>> carritoEjemplo = [
      {"nombre": "Casaca Jean", "precio": 89.90},
      {"nombre": "Polo Oversize", "precio": 59.90},
    ];

    final total = carritoEjemplo.fold<double>(
      0,
      (suma, item) => suma + item['precio'] as double,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('🛒 Carrito de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...carritoEjemplo.map(
              (item) => ListTile(
                title: Text(item['nombre']),
                trailing: Text('S/ ${item['precio'].toStringAsFixed(2)}'),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: S/ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Compra simulada')),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text('Finalizar compra'),
            ),
          ],
        ),
      ),
    );
  }
}
