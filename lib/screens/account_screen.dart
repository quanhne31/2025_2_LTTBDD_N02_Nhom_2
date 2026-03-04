import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoggedIn = false;
  String userId = "";

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      userId = prefs.getString('userId') ?? "";
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      isLoggedIn = false;
      userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoggedIn ? _buildLoggedInView() : _buildLoginView(),
      ),
    );
  }

  Widget _buildLoggedInView() {
    return Column(
      children: [
        const SizedBox(height: 40),

        Text(
          "Xin chào: $userId",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        ElevatedButton(onPressed: logout, child: const Text("Đăng xuất")),
      ],
    );
  }

  Widget _buildLoginView() {
    return Column(
      children: [
        const SizedBox(height: 40),

        const Text(
          "Hãy đăng nhập để backup dữ liệu.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),

        const SizedBox(height: 40),

        _buildButton(
          icon: Icons.email,
          text: "Đăng nhập bằng Email",
          loginType: "email",
        ),

        const SizedBox(height: 20),

        _buildButton(
          icon: Icons.apple,
          text: "Đăng nhập bằng Apple",
          loginType: "apple",
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required String loginType,
  }) {
    return GestureDetector(
      onTap: () async {
        bool? result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen(loginType: loginType)),
        );

        if (result == true) {
          checkLogin();
        }
      },
      child: Container(
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
      ),
    );
  }
}
