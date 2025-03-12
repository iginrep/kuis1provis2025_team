import 'package:flutter/material.dart';
import 'main.dart';

class AkademikHasil extends StatefulWidget {
  const AkademikHasil({super.key});

  @override
  State<AkademikHasil> createState() => _AkademikHasilState();
}

class _AkademikHasilState extends State<AkademikHasil> {
  int _selectedSemester = 1;
  final List<String> _semesters = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4'];
  
  final Map<int, List<Map<String, dynamic>>> _coursesPerSemester = {
    1: [
      {'course': 'Algoritma & Pemrograman', 'lecturer': 'Dr. Azzam', 'grade': 'A', 'sks': 3, 'code': 'CS101'},
      {'course': 'Struktur Data', 'lecturer': 'Dr. Julian', 'grade': 'B+', 'sks': 3, 'code': 'CS102'},
      {'course': 'Jaringan Komputer', 'lecturer': 'Dr. Ghifari', 'grade': 'A-', 'sks': 2, 'code': 'CS103'},
      {'course': 'Grafika Komputer', 'lecturer': 'Dr. Meisya', 'grade': 'B', 'sks': 3, 'code': 'CS104'},
      {'course': 'Kecerdasan Buatan', 'lecturer': 'Dr. Bening', 'grade': 'B-', 'sks': 3, 'code': 'CS105'},
    ],
    2: [
      {'course': 'Basis Data', 'lecturer': 'Dr. Fathir', 'grade': 'A', 'sks': 3, 'code': 'CS201'},
      {'course': 'Rekayasa Perangkat Lunak', 'lecturer': 'Dr. Siti', 'grade': 'A-', 'sks': 4, 'code': 'CS202'},
      {'course': 'Interaksi Manusia & Komputer', 'lecturer': 'Dr. Rahman', 'grade': 'B+', 'sks': 3, 'code': 'CS203'},
      {'course': 'Sistem Operasi', 'lecturer': 'Dr. Anita', 'grade': 'B', 'sks': 3, 'code': 'CS204'},
    ],
    3: [
      {'course': 'Pemrograman Web', 'lecturer': 'Dr. Dimas', 'grade': 'A-', 'sks': 3, 'code': 'CS301'},
      {'course': 'Keamanan Sistem', 'lecturer': 'Dr. Hadi', 'grade': 'B+', 'sks': 3, 'code': 'CS302'},
      {'course': 'Mobile Programming', 'lecturer': 'Dr. Laila', 'grade': 'A', 'sks': 4, 'code': 'CS303'},
      {'course': 'Data Mining', 'lecturer': 'Dr. Farhan', 'grade': 'B', 'sks': 3, 'code': 'CS304'},
      {'course': 'Cloud Computing', 'lecturer': 'Dr. Putri', 'grade': 'B+', 'sks': 3, 'code': 'CS305'},
    ],
    4: [
      {'course': 'Tugas Akhir', 'lecturer': 'Dr. Roni', 'grade': '-', 'sks': 6, 'code': 'CS401'},
      {'course': 'Etika Profesi', 'lecturer': 'Dr. Indah', 'grade': 'A', 'sks': 2, 'code': 'CS402'},
      {'course': 'Kewirausahaan', 'lecturer': 'Dr. Budi', 'grade': 'B+', 'sks': 2, 'code': 'CS403'},
    ],
  };

  double _calculateGPA(List<Map<String, dynamic>> courses) {
    if (courses.isEmpty) return 0.0;
    
    double totalGradePoints = 0.0;
    int totalSKS = 0;
    
    final Map<String, double> gradePoints = {
      'A': 4.0,
      'A-': 3.7,
      'B+': 3.3,
      'B': 3.0,
      'B-': 2.7,
      'C+': 2.3,
      'C': 2.0,
      'D': 1.0,
      'E': 0.0,
      '-': 0.0,
    };
    
    for (var course in courses) {
      if (course['grade'] != '-') {
        totalGradePoints += gradePoints[course['grade']]! * (course['sks'] as int);
        totalSKS += (course['sks'] as int);
      }
    }
    
    return totalSKS > 0 ? totalGradePoints / totalSKS : 0.0;
  }
  
  double _calculateCGPA() {
    double totalGradePoints = 0.0;
    int totalSKS = 0;
    
    final Map<String, double> gradePoints = {
      'A': 4.0,
      'A-': 3.7,
      'B+': 3.3,
      'B': 3.0,
      'B-': 2.7,
      'C+': 2.3,
      'C': 2.0,
      'D': 1.0,
      'E': 0.0,
      '-': 0.0,
    };
    
    for (int semester = 1; semester <= 4; semester++) {
      for (var course in _coursesPerSemester[semester] ?? []) {
        if (course['grade'] != '-') {
          totalGradePoints += gradePoints[course['grade']]! * (course['sks'] as int);
          totalSKS += (course['sks'] as int);
        }
      }
    }
    
    return totalSKS > 0 ? totalGradePoints / totalSKS : 0.0;
  }
  
  int _calculateTotalSKS(List<Map<String, dynamic>> courses) {
    return courses.fold(0, (sum, course) => sum + (course['sks'] as int));
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green.shade700;
      case 'A-':
        return Colors.green.shade600;
      case 'B+':
        return Colors.blue.shade700;
      case 'B':
        return Colors.blue.shade600;
      case 'B-':
        return Colors.blue.shade500;
      case 'C+':
        return Colors.amber.shade700;
      case 'C':
        return Colors.amber.shade600;
      case 'D':
        return Colors.orange.shade700;
      case 'E':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCourses = _coursesPerSemester[_selectedSemester] ?? [];
    final gpa = _calculateGPA(currentCourses);
    final cgpa = _calculateCGPA();
    final totalSKS = _calculateTotalSKS(currentCourses);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text(
          'Hasil Akademik', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              _buildSummaryCards(gpa, cgpa),
              
              const SizedBox(height: 20),
              
              // Semester Selector
              _buildSemesterSelector(),
              
              const SizedBox(height: 20),
              
              // Course Table
              _buildCourseTable(currentCourses, totalSKS),
              
              const SizedBox(height: 20),
              
              // Navigation and Action Buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC9A03F),
        child: const Icon(Icons.download, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mengunduh transkrip nilai...'))
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards(double gpa, double cgpa) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFC9A03F), const Color(0xFFC9A03F).withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Text(
                    cgpa.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC9A03F),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "IPK (CGPA)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Indeks Prestasi Kumulatif",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: cgpa / 4.0,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // GPA Card for current semester
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFF8E6A0),
                  child: Text(
                    gpa.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC9A03F),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "IPS ${_semesters[_selectedSemester - 1]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Indeks Prestasi Semester",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: gpa / 4.0,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC9A03F)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSemesterSelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _semesters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedSemester == index + 1;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedSemester = index + 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFC9A03F) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _semesters[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseTable(List<Map<String, dynamic>> courses, int totalSKS) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8E6A0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _semesters[_selectedSemester - 1],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Total: $totalSKS SKS",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: const [
                Expanded(flex: 1, child: Text('Kode', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Mata Kuliah', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Dosen', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('SKS', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Nilai', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          
          // Course rows
          ...courses.map((course) => _buildCourseRow(course)),
          
          // Grade distribution chart
          if (courses.isNotEmpty) _buildGradeDistribution(courses),
        ],
      ),
    );
  }

  Widget _buildCourseRow(Map<String, dynamic> course) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              course['code'],
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              course['course'],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              course['lecturer'],
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              (course['sks'] as int).toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getGradeColor(course['grade']).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                course['grade'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _getGradeColor(course['grade']),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeDistribution(List<Map<String, dynamic>> courses) {
    // Count grades
    Map<String, int> gradeCounts = {};
    for (var course in courses) {
      String grade = course['grade'];
      if (grade != '-') {
        gradeCounts[grade] = (gradeCounts[grade] ?? 0) + 1;
      }
    }
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Distribusi Nilai",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'E'].map((grade) {
              return Column(
                children: [
                  Container(
                    width: 30,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 30,
                          height: (gradeCounts[grade] ?? 0) / courses.length * 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _getGradeColor(grade),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(grade, style: TextStyle(fontWeight: FontWeight.bold, color: _getGradeColor(grade))),
                  Text('${gradeCounts[grade] ?? 0}', style: const TextStyle(fontSize: 12)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () {
              setState(() {
                if (_selectedSemester > 1) {
                  _selectedSemester--;
                }
              });
            },
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text(
              'Sebelumnya',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC9A03F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () {
              setState(() {
                if (_selectedSemester < 4) {
                  _selectedSemester++;
                }
              });
            },
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text(
              'Berikutnya',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}