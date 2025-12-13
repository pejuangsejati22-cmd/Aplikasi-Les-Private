import 'package:flutter/material.dart';
import '../models/tutor_model.dart';
import '../models/order_model.dart'; // PENTING: Import ini agar bisa simpan ke riwayat

class DetailScreen extends StatelessWidget {
  final Tutor tutor;

  // VERSI PERBAIKAN (Garis biru akan hilang)
  const DetailScreen({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. HEADER GAMBAR (SliverAppBar)
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tutor.name,
                style: const TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                ),
              ),
              background: Hero(
                tag: tutor.id,
                child: Image.network(
                  tutor.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          
          // 2. KONTEN DETAIL
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris Atas (Mapel & Rating)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          tutor.subject,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            ' ${tutor.rating} (50+ Review)',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  const Text(
                    "Tentang Pengajar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tutor.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Jadwal
                  const Text(
                    "Jadwal Tersedia",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildTimeChip("Senin, 16:00"),
                      _buildTimeChip("Rabu, 19:00"),
                      _buildTimeChip("Sabtu, 10:00"),
                    ],
                  ),
                  
                  // Space kosong agar konten tidak tertutup tombol bawah
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. TOMBOL PESAN (Bottom Sheet)
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Harga", style: TextStyle(color: Colors.grey)),
                Text(
                  "Rp ${tutor.pricePerHour}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // LOGIKA PEMESANAN DI SINI
                
                // 1. Tambahkan data ke List History (order_model.dart)
                historyOrders.add(Order(
                  tutorName: tutor.name,
                  subject: tutor.subject,
                  // Mengambil waktu saat ini (contoh sederhana)
                  date: DateTime.now().toString().substring(0, 16), 
                  totalPrice: tutor.pricePerHour,
                  status: "Menunggu Konfirmasi",
                  imageUrl: tutor.imageUrl,
                ));

                // 2. Tampilkan Dialog Sukses
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Booking Berhasil!"),
                      content: Text(
                          "Anda telah berhasil memesan jadwal dengan ${tutor.name}. Silakan cek menu Riwayat."),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Tutup Dialog
                            Navigator.of(context).pop(); // Kembali ke Home
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Pesan Sekarang",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kecil untuk chip jadwal
  Widget _buildTimeChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey[100],
      side: BorderSide.none,
    );
  }
}