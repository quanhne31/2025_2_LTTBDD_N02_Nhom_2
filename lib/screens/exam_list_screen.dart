import 'package:flutter/material.dart';

class ExamListScreen extends StatelessWidget {
  final String type;

  const ExamListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> words = [
      {"word": "analyze", "meaning": "phân tích"},
      {"word": "approach", "meaning": "phương pháp"},
      {"word": "benefit", "meaning": "lợi ích"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(type.toUpperCase()),
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(words[index]["word"]!),
            subtitle: Text(words[index]["meaning"]!),
          );
        },
      ),
    );
  }
}
