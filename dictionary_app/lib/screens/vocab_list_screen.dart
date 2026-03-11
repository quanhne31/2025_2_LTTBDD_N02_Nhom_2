import 'package:flutter/material.dart';
import '../languages/app_text.dart';

class VocabListScreen extends StatelessWidget {
  final int grade;
  final int unit;

  const VocabListScreen({super.key, required this.grade, required this.unit});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> words = [
      {"en": "hello", "vi": "xin chào"},
      {"en": "teacher", "vi": "giáo viên"},
      {"en": "student", "vi": "học sinh"},
      {"en": "school", "vi": "trường học"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("${AppText.get("grade")} $grade - ${AppText.get("unit")} $unit",),
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.volume_up),
            title: Text(words[index]["en"]!),
            subtitle: Text(words[index]["vi"]!),
          );
        },
      ),
    );
  }
}
