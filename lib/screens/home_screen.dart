import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("Dịch Tiếng Anh"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.pink[200]),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Tra từ Anh Việt Anh",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.mic),
                  ),
                ),
              ),
            ),

            /// MENU ITEMS
            buildMenuItem(Icons.description, Colors.purple, "Dịch văn bản"),

            buildVipCard(),

            buildMenuItem(Icons.star, Colors.orange, "Từ của bạn"),

            buildMenuItem(Icons.history, Colors.red, "Từ đã tra"),

            buildMenuItem(
              Icons.phone_android,
              Colors.blue,
              "Phần mềm học tiếng Anh",
            ),

            buildMenuItem(Icons.settings, Colors.blueGrey, "Cài đặt"),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// MENU ITEM REUSABLE
  Widget buildMenuItem(IconData icon, Color color, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(title),
        ),
      ),
    );
  }

  /// VIP CARD (phần đặc biệt có nội dung bên trong)
  Widget buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.card_giftcard, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Text("Gói từ vựng VIP", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 12),
              Text("Từ vựng SGK cũ", style: TextStyle(color: Colors.blue)),
              SizedBox(height: 8),
              Text("Từ vựng SGK mới", style: TextStyle(color: Colors.blue)),
              SizedBox(height: 8),
              Text("Từ vựng luyện thi", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
