class Order {
  final String tutorName;
  final String subject;
  final String date;
  final int totalPrice;
  final String status;
  final String imageUrl;

  Order({
    required this.tutorName,
    required this.subject,
    required this.date,
    required this.totalPrice,
    required this.status,
    required this.imageUrl,
  });
}

// List Global untuk menyimpan riwayat (Database Sementara)
// WAJIB ADA agar historyOrders.add() di DetailScreen berfungsi
List<Order> historyOrders = [];