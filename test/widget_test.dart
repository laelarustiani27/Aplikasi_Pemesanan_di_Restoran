import 'package:flutter_test/flutter_test.dart';
import 'package:gobizly/main.dart';

void main() {
  testWidgets('Smoke test - GoBizly login page loads correctly', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const GoBizlyApp());
    await tester.pumpAndSettle();

    // Pastikan halaman login muncul dengan elemen-elemen penting
    expect(find.text('Login'), findsWidgets); // Ada di AppBar dan tombol
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.textContaining('Daftar di sini'), findsOneWidget);
  });
}
