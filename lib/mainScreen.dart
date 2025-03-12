import 'package:flutter/material.dart';
import 'main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/OIP.jpeg"),
            ),
          ),
        ],
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView(
                  children: [
                    Image.asset('assets/images/bg2.jpeg', fit: BoxFit.cover),
                    Image.asset('assets/images/bg3.jpg', fit: BoxFit.cover),
                    Image.asset('assets/images/bg4.jpg', fit: BoxFit.cover),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Aplikasi ini membantu Anda mengelola kesejahteraan mental, akademik, dan keuangan dengan mudah!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                "Selamat datang, Jack!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7, // Menyesuaikan rasio lebar-tinggi item
                  children: [
                    _buildMenuItem('Mental Health', Icons.favorite, "Kelola kesehatan mental Anda."),
                    _buildMenuItem('Akademik', Icons.school, "Dapatkan bantuan akademik terbaik."),
                    _buildMenuItem('Keuangan', Icons.attach_money, "Atur keuangan Anda dengan bijak."),
                  ],
                ),
              ),
              // Tambahkan padding di bagian bawah untuk memberikan ruang
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Medsos'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'E-Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifikasi'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F3D7),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.brown, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              description,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}