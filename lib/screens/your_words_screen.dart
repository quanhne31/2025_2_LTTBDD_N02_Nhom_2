import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dictionary_app/models/word_model.dart';

class YourWordsScreen extends StatefulWidget {
  const YourWordsScreen({super.key});

  @override
  State<YourWordsScreen> createState() => _YourWordsScreenState();
}

class _YourWordsScreenState extends State<YourWordsScreen> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favoriteWords') ?? [];
    });
  }

  Future<void> removeWord(int index) async {
    final prefs = await SharedPreferences.getInstance();
    favorites.removeAt(index);
    await prefs.setStringList('favoriteWords', favorites);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Từ của bạn")),
      body: favorites.isEmpty
          ? const Center(child: Text("Chưa có từ nào"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final word = WordModel.fromJson(favorites[index]);

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

                    /// 🗑 Nút thùng rác
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
