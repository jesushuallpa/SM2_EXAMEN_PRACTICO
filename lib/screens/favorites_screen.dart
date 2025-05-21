import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogged = AuthService.isUserLoggedIn();

    if (!isLogged) {
      return const Scaffold(
        body: Center(child: Text('Inicia sesión para ver tus favoritos')),
      );
    }

    return const Scaffold(body: Center(child: Text('Tus productos favoritos')));
  }
}
