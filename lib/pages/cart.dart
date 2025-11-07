import 'package:flutter/material.dart';
import 'payment.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF8B4513);

    // Daftar harga default (fallback) untuk perhitungan total
    final Map<String, int> priceList = const {
      'Nasi Goreng': 25000,
      'Mie Ayam': 20000,
      'Sate Ayam': 30000,
      'Bitterballen': 15000,
      'Kopi Latte': 25000,
      'Es Teh Manis': 8000,
      'Jus Alpukat': 15000,
      'Kopi Susu': 12000,
    };

    // Hitung total dari keranjang:
    // - Jika item memiliki field 'harga', gunakan itu
    // - Jika tidak, fallback ke priceList berdasarkan 'nama'
    int total = 0;
    for (final item in widget.cartItems) {
      final hargaStr = item['harga'];
      if (hargaStr != null) {
        final normalized = hargaStr.replaceAll('.', '').replaceAll(',', '');
        total += int.tryParse(normalized) ?? 0;
      } else {
        final nama = item['nama'];
        if (nama != null) {
          total += priceList[nama] ?? 0;
        }
      }
    }

    String formatRupiah(int amount) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Pesanan'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Keranjang masih kosong ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Card(
                        color: const Color(0xFFF5E6D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['gambar']!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item['nama']!),
                          subtitle: Text('Rp ${item['harga'] ?? '-'}'),
                          trailing: const Icon(
                            Icons.check_circle,
                            color: Color(0xFFD2691E),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total: ${formatRupiah(total)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Jika belum dibayar, tampilkan tombol Bayar
              if (!_isPaid)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBrown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: total == 0
                      ? null
                      : () async {
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentPage(
                                total: total,
                                qrisImagePath: 'assets/images/barcode.png',
                              ),
                            ),
                          );
                          if (!context.mounted) return;
                          if (result == true) {
                            setState(() {
                              _isPaid = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pesanan sedang diproses'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                  child: const Text('Bayar'),
                ),
              // Jika sudah dibayar, sembunyikan tombol Bayar dan tampilkan status
              if (_isPaid)
                const Text(
                  'Pesanan sedang diproses',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
