import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word_model.dart';
import 'detail_screen.dart';
import '../languages/app_text.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<WordModel> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList('favoriteWords') ?? [];

    setState(() {
      favorites = data.map((e) => WordModel.fromJson(e)).toList();
    });
  }

  Future<void> removeWord(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList('favoriteWords') ?? [];

    data.removeAt(index);
    await prefs.setStringList('favoriteWords', data);

    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("yourWords"))),
      body: favorites.isEmpty
          ? Center(child: Text(AppText.get("noWords")))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final word = favorites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  child: Dismissible(
                    key: Key(word.word),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => removeWord(index),
                    child: ListTile(
                      title: Text(
                        word.word,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            "${word.phonetic} • ${word.type}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(word.meaning),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(word: word),
                          ),
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
