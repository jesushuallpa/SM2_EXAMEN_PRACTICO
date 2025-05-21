import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await AuthService.getUserData();
    setState(() {
      _userData = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!AuthService.isUserLoggedIn()) {
      return const Center(child: Text('🔒 Inicia sesión para ver tu perfil'));
    }

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_userData == null) {
      return const Center(child: Text('No se pudo cargar el perfil.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('👤 Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${_userData!['nombre'] ?? 'Sin nombre'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Correo: ${_userData!['usuario'] ?? ''}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Teléfono: ${_userData!['telefono'] ?? 'No registrado'}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                AuthService.logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
