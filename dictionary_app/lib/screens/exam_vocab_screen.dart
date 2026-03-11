import 'package:flutter/material.dart';
import 'exam_list_screen.dart';
import '../languages/app_text.dart';

class ExamVocabScreen extends StatelessWidget {
  const ExamVocabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.get("examVocab")),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppText.get("oxford3000")),
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
            title: Text(AppText.get("toeic600")),
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
            title: Text(AppText.get("ieltsVocab")),
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
