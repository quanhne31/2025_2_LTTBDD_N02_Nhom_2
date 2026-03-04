import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Hãy đăng nhập để backup [Từ của bạn] vào tài khoản đăng nhập hoặc tải [Từ của bạn] về từ tài khoản đăng nhập.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            _buildButton(icon: Icons.email, text: "Đăng nhập bằng Email"),

            const SizedBox(height: 20),

            _buildButton(icon: Icons.apple, text: "Đăng nhập bằng Apple"),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required IconData icon, required String text}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
