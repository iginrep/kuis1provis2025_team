import 'package:flutter/material.dart';
import 'main.dart';

class AkademikRencana extends StatefulWidget {
  const AkademikRencana({super.key});

  @override
  State<AkademikRencana> createState() => _AkademikRencanaState();
}

class _AkademikRencanaState extends State<AkademikRencana> {
  // Data mata kuliah dengan info tambahan
  final List<Map<String, dynamic>> mataKuliah = [
    {"nama": "Struktur Data", "dosen": "Bu Yanti", "sks": 3, "selected": true},
    {"nama": "DPBO", "dosen": "Bu Rosa", "sks": 3, "selected": true},
    {"nama": "Provis", "dosen": "Pa Yudi", "sks": 3, "selected": true},
    {"nama": "Metodologi Penelitian", "dosen": "Pa Rizky", "sks": 2, "selected": true},
    {"nama": "Sistem Operasi", "dosen": "Pa Herbert", "sks": 3, "selected": true},
    {"nama": "Analisis Algoritma", "dosen": "Pa Yaya", "sks": 3, "selected": true},
    {"nama": "Proyek Konsultasi", "dosen": "Pa Eddy", "sks": 2, "selected": true},
  ];

  // Mata kuliah tambahan yang bisa dipilih
  final List<Map<String, dynamic>> tambahan = [
    {"nama": "Pemrograman Web", "dosen": "Bu Mira", "sks": 3, "selected": false},
    {"nama": "Jaringan Komputer", "dosen": "Pa Doni", "sks": 3, "selected": false},
    {"nama": "Machine Learning", "dosen": "Pa Budi", "sks": 3, "selected": false},
  ];

  bool _isEditing = false;
  String _semester = "Semester 4";
  String _tahunAjaran = "2024/2025";
  int _maxSKS = 24;

  int get totalSKS {
    int total = 0;
    for (var mk in mataKuliah) {
      if (mk["selected"]) {
        total += mk["sks"] as int;
      }
    }
    return total;
  }

  void _tambahMataKuliah() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Mata Kuliah"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tambahan.length,
              itemBuilder: (context, index) {
                final mk = tambahan[index];
                return CheckboxListTile(
                  title: Text(mk["nama"]),
                  subtitle: Text("${mk["dosen"]} • ${mk["sks"]} SKS"),
                  value: mk["selected"],
                  onChanged: (value) {
                    setState(() {
                      mk["selected"] = value;
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Tambahkan mata kuliah yang dicentang ke daftar utama
                  for (var mk in tambahan) {
                    if (mk["selected"]) {
                      mataKuliah.add(Map.from(mk));
                      mk["selected"] = false; // Reset pilihan
                    }
                  }
                });
                Navigator.pop(context);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  void _showInfoMataKuliah(Map<String, dynamic> mk) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mk["nama"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dosen: ${mk["dosen"]}"),
              Text("SKS: ${mk["sks"]}"),
              const SizedBox(height: 10),
              const Text("Deskripsi:"),
              const SizedBox(height: 5),
              Text("Mata kuliah ${mk["nama"]} mencakup pembelajaran tentang konsep dasar dan penerapan praktis dalam bidang ilmu komputer."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E6A0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text("Rencana Studi", style: TextStyle(fontWeight: FontWeight.bold)),
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
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/OIP.jpeg"),
            ),
          ),
        ],
        elevation: 4,
      ),
      floatingActionButton: _isEditing ? FloatingActionButton(
        backgroundColor: Colors.amber.shade700,
        onPressed: _tambahMataKuliah,
        child: const Icon(Icons.add),
      ) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header info section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Kartu Rencana Studi", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(height: 8),
                          Text("$_semester • $_tahunAjaran", 
                            style: TextStyle(color: Colors.grey.shade700)
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text("Total SKS: $totalSKS", 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: totalSKS > _maxSKS ? Colors.red : Colors.green
                                )
                              ),
                              Text(" / $_maxSKS maksimum", style: TextStyle(color: Colors.grey.shade600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (_isEditing)
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.settings),
                        onSelected: (value) {
                          if (value == 'semester') {
                            // Dialog untuk mengubah semester
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: const Text("Pilih Semester"),
                                children: [
                                  for (int i = 1; i <= 8; i++)
                                    SimpleDialogOption(
                                      onPressed: () {
                                        setState(() {
                                          _semester = "Semester $i";
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("Semester $i"),
                                    ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'semester',
                            child: Text("Ubah Semester"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Table content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header table
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_isEditing)
                            const Expanded(child: Center(child: Text("Pilih", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                          const Expanded(child: Center(child: Text("No", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                          const Expanded(flex: 3, child: Center(child: Text("Mata Kuliah", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                          const Expanded(flex: 2, child: Center(child: Text("Dosen", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                          const Expanded(child: Center(child: Text("SKS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Table content
                    Expanded(
                      child: ListView.separated(
                        itemCount: mataKuliah.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final mk = mataKuliah[index];
                          return InkWell(
                            onTap: () => _showInfoMataKuliah(mk),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: index.isEven ? Colors.grey.shade200 : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_isEditing)
                                    Expanded(
                                      child: Center(
                                        child: Checkbox(
                                          value: mk["selected"],
                                          onChanged: (value) {
                                            setState(() {
                                              mk["selected"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  Expanded(child: Center(child: Text("${index + 1}"))),
                                  Expanded(flex: 3, child: Center(child: Text(mk["nama"]))),
                                  Expanded(flex: 2, child: Center(child: Text(mk["dosen"]))),
                                  Expanded(child: Center(child: Text("${mk["sks"]}"))),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Color(0xFFC9A03F)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("KRS berhasil disimpan")),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan KRS"),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC9A03F),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("KRS berhasil diunduh")),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Unduh KRS"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}