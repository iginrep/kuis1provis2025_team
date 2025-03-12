import 'package:flutter/material.dart';
import 'main.dart';

class MediaSosialdanToDoList extends StatelessWidget {
  const MediaSosialdanToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text("Media Sosial", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
      body: Column(
        children: [
          _buildStatusTile(
            name: "Your Status",
            time: "Kemarin, 19:22",
            isOwnStatus: true,
          ),
          const Divider(thickness: 1, color: Colors.black45),
          Expanded(
            child: ListView(
              children: [
                _buildStatusTile(name: "Qalam Noer", time: "Kemarin, 18:26"),
                _buildStatusTile(name: "Rexy Putra", time: "Hari ini, 15:12"),
                _buildStatusTile(name: "Igin Adigholib", time: "Kemarin, 14:22"),
                _buildStatusTile(name: "Julian Dwi", time: "Kemarin, 12:31"),
                _buildStatusTile(name: "Tsalitsa Nuril", time: "Hari ini, 11:47"),
                _buildStatusTile(name: "Rahmat Ganteng", time: "Hari ini, 01:43"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTile({required String name, required String time, bool isOwnStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.amber,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                isOwnStatus ? Icons.add : Icons.person,
                color: Colors.amber,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
