import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Pantallas
import 'screens/main_screen.dart';
import 'screens/AdminDashboardScreen.dart';
import 'screens/catalog_screen.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp con Chatbot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RoleSelectorScreen(), // 👈 Pantalla inicial que muestra el diálogo
      routes: {
        '/home': (ctx) => const MainScreen(),
        '/admin': (ctx) => const AdminDashboardScreen(),
        '/catalog': (ctx) => CatalogScreen(),
        '/chat': (ctx) => const ChatScreen(),
      },
    );
  }
}

class RoleSelectorScreen extends StatefulWidget {
  const RoleSelectorScreen({super.key});

  @override
  State<RoleSelectorScreen> createState() => _RoleSelectorScreenState();
}

class _RoleSelectorScreenState extends State<RoleSelectorScreen> {
  @override
  void initState() {
    super.initState();
    // Mostrar el diálogo después de que la pantalla se construya
    WidgetsBinding.instance.addPostFrameCallback((_) => _showRoleDialog());
  }

  void _showRoleDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // obliga a seleccionar una opción
      builder: (context) => AlertDialog(
        title: const Text('Selecciona el rol'),
        content: const Text('¿Cómo deseas ingresar a la aplicación?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // cierra el diálogo
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
              );
            },
            child: const Text('pbi010'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // cierra el diálogo
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
              );
            },
            child: const Text('pbi002'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pantalla en blanco mientras se elige
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
