import 'package:flutter/material.dart';
import 'unit_screen.dart';
import '../languages/app_text.dart';

class SGKVocabScreen extends StatelessWidget {
  final String title;
  final int startClass;

  const SGKVocabScreen({
    super.key,
    required this.title,
    required this.startClass,
  });

  @override
  Widget build(BuildContext context) {
    List<int> grades = List.generate(13 - startClass, (i) => i + startClass);

    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          int grade = grades[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.school),
              title: Text("${AppText.get("grade")} $grade"),
              subtitle: Text(AppText.get("complete0")),
              trailing: ElevatedButton(
                onPressed: () {
                  /// mở danh sách Unit của lớp
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UnitScreen(grade: grade)),
                  );
                },
                child: Text(AppText.get("practice")),
              ),
            ),
          );
        },
      ),
    );
  }
}
