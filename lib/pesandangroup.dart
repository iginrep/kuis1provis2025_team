import 'package:flutter/material.dart';
import 'main.dart';

class PesanDanGroup extends StatelessWidget {
  const PesanDanGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            "Pesan dan Group",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Pesan Pribadi"),
              Tab(text: "Pesan Grup"),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari Pesan Anda",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMessageList(_privateMessages),
                  _buildMessageList(_groupMessages),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(List<Map<String, String>> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final chat = messages[index];
        return _buildChatItem(chat["name"]!, chat["profileImage"]!, chat["message"]!, chat["time"]!);
      },
    );
  }

  Widget _buildChatItem(String name, String profileImage, String message, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      onTap: () {},
    );
  }
}

final List<Map<String, String>> _privateMessages = [
  {"name": "Azzam 23", "profileImage": "assets/azzam.jpg", "message": "Halo, apa kabar?", "time": "10:30 AM"},
  {"name": "Bening nang euy", "profileImage": "assets/bening.jpg", "message": "Oke, aku setuju!", "time": "09:15 AM"},
  {"name": "Julian kabem", "profileImage": "assets/julian.jpg", "message": "Nanti kita bahas ya pas rapat.", "time": "Kemarin"},
  {"name": "Litsaa", "profileImage": "assets/tsalitsa.jpg", "message": "Haiii Azzamm", "time": "Kemarin"},
  {"name": "Rexy skena", "profileImage": "assets/rexy.jpg", "message": "Jangan lupa meeting jam 3.", "time": "08:00 AM"},
  {"name": "Qalam Gitaris", "profileImage": "assets/qalam.jpg", "message": "Ada tugas baru nih.", "time": "07:45 AM"},
  {"name": "Ghifari DPM", "profileImage": "assets/ghifari.jpg", "message": "Nanti kita bahas pas makan siang.", "time": "Senin"},
  {"name": "Igin DPO", "profileImage": "assets/igin.jpg", "message": "Sudah di kampus?", "time": "Minggu"},
  {"name": "Rahmat Ganteng", "profileImage": "assets/azzam.jpg", "message": "Lagi sibuk nggak?", "time": "Sabtu"},
];


final List<Map<String, String>> _groupMessages = [
  {"name": "Tim Proyek", "profileImage": "assets/group1.jpg", "message": "Guys, ada update terbaru!", "time": "08:45 AM"},
  {"name": "Keluarga Besar", "profileImage": "assets/group2.jpg", "message": "Siapa yang bisa hadir nanti?", "time": "Kemarin"},
  {"name": "Reo Asteria", "profileImage": "assets/group3.jpg", "message": "Ayo siapin konsepnya!", "time": "Senin"},
  {"name": "Kelas C2azy.h", "profileImage": "assets/group4.jpg", "message": "Jadwal kuliah sudah keluar!", "time": "Minggu"},
  {"name": "Ilkom 2023", "profileImage": "assets/group5.jpg", "message": "Ada event seru nih!", "time": "Jumat"},
  {"name": "Seluruh Mhs Ilkom", "profileImage": "assets/group6.jpg", "message": "Informasi penting mengenai acara besok.", "time": "Kamis"},
];
