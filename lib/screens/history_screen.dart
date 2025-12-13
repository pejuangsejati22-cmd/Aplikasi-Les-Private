import 'package:flutter/material.dart';
import '../models/order_model.dart';

class HistoryScreen extends StatelessWidget {
  // Versi Singkat & Modern (Garis biru hilang)
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cek jika data kosong
    if (historyOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text("Belum ada riwayat pesanan", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: historyOrders.length,
      itemBuilder: (context, index) {
        // Kita balik urutannya agar yang terbaru muncul di atas
        final order = historyOrders[historyOrders.length - 1 - index];
        
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Foto Kecil
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    order.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Info Pesanan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.tutorName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "${order.subject} • ${order.date}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rp ${order.totalPrice}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                // Status Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: order.status == "Selesai" ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: order.status == "Selesai" ? Colors.green[800] : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}