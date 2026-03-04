import 'package:flutter/material.dart';
import 'package:dictionary_app/models/word_model.dart';

class DetailScreen extends StatelessWidget {
  final WordModel word;

  const DetailScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(word.word),
          bottom: const TabBar(
            tabs: [
              Tab(text: "ANH - VIỆT"),
              Tab(text: "NGỮ PHÁP"),
              Tab(text: "ANH - ANH"),
              Tab(text: "CHUYÊN NGÀNH"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ANH - VIỆT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(word.meaning, style: const TextStyle(fontSize: 18)),
            ),

            // NGỮ PHÁP
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(word.grammar, style: const TextStyle(fontSize: 18)),
            ),

            // ANH - ANH (hiện đồng nghĩa)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                word.synonyms.join(", "),
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // CHUYÊN NGÀNH
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(word.specialty, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
