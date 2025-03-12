import 'package:flutter/material.dart';
import 'main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class KeuanganScreen extends StatefulWidget {
  const KeuanganScreen({super.key});

  @override
  _KeuanganScreenState createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NumberFormat rupiahFormat = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  
  List<Map<String, dynamic>> pemasukan = [
    {"deskripsi": "Transfer Orang Tua", "jumlah": 750000, "tanggal": "01/03/2025"},
    {"deskripsi": "Untung Magang", "jumlah": 750000, "tanggal": "15/03/2025"},
  ];

  List<Map<String, dynamic>> pengeluaran = [
    {"deskripsi": "Bayar Asrama", "jumlah": 750000, "tanggal": "05/03/2025"},
    {"deskripsi": "Makan dalam 1 Bulan", "jumlah": 500000, "tanggal": "10/03/2025"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int hitungTotalPemasukan() {
    return pemasukan.fold(0, (sum, item) => sum + item["jumlah"] as int);
  }

  int hitungTotalPengeluaran() {
    return pengeluaran.fold(0, (sum, item) => sum + item["jumlah"] as int);
  }

  int hitungSaldo() {
    return hitungTotalPemasukan() - hitungTotalPengeluaran();
  }

  void _tambahLaporan(bool isPemasukan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        final TextEditingController deskripsiController = TextEditingController();
        final TextEditingController jumlahController = TextEditingController();
        final TextEditingController tanggalController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        );
        
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPemasukan ? "Tambah Pemasukan" : "Tambah Pengeluaran",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: deskripsiController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jumlahController,
                  decoration: InputDecoration(
                    labelText: "Jumlah (Rp)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tanggalController,
                  decoration: InputDecoration(
                    labelText: "Tanggal",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null) {
                      tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isPemasukan ? Colors.green.shade600 : Colors.red.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (deskripsiController.text.isNotEmpty && jumlahController.text.isNotEmpty) {
                          setState(() {
                            final int jumlah = int.tryParse(jumlahController.text.replaceAll('.', '')) ?? 0;
                            if (isPemasukan) {
                              pemasukan.add({
                                "deskripsi": deskripsiController.text,
                                "jumlah": jumlah,
                                "tanggal": tanggalController.text,
                              });
                            } else {
                              pengeluaran.add({
                                "deskripsi": deskripsiController.text,
                                "jumlah": jumlah,
                                "tanggal": tanggalController.text,
                              });
                            }
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(isPemasukan ? "Tambah Pemasukan" : "Tambah Pengeluaran"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int saldo = hitungSaldo();
    final bool isSaldoPositif = saldo >= 0;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC9A03F),
        title: const Text(
          "Audit Keuangan", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderCard(saldo, isSaldoPositif),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: "Ringkasan"),
                        Tab(text: "Statistik"),
                      ],
                      labelColor: const Color(0xFFC9A03F),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xFFC9A03F),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildRingkasanTab(),
                          _buildStatistikTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Pilih Jenis Transaksi"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.arrow_downward, color: Colors.green),
                    title: const Text("Tambah Pemasukan"),
                    onTap: () {
                      Navigator.pop(context);
                      _tambahLaporan(true);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.arrow_upward, color: Colors.red),
                    title: const Text("Tambah Pengeluaran"),
                    onTap: () {
                      Navigator.pop(context);
                      _tambahLaporan(false);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFFC9A03F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeaderCard(int saldo, bool isSaldoPositif) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFC9A03F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Saldo Saat Ini",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            rupiahFormat.format(saldo),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  "Pemasukan",
                  hitungTotalPemasukan(),
                  Icons.arrow_downward,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryItem(
                  "Pengeluaran",
                  hitungTotalPengeluaran(),
                  Icons.arrow_upward,
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, int amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    rupiahFormat.format(amount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTransactionCard("Pemasukan Bulan Ini", pemasukan, true),
        const SizedBox(height: 16),
        _buildTransactionCard("Pengeluaran Bulan Ini", pengeluaran, false),
      ],
    );
  }

  Widget _buildStatistikTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Perbandingan Pemasukan & Pengeluaran",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 1, 
                    barRods: [
                      BarChartRodData(
                        toY: hitungTotalPemasukan() / 1000, 
                        color: Colors.green,
                        width: 25,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      )
                    ],
                  ),
                  BarChartGroupData(
                    x: 2, 
                    barRods: [
                      BarChartRodData(
                        toY: hitungTotalPengeluaran() / 1000, 
                        color: Colors.red,
                        width: 25,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      )
                    ],
                  ),
                ],
                gridData: FlGridData(
                  drawHorizontalLine: true,
                  horizontalInterval: 300,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true, 
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt()}k',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String text = value.toInt() == 1 ? "Pemasukan" : "Pengeluaran";
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            text,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String amount = groupIndex == 0 
                          ? rupiahFormat.format(hitungTotalPemasukan())
                          : rupiahFormat.format(hitungTotalPengeluaran());
                      String title = groupIndex == 0 ? 'Pemasukan' : 'Pengeluaran';
                      return BarTooltipItem(
                        '$title\n$amount',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Saran Keuangan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSaranCard(),
        ],
      ),
    );
  }

  Widget _buildSaranCard() {
    final int saldo = hitungSaldo();
    final bool isSaldoPositif = saldo >= 0;
    
    String saranText = isSaldoPositif
        ? "Keuangan Anda dalam kondisi baik dengan saldo positif. Pertimbangkan untuk menyisihkan 20% pendapatan Anda untuk tabungan atau investasi."
        : "Keuangan Anda dalam kondisi defisit. Pertimbangkan untuk mengurangi pengeluaran non-esensial dan mencari sumber pendapatan tambahan.";

    IconData iconData = isSaldoPositif ? Icons.thumb_up : Icons.warning;
    Color iconColor = isSaldoPositif ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSaldoPositif ? "Keuangan Sehat" : "Perhatian",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  saranText,
                  style: const TextStyle(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(String title, List<Map<String, dynamic>> transactions, bool isPemasukan) {
    Color color = isPemasukan ? Colors.green : Colors.red;
    IconData icon = isPemasukan ? Icons.arrow_downward : Icons.arrow_upward;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton.icon(
                  onPressed: () => _tambahLaporan(isPemasukan),
                  icon: Icon(Icons.add, size: 16, color: color),
                  label: Text(
                    "Tambah", 
                    style: TextStyle(color: color),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          transactions.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      "Belum ada data ${isPemasukan ? 'pemasukan' : 'pengeluaran'}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length > 3 ? 3 : transactions.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (context, index) {
                    return _buildTransactionItem(
                      transactions[index]["deskripsi"],
                      transactions[index]["jumlah"],
                      transactions[index]["tanggal"],
                      icon,
                      color,
                    );
                  },
                ),
          if (transactions.length > 3)
            Center(
              child: TextButton(
                onPressed: () {
                  // Implementasi untuk melihat semua transaksi
                },
                child: const Text("Lihat Semua"),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String description, int amount, String date, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            rupiahFormat.format(amount),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}