import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!success) {
      throw Exception('Tidak dapat membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xFF8B4513);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Kami'),
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hubungi Kami di:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () =>
                        _launchURL('mailto:support@gobizly.com'),
                    icon: const Icon(Icons.email, color: primaryBrown),
                    label: const Text('support@gobizly.com'),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        _launchURL('https://wa.me/6281234567890'),
                    icon: const Icon(Icons.phone, color: primaryBrown),
                    label: const Text('+62 812-3456-7890'),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        _launchURL('https://instagram.com/gobizly.official'),
                    icon: const Icon(Icons.camera_alt, color: primaryBrown),
                    label: const Text('@gobizly.official'),
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
