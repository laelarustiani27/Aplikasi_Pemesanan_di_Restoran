import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final int total;
  final String qrisImagePath;

  const PaymentPage({super.key, required this.total, required this.qrisImagePath});

  String _formatRupiah(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buf.write(s[i]);
      count++;
      if (count % 3 == 0 && i != 0) buf.write('.');
    }
    final rev = buf.toString().split('').reversed.join();
    return 'Rp $rev';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF8B4513);
    const Color beige = Color(0xFFF5E6D3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran QRIS'),
        backgroundColor: primaryBrown,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/coffee-shop-with-people.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withValues(alpha: 0.85)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                color: beige,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Scan QRIS untuk membayar',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Total: ${_formatRupiah(total)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primaryBrown,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          qrisImagePath,
                          width: 220,
                          height: 220,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stack) {
                            return Column(
                              children: const [
                                Icon(Icons.qr_code, size: 80, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'File QRIS tidak ditemukan.\nTambahkan assets/images/barcode.png dan daftarkan di pubspec.yaml',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Buka aplikasi pembayaran Anda (GoPay, OVO, DANA, ShopeePay, Mobile Banking), lalu scan QR di atas.',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBrown,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Selesai'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}