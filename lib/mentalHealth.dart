import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class Mentalhealth extends StatefulWidget {
  const Mentalhealth({super.key});

  @override
  State<Mentalhealth> createState() => _MentalhealthState();
}

class _MentalhealthState extends State<Mentalhealth> {
  DateTime selectedMonth = DateTime.now();
  int? selectedDay;

  void _changeMonth(int offset) {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + offset, 1);
      selectedDay = null; // Reset pilihan saat berpindah bulan
    });
  }

  void _selectDay(int day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text("Bimbingan Konseling", style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Informasi tentang Laporan dan Bimbingan Konseling
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.psychology, color: Colors.amber[700], size: 28),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Bimbingan Konseling Kesehatan Mental",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Layanan ini disediakan untuk membantu Anda mengatasi masalah kesehatan mental. "
                    "Setiap laporan akan ditangani oleh konselor profesional dan dijamin kerahasiaannya. "
                    "Silakan sampaikan keluhan Anda dan pilih jadwal untuk konsultasi tatap muka.",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            _sectionTitle('Sampaikan Keluhan Anda'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tulis keluhan Anda di sini...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Tentukan Jadwal Bertemu'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => _changeMonth(-1),
                        color: Colors.brown,
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(selectedMonth),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () => _changeMonth(1),
                        color: Colors.brown,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CalendarGrid(
                    selectedMonth: selectedMonth,
                    selectedDay: selectedDay,
                    onDaySelected: _selectDay,
                  ),
                  const SizedBox(height: 16),
                  selectedDay != null 
                    ? Text(
                        "Jadwal dipilih: ${selectedDay} ${DateFormat('MMMM yyyy').format(selectedMonth)}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      )
                    : const Text(
                        "Silakan pilih tanggal untuk konsultasi",
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 80), // Menambahkan ruang untuk floating action button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Tambahkan aksi pengiriman jadwal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(selectedDay != null 
                ? "Jadwal konsultasi ${selectedDay} ${DateFormat('MMMM yyyy').format(selectedMonth)} berhasil dibuat" 
                : "Silakan pilih tanggal terlebih dahulu"),
              backgroundColor: selectedDay != null ? Colors.green : Colors.red,
            ),
          );
        },
        label: const Text("Buat Jadwal"),
        icon: const Icon(Icons.send),
        backgroundColor: Colors.brown,
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFC9A03F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title, 
        textAlign: TextAlign.center, 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  final DateTime selectedMonth;
  final int? selectedDay;
  final Function(int) onDaySelected;

  const CalendarGrid({
    super.key,
    required this.selectedMonth,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    int firstWeekday = DateTime(selectedMonth.year, selectedMonth.month, 1).weekday % 7;
    List<int> days = List.generate(daysInMonth, (index) => index + 1);
    List<String> weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: day == 'Su' ? Colors.red : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1.2,
          ),
          itemCount: days.length + firstWeekday,
          itemBuilder: (context, index) {
            if (index < firstWeekday) {
              return const SizedBox();
            }
            int day = days[index - firstWeekday];
            bool isSelected = day == selectedDay;
            bool isToday = day == DateTime.now().day && 
                        selectedMonth.month == DateTime.now().month && 
                        selectedMonth.year == DateTime.now().year;

            return GestureDetector(
              onTap: () => onDaySelected(day),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFFC9A03F) 
                      : (isToday ? Colors.amber[100] : Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected 
                        ? Colors.brown 
                        : (isToday ? Colors.amber : Colors.grey[400]!),
                    width: isSelected || isToday ? 2 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}