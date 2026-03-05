import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dictionary_app/models/word_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('historyWords') ?? [];

    List<String> cleanList = [];

    for (var item in rawList) {
      try {
        final word = WordModel.fromJson(item);

        // chỉ giữ lại dữ liệu hợp lệ
        if (word.word.isNotEmpty) {
          cleanList.add(item);
        }
      } catch (_) {
        // bỏ qua dữ liệu cũ kiểu "eye"
      }
    }

    // cập nhật lại storage để xoá rác vĩnh viễn
    await prefs.setStringList('historyWords', cleanList);

    if (mounted) {
      setState(() {
        history = cleanList;
      });
    }
  }

  Future<void> removeWord(int index) async {
    final prefs = await SharedPreferences.getInstance();
    history.removeAt(index);
    await prefs.setStringList('historyWords', history);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Từ đã tra")),
      body: history.isEmpty
          ? const Center(
              child: Text("Chưa có từ nào", style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                WordModel word;

                try {
                  word = WordModel.fromJson(history[index]);
                } catch (_) {
                  return const SizedBox(); // phòng lỗi lần cuối
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      word.word,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "${word.phonetic} • ${word.type}\n${word.meaning}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        removeWord(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Đã xoá từ")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
