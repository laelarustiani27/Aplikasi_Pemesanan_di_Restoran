import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'kontak.dart';
import 'cart.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final List<Map<String, String>> makanan = [
    {'nama': 'Nasi Goreng', 'gambar': 'assets/images/american-fried-rice.jpg', 'harga': '25.000'},
    {
      'nama': 'Mie Ayam',
      'gambar':
          'assets/images/thai-food-noodles-spicy-boil-with-pork-boil-egg.jpg',
      'harga': '20.000',
    },
    {
      'nama': 'Sate Ayam',
      'gambar':
          'assets/images/grilled-spicy-chili-it-s-called-maha-decorate-dish-beautifully.jpg',
      'harga': '30.000',
    },
    {
      'nama': 'Bitterballen',
      'gambar': 'assets/images/flat-lay-delicious-fried-food-croquettes.jpg',
      'harga': '15.000',
    },
  ];

  final List<Map<String, String>> minuman = [
    {'nama': 'Kopi Latte', 'gambar': 'assets/images/latte-coffee-cup.jpg', 'harga': '25.000'},
    {
      'nama': 'Es Teh Manis',
      'gambar':
          'assets/images/refreshing-soft-drink-with-lime-slices-glass-cup-black.jpg',
      'harga': '8.000',
    },
    {
      'nama': 'Jus Alpukat',
      'gambar': 'assets/images/healthy-drink-vegetable-smoothie.jpg',
      'harga': '15.000',
    },
    {
      'nama': 'Kopi Susu',
      'gambar': 'assets/images/coffee-with-ice-cubes-glass-wooden-spoon.jpg',
      'harga': '12.000',
    },
  ];

  final List<Map<String, String>> keranjang = [];

  // Fungsi buka URL eksternal
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted) return;
    if (!success) {
      throw Exception('Tidak dapat membuka $url');
    }
  }

  // Fungsi menambah item ke keranjang
  void _tambahKeKeranjang(Map<String, String> item) {
    setState(() {
      keranjang.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['nama']} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF8B4513);
    const Color beige = Color(0xFFF5E6D3);
    // ignore: unused_local_variable
    const Color accentTerracotta = Color(0xFFD2691E);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda GoBizly'),
        backgroundColor: primaryBrown,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: gold, //
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(cartItems: keranjang),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF8B4513)),
              child: Center(
                child: Text(
                  'GoBizly Menu',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.brown),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.brown),
              title: const Text('Kontak Kami'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KontakPage()),
                );
              },
            ),
          ],
        ),
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

          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daftar Makanan',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: makanan.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = makanan[index];
                    return Card(
                      color: beige,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.asset(
                                item['gambar']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  item['nama']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${item['harga'] ?? '-'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBrown,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => _tambahKeKeranjang(item),
                            child: const Text('Pesan'),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'Daftar Minuman',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: minuman.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = minuman[index];
                    return Card(
                      color: beige,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.asset(
                                item['gambar']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  item['nama']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${item['harga'] ?? '-'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBrown,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => _tambahKeKeranjang(item),
                            child: const Text('Pesan'),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                Center(
                  child: Column(
                    children: [
                      const Text('Hubungi Kami: support@gobizly.com'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email, color: primaryBrown),
                            onPressed: () =>
                                _launchURL('mailto:support@gobizly.com'),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: primaryBrown,
                            ),
                            onPressed: () => _launchURL(
                              'https://instagram.com/gobizly.official',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone, color: primaryBrown),
                            onPressed: () =>
                                _launchURL('https://wa.me/6281234567890'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
