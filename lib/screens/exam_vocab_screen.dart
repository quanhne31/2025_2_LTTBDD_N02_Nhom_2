import 'package:flutter/material.dart';
import 'exam_list_screen.dart';

class ExamVocabScreen extends StatelessWidget {
  const ExamVocabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Từ vựng luyện thi"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Oxford 3000"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ExamListScreen(type: "oxford"),
                ),
              );
            },
          ),

          ListTile(
            title: const Text("TOEIC 600"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ExamListScreen(type: "toeic"),
                ),
              );
            },
          ),

          ListTile(
            title: const Text("IELTS Vocabulary"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ExamListScreen(type: "ielts"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
