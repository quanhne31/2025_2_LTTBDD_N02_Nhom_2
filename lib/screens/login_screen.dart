import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../languages/app_text.dart';

class LoginScreen extends StatefulWidget {
  final String loginType; // nhận từ AccountScreen

  const LoginScreen({super.key, required this.loginType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> saveLogin() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppText.get("enterFullInfo"))),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('loginType', widget.loginType);
    await prefs.setString('userId', idController.text);
    await prefs.setString('password', passwordController.text);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("login"))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              widget.loginType == "email"
                  ? AppText.get("enterEmailPass")
                  : AppText.get("enterApplePass"),
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: widget.loginType == "email" ? AppText.get("email") : AppText.get("appleId"),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: AppText.get("password")),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: saveLogin,
              child: Text(AppText.get("confirmLogin")),
            ),
          ],
        ),
      ),
    );
  }
}
