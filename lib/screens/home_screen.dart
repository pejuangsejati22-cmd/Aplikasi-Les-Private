import 'package:flutter/material.dart';
import '../models/tutor_model.dart';
import 'detail_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart'; // Import Halaman Profile Baru

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List Halaman: Home, History, Profile
  final List<Widget> _pages = [
    const HomeContent(),    // Kita pisah widget konten home di bawah
    const HistoryScreen(),
    const ProfileScreen(),  // Halaman ke-3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul berubah sesuai halaman aktif
        title: Text(
          _selectedIndex == 0 ? 'Cari Guru Privat' 
          : _selectedIndex == 1 ? 'Riwayat Pesanan' 
          : 'Profil Saya'
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        // Tombol Logout di kanan atas DIHAPUS, karena sudah ada di halaman Profil
      ),
      
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai pilihan
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'), // Menu Baru
        ],
      ),
    );
  }
}

// Widget Konten Home (Daftar Guru) dipisah agar rapi
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Halo, Selamat Datang!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari mata pelajaran...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dummyTutors.length,
            itemBuilder: (context, index) {
              final tutor = dummyTutors[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(tutor: tutor)));
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Hero(tag: tutor.id, child: CircleAvatar(radius: 35, backgroundImage: NetworkImage(tutor.imageUrl))),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tutor.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(tutor.subject, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text(' ${tutor.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Text('Rp ${tutor.pricePerHour ~/ 1000}rb/jam', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}