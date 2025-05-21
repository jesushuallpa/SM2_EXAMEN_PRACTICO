import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Pantallas de tu app
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/main_screen.dart';
import 'screens/register_screen.dart';
import 'screens/AdminDashboardScreen.dart';
import 'screens/chat_screen.dart'; // <-- Asegúrate de tener esta pantalla

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(); // Solo si estás usando variables de entorno
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp con Chatbot',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const LoginScreen(),
        '/login': (ctx) => const LoginScreen(), // 👈 Agregada
        '/register': (context) => const RegisterScreen(),
        '/home': (ctx) => const MainScreen(),
        '/catalog': (ctx) => CatalogScreen(),
        '/chat': (ctx) => const ChatScreen(), // <-- Ruta para el chatbot
      },
    );
  }
}
