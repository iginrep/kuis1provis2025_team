import 'package:flutter/material.dart';
import 'keuanganScreen.dart';
import 'akademikrencana.dart'; // Import file mainScreen.dart
import 'e-learning.dart'; // Import file mainScreen.dart
import 'mainScreen.dart'; // Import file mainScreen.dart
import 'jadwalTodolist.dart'; // Import file mainScreen.dart
import 'medsos.dart'; // Import file mainScreen.dart
import 'notifikasi.dart'; // Import file mainScreen.dart
import 'pesandangroup.dart'; // Import file mainScreen.dart
import 'mentalHealth.dart'; // Import file mainScreen.dart
import 'akademikutama.dart';
import 'akademikhasil.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz 1 Provis kelompok 14',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(), // Pastikan HomePage sudah dideklarasikan di homePage.dart
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        leading: const Icon(Icons.menu, color: Colors.white),
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // _buildButton(context, 'TUGAS QUIZ KELOMPOK 14, Ahmad izzuddin azzam & Muhammad Igin Adigholib', null),
                _buildButton(context, 'Main Screen', const MainScreen()),
                _buildButton(context, 'Mental Health Screen', const Mentalhealth()),
                _buildButton(context, 'Akademik - Utama', const AkademikUtama()),
                _buildButton(context, 'Akademik - Rencana Studi', const AkademikRencana()),
                _buildButton(context, 'Akademik - Hasil Studi', const AkademikHasil()),
                _buildButton(context, 'Keuangan Screen', const KeuanganScreen()),
                _buildButton(context, 'Medsos Screen', const MediaSosialdanToDoList()),
                _buildButton(context, 'E-Learning Screen', const ELearning()),
                _buildButton(context, 'Jadwal & Todo', JadwalToDoList()),
                _buildButton(context, 'Pesan dan Group', const PesanDanGroup()),
                _buildButton(context, 'Notifikasi', const NotifikasiScreen()),
              ],
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }
  
  Widget _buildButton(BuildContext context, String text, Widget? page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
        onPressed: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),  
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.chat, 'Medsos'),
          _buildNavItem(Icons.school, 'E-Learning'),
          _buildNavItem(Icons.list, 'Jadwal & Todo'),
          _buildNavItem(Icons.message, 'Pesan & Group'),
          _buildNavItem(Icons.notifications, 'Notifikasi'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
