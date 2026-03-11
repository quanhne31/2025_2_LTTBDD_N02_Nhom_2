import 'package:flutter/material.dart';
import '../languages/app_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("about"))),
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// MÔ TẢ
            Text(
              AppText.get("aboutContent"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            /// DỰ ÁN ĐƯỢC PHÁT TRIỂN BỞI
            Text(
              AppText.get("developedBy"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            /// GIẢNG VIÊN
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.school),
                  const SizedBox(width: 10),
                  Text(AppText.get("teacher")),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// SINH VIÊN
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_outline),
                    const SizedBox(width: 10),
                    Text(AppText.get("student1")),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_outline),
                    const SizedBox(width: 10),
                    Text(AppText.get("student2")),
                  ],
                ),
              ],
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
