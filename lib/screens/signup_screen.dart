import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  // Format terbaru (Super Parameter)
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Tampilkan Dialog Sukses
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Pendaftaran Berhasil"),
          content: const Text("Akun Anda telah dibuat. Silakan login."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup Dialog
                Navigator.pop(context); // Kembali ke Login Screen
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Akun Baru"),
        backgroundColor: Colors.white,
        // foregroundColor mungkin merah di Flutter versi sangat lama
        // Jika merah, hapus baris foregroundColor ini.
        foregroundColor: Colors.black, 
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Lengkapi Data Diri",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // Nama Lengkap
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => (val == null || val.isEmpty) ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => (val == null || !val.contains('@')) ? "Email tidak valid" : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => (val == null || val.length < 6) ? "Minimal 6 karakter" : null,
              ),
              const SizedBox(height: 16),

              // Konfirmasi Password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => (val == null || val.isEmpty) ? "Konfirmasi password wajib diisi" : null,
              ),
              const SizedBox(height: 30),

              // Tombol Daftar
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "DAFTAR SEKARANG",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}