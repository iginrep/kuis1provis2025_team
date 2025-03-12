import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotifikasiScreen(),
    );
  }
}

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: Color(0xFFC9A03F),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Laman ini menampilkan pemberitahuan terbaru, termasuk jadwal, tugas, dan pengumuman penting.',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Pastikan untuk selalu memeriksa notifikasi agar tidak melewatkan informasi penting!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pesan lainnya',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.star_border, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                NotifikasiCard(
                  title: 'Jadwal & To Do',
                  subtitle: 'Kuis DPBO tanggal 3 Maret 2025',
                  color: Color(0xFFF7F3D7),
                ),
                NotifikasiCard(
                  title: 'Pengumuman',
                  subtitle: 'Pendaftaran Beasiswa dibuka pada tanggal 16 April 2025',
                  color: Color(0xFFEDEDE4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotifikasiCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const NotifikasiCard({
    required this.title,
    required this.subtitle,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}