class Tutor {
  final String id;
  final String name;
  final String subject;
  final String description;
  final double rating;
  final int pricePerHour;
  final String imageUrl;

  Tutor({
    required this.id,
    required this.name,
    required this.subject,
    required this.description,
    required this.rating,
    required this.pricePerHour,
    required this.imageUrl,
  });
}

// Data Dummy (Wajib ada agar tidak error saat dipanggil di Home)
final List<Tutor> dummyTutors = [
  Tutor(
    id: '1',
    name: 'Budi Santoso',
    subject: 'Matematika',
    description: 'Ahli Matematika dengan pengalaman 5 tahun.',
    rating: 4.8,
    pricePerHour: 150000,
    imageUrl: 'https://i.pravatar.cc/300?img=11',
  ),
  Tutor(
    id: '2',
    name: 'Siti Aminah',
    subject: 'Bahasa Inggris',
    description: 'Lulusan Sastra Inggris, fokus TOEFL.',
    rating: 4.9,
    pricePerHour: 125000,
    imageUrl: 'https://i.pravatar.cc/300?img=5',
  ),
  // ... tambahkan data lain jika mau
];