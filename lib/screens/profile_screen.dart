import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // WAJIB ADA: Plugin untuk buka WA/Email
import 'login_screen.dart'; 

// ==========================================
// 1. HALAMAN UTAMA PROFIL
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(child: const Text("Batal"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text("Ya, Keluar", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300?img=12"),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Siswa Teladan", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("siswa@sekolah.id", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            _buildProfileMenu(context, Icons.person, "Edit Profil", const EditProfileScreen()),
            _buildProfileMenu(context, Icons.lock, "Ganti Password", const ChangePasswordScreen()),
            _buildProfileMenu(context, Icons.notifications, "Notifikasi", const NotificationScreen()),
            _buildProfileMenu(context, Icons.help, "Bantuan & CS", const HelpScreen()),
            
            const SizedBox(height: 20),
            
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              tileColor: Colors.red.withOpacity(0.1),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Keluar Aplikasi", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () => _handleLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, IconData icon, String title, Widget destination) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN BANTUAN & CS (FITUR WA & EMAIL)
// ==========================================
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // FUNGSI BUKA WHATSAPP
  Future<void> _launchWA() async {
  // 1. Ubah String jadi Uri
  final Uri url = Uri.parse('https://wa.me/6281234567890'); 
  
  // 2. Jalankan dengan mode External Application (membuka aplikasi WA langsung)
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Tidak bisa membuka $url');
  }
}
  // FUNGSI BUKA EMAIL
  Future<void> _launchEmail() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: 'support@lesprivate.id',
      query: 'subject=Tanya%20Seputar%20Aplikasi', // Subject email otomatis
    );
    if (!await launchUrl(url)) {
      throw Exception('Tidak bisa membuka Email $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bantuan & CS"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hubungi Kami", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // TOMBOL WHATSAPP (Sudah Berfungsi)
            _buildContactCard(
              Icons.chat, 
              "WhatsApp Admin", 
              "0812-3456-7890", 
              Colors.green,
              _launchWA // Panggil fungsi WA
            ),

            // TOMBOL EMAIL (Sudah Berfungsi)
            _buildContactCard(
              Icons.email, 
              "Email Support", 
              "support@lesprivate.id", 
              Colors.red,
              _launchEmail // Panggil fungsi Email
            ),
            
            const SizedBox(height: 30),
            const Text("Pertanyaan Umum (FAQ)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildFAQItem("Cara pesan guru?", "Pilih guru, lihat jadwal, klik pesan."),
            _buildFAQItem("Sistem pembayaran?", "Transfer bank setelah konfirmasi."),
            _buildFAQItem("Apakah bisa ganti jadwal?", "Bisa, hubungi admin H-1."),
          ],
        ),
      ),
    );
  }

  // Widget Kartu Kontak yang Bisa Diklik
  Widget _buildContactCard(IconData icon, String title, String sub, Color color, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap, // Aksi saat diklik
      ),
    );
  }

  Widget _buildFAQItem(String q, String a) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(q, style: const TextStyle(fontWeight: FontWeight.w500)),
        children: [Padding(padding: const EdgeInsets.all(16), child: Text(a, style: const TextStyle(color: Colors.grey)))],
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN LAINNYA (SAMA SEPERTI SEBELUMNYA)
// ==========================================
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: "Siswa Teladan");
  final _emailController = TextEditingController(text: "siswa@sekolah.id");
  final _phoneController = TextEditingController(text: "081234567890");
  final _bioController = TextEditingController(text: "Saya suka belajar.");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profil"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://i.pravatar.cc/300?img=12")),
          const SizedBox(height: 30),
          _tf("Nama Lengkap", _nameController, Icons.person), const SizedBox(height: 15),
          _tf("Email", _emailController, Icons.email), const SizedBox(height: 15),
          _tf("Nomor HP", _phoneController, Icons.phone), const SizedBox(height: 15),
          _tf("Bio", _bioController, Icons.info, maxLines: 3), const SizedBox(height: 40),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){Navigator.pop(context);}, style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(vertical: 15)), child: const Text("SIMPAN", style: TextStyle(color: Colors.white))))
        ]),
      ),
    );
  }
  Widget _tf(String l, TextEditingController c, IconData i, {int maxLines=1}) => TextField(controller: c, maxLines: maxLines, decoration: InputDecoration(labelText: l, prefixIcon: Icon(i), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}
class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Password"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        _pf("Password Lama"), const SizedBox(height: 15), _pf("Password Baru"), const SizedBox(height: 15), _pf("Konfirmasi"), const SizedBox(height: 40),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){Navigator.pop(context);}, style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(vertical: 15)), child: const Text("UPDATE", style: TextStyle(color: Colors.white))))
      ])),
    );
  }
  Widget _pf(String l) => TextField(obscureText: _isObscure, decoration: InputDecoration(labelText: l, prefixIcon: const Icon(Icons.lock), suffixIcon: IconButton(icon: Icon(_isObscure?Icons.visibility_off:Icons.visibility), onPressed: (){setState((){_isObscure=!_isObscure;});}), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifikasi"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(10), children: [
        _ni("Booking Berhasil", "Pesanan dikonfirmasi.", Icons.check_circle, Colors.green),
        _ni("Promo", "Diskon 20%.", Icons.local_offer, Colors.purple),
      ]),
    );
  }
  Widget _ni(String t, String b, IconData i, Color c) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: c.withOpacity(0.1), child: Icon(i, color: c)), title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(b)));
}