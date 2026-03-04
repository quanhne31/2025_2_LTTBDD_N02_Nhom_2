import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'detail_screen.dart';
import 'text_translate_screen.dart';
import 'package:dictionary_app/models/word_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  List<WordModel> allWords = [
    WordModel(
      word: "eye",
      phonetic: "/aɪ/",
      type: "noun",
      meaning: "Mắt",
      grammar: "Danh từ đếm được",
      synonyms: ["vision", "sight"],
      specialty: "Y học",
    ),
    WordModel(
      word: "energy",
      phonetic: "/ˈenərdʒi/",
      type: "noun",
      meaning: "Năng lượng",
      grammar: "Danh từ không đếm được",
      synonyms: ["power", "strength"],
      specialty: "Vật lý",
    ),
  ];

  List<WordModel> filteredWords = [];

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        filteredWords = allWords
            .where(
              (word) => word.word.toLowerCase().startsWith(
                controller.text.toLowerCase(),
              ),
            )
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text("Dictionary App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Tra từ Anh Việt Anh",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.mic),
                  ),
                ),
              ),
            ),
            if (controller.text.isNotEmpty)
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: filteredWords.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredWords[index].word,
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(word: filteredWords[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

            /// MENU ITEMS
            buildMenuItem(
              Icons.description,
              Colors.purple,
              "Dịch văn bản",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TextTranslateScreen()),
                );
              },
            ),

            buildVipCard(),

            buildMenuItem(Icons.star, Colors.orange, "Từ của bạn"),

            buildMenuItem(Icons.history, Colors.red, "Từ đã tra"),

            buildMenuItem(
              Icons.phone_android,
              Colors.blue,
              "Phần mềm học tiếng Anh",
            ),

            buildMenuItem(Icons.settings, Colors.blueGrey, "Cài đặt"),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// MENU ITEM REUSABLE
  Widget buildMenuItem(
    IconData icon,
    Color color,
    String title, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(title),
          onTap: onTap,
        ),
      ),
    );
  }

  /// VIP CARD (phần đặc biệt có nội dung bên trong)
  Widget buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.card_giftcard, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Text("Gói từ vựng VIP", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 12),
              Text("Từ vựng SGK cũ", style: TextStyle(color: Colors.blue)),
              SizedBox(height: 8),
              Text("Từ vựng SGK mới", style: TextStyle(color: Colors.blue)),
              SizedBox(height: 8),
              Text("Từ vựng luyện thi", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
