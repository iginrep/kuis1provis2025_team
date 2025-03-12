import 'package:flutter/material.dart';
// import 'main.dart';

class AkademikUtama extends StatelessWidget {
  const AkademikUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E1A1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text(
          'Akademik',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/OIP.jpeg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Tambahkan ini untuk mencegah overflow
          child: Column(
            children: [
              // Konten lainnya tetap sama
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header Informasi Akademik
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.school, color: Colors.brown, size: 28),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Pusat Informasi Akademik',
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Akses rencana studi dan nilai Anda dengan mudah. Semester aktif: Ganjil 2024/2025',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green[400]!),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Status: Aktif',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),

              // Ringkasan akademik
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('IPK', '3.78', Icons.star),
                    _buildStatItem('SKS', '114', Icons.library_books),
                    _buildStatItem('Semester', '5', Icons.calendar_today),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Pilih Salah Satu Menu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 12),

              // Menu pilihan (dibungkus dengan Flexible agar tidak menyebabkan overflow)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9A03F).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildOptionButton(
                      context,
                      'Rencana Studi',
                      'Melihat daftar mata kuliah yang Anda ambil pada semester ini.',
                      Icons.book,
                    ),

                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white70, thickness: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Text(
                            'ATAU',
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.white70, thickness: 1)),
                      ],
                    ),

                    _buildOptionButton(
                      context,
                      'Hasil Studi',
                      'Melihat nilai dan hasil ujian dari mata kuliah yang sudah Anda ambil pada semester sebelumnya.',
                      Icons.grade,
                    ),

                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Implementasi jadwal kuliah
                      },
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Lihat Jadwal Kuliah'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.amber[700], size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(
      BuildContext context, String title, String description, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      onPressed: () {
        // Navigasi ke halaman yang sesuai nanti bisa ditambahkan di sini
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Membuka $title'),
            backgroundColor: Colors.brown,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}