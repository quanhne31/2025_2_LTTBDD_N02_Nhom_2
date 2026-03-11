import 'package:flutter/material.dart';
import 'vocab_list_screen.dart';
import '../languages/app_text.dart';

class UnitScreen extends StatelessWidget {
  final int grade;

  const UnitScreen({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    List<int> units = List.generate(12, (i) => i + 1);

    return Scaffold(
      appBar: AppBar(title: Text("${AppText.get("grade")} $grade"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          int unit = units[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("${AppText.get("unit")} $unit"),
              trailing: const Icon(Icons.arrow_forward),

              onTap: () {
                /// UNIT 1 FREE
                if (unit == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VocabListScreen(grade: grade, unit: unit),
                    ),
                  );
                }
                /// UNIT VIP
                else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(AppText.get("vipRequired")),
                      content: Text(AppText.get("vipMessage")),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppText.get("ok")),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
