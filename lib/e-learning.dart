import 'package:flutter/material.dart';
import 'main.dart';

class ELearning extends StatelessWidget {
  const ELearning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Warna latar belakang yang lebih lembut
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD54F), // Warna amber yang lebih cerah
        title: const Text(
          "E-Learning", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037), // Warna teks yang kontras
          )
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Color(0xFF5D4037)),
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
              radius: 20, // Ukuran avatar yang lebih proporsional
            ),
          ),
        ],
        elevation: 0, // Menghilangkan bayangan untuk tampilan yang lebih modern
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daftar Mata Kuliah", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 18,
                      color: Color(0xFF5D4037),
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD54F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: const Row(
                      children: [
                        Icon(Icons.filter_list, size: 16),
                        SizedBox(width: 4),
                        Text("Filter", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: _buildCourseList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.add, color: Color(0xFF5D4037)),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Widget> _buildCourseList() {
    List<Map<String, dynamic>> courses = [
      {
        "title": "Design Pemrograman Berorientasi Object", 
        "image": "assets/images/dpbo.jpg",
        "progress": 0.8,
        "moduleCount": 12
      },
      {
        "title": "Pemrograman dan Visual Piranti Bergerak", 
        "image": "assets/images/provis.jpg",
        "progress": 0.6,
        "moduleCount": 10
      },
      {
        "title": "Struktur Data", 
        "image": "assets/images/strukdat.jpg",
        "progress": 0.9,
        "moduleCount": 8
      },
      {
        "title": "Metodologi Penelitian", 
        "image": "assets/images/metopen.jpg",
        "progress": 0.4,
        "moduleCount": 6
      },
      {
        "title": "Analisis Algoritma", 
        "image": "assets/images/amdal.jpg",
        "progress": 0.7,
        "moduleCount": 9
      },
      {
        "title": "Sistem Operasi", 
        "image": "assets/images/sisop.jpg",
        "progress": 0.5,
        "moduleCount": 7
      },
      {
        "title": "Proyek Konsultasi", 
        "image": "assets/images/prokon.jpg",
        "progress": 0.2,
        "moduleCount": 5
      }
    ];

    return courses.map((course) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    course["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  course["title"]!, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF5D4037),
                  )
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.book, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text("${course["moduleCount"]} Modul", style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: course["progress"],
                              backgroundColor: Colors.grey[200],
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54F)),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${(course["progress"] * 100).toInt()}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D4037),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFFFFB300),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Terakhir diakses: Hari ini", 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.bookmark_border, color: Colors.grey),
                          onPressed: () {},
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.share_outlined, color: Colors.grey),
                          onPressed: () {},
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'Beranda', false),
          _buildNavItem(Icons.chat_outlined, 'Medsos', false),
          _buildNavItem(Icons.school, 'E-Learning', true),
          _buildNavItem(Icons.calendar_today_outlined, 'Jadwal', false),
          _buildNavItem(Icons.person_outline, 'Profil', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFFF8E1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon, 
            color: isActive ? const Color(0xFFFFB300) : Colors.grey,
            size: 24
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label, 
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF5D4037) : Colors.grey,
          )
        ),
      ],
    );
  }
}