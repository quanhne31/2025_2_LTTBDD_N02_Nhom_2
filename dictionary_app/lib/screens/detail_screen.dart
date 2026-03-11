import 'package:flutter/material.dart';
import 'package:dictionary_app/models/word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../languages/app_text.dart';

class DetailScreen extends StatefulWidget {
  final WordModel word;

  const DetailScreen({super.key, required this.word});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    addToHistory();
    checkFavorite();
  }

  /// 🔹 Tự động thêm vào "Từ đã tra"
  Future<void> addToHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('historyWords') ?? [];

    bool exists = history.any((item) {
      try {
        final word = WordModel.fromJson(item);
        return word.word == widget.word.word;
      } catch (_) {
        return false;
      }
    });

    if (!exists) {
      history.add(widget.word.toJson());
      await prefs.setStringList('historyWords', history);
    }
  }

  /// 🔹 Kiểm tra đã nằm trong "Từ của bạn" chưa
  Future<void> checkFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favoriteWords') ?? [];

    if (favorites.contains(widget.word.word)) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  /// 🔹 Thêm vào "Từ của bạn"
  Future<void> addToFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favoriteWords') ?? [];

    bool exists = favorites.any((item) {
      final word = WordModel.fromJson(item);
      return word.word == widget.word.word;
    });

    if (!exists) {
      favorites.add(widget.word.toJson());
      await prefs.setStringList('favoriteWords', favorites);

      setState(() {
        isFavorite = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppText.get("addedFavorite"))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.word.word),
              Text(
                "${widget.word.phonetic} • ${widget.word.type}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),

          /// ⭐ Nút đánh dấu
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.yellow : Colors.white,
              ),
              onPressed: addToFavorite,
            ),
          ],

          bottom: TabBar(
            tabs: [
              Tab(text: AppText.get("tabEnVi")),
              Tab(text: AppText.get("tabGrammar")),
              Tab(text: AppText.get("tabEnEn")),
              Tab(text: AppText.get("tabSpecial")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.word.meaning,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.word.grammar,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.word.synonyms.join(", "),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.word.specialty,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
