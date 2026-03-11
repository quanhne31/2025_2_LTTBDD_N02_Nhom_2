import 'package:flutter/material.dart';
import '../languages/app_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("about")), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// LOGO
            const Icon(Icons.menu_book, size: 80, color: Colors.blue),

            const SizedBox(height: 20),

            /// TÊN APP
            Text(
              AppText.get("appName"),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// MÔ TẢ
            Text(
              AppText.get("aboutContent"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            /// CARD THÔNG TIN
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.group),
                        const SizedBox(width: 10),
                        Text(AppText.get("team")),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.code),
                        const SizedBox(width: 10),
                        const Text("Flutter"),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.update),
                        const SizedBox(width: 10),
                        const Text("Version 1.0"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// FOOTER
            Text("© 2025", style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
