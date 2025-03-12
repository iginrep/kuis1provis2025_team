import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class JadwalToDoList extends StatefulWidget {
  @override
  _JadwalToDoListState createState() => _JadwalToDoListState();
}

class _JadwalToDoListState extends State<JadwalToDoList> {
  DateTime _selectedDay = DateTime.utc(2025, 12, 14); // Default tanggal 14
  DateTime _focusedDay = DateTime.utc(2025, 12, 14); // Default tanggal 14

  final Map<DateTime, List<String>> todoList = {
    DateTime.utc(2025, 12, 14): [
      'RAPAT BEM KEMAKOM - 14.50 di Student Corner',
      'Kerja Kelompok Provis - 17.30 di Showroom B',
      'Shalat Tarawih - Daarut Tauhid'
    ],
    DateTime.utc(2025, 12, 15): [
      'Presentasi Proyek - 10.00 di Lab Komputer',
      'Mentoring Akademik - 15.00 di Gedung FPMIPA'
    ],
  };

  DateTime normalizeDate(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: Color(0xFFC9A03F),
        title: Text("JADWAL TODO LIST"),
        centerTitle: true,
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
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2025, 12, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = normalizeDate(selectedDay);
                  _focusedDay = normalizeDate(focusedDay);
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
              headerStyle: HeaderStyle(formatButtonVisible: false),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_selectedDay.day} Desember 2025',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...(todoList[normalizeDate(_selectedDay)] ?? ['Tidak ada agenda']).map(
                    (event) => Card(
                      color: Color(0xFFF7F3D7),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                          event,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
