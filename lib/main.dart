import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Pastikan file ini ada

void main() {
  runApp(const LesPrivateApp());
}

class LesPrivateApp extends StatelessWidget {
  // Format terbaru (Garis biru hilang)
  const LesPrivateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jasa Les Private',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      // Pastikan LoginScreen sudah di-import di paling atas
      home: const LoginScreen(),
    );
  }
}