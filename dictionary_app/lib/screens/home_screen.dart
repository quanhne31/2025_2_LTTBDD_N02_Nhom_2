import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'detail_screen.dart';
import 'text_translate_screen.dart';
import 'package:dictionary_app/models/word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'your_words_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import 'sgk_vocab_screen.dart';
import 'exam_vocab_screen.dart';
import '../languages/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  bool isLoggedIn = false;
  String? pendingRoute;

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
    checkLogin();

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

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void requireLogin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen(loginType: "email")),
    );

    await checkLogin();
  }

  Future<void> navigateAfterLogin(String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool('isLoggedIn') ?? false;

    if (logged) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountScreen()),
      );
    } else {
      pendingRoute = routeName;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(loginType: "email"),
        ),
      );

      await checkLogin();

      if (isLoggedIn && pendingRoute != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AccountScreen()),
        );
        pendingRoute = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(AppText.get("appTitle")),
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
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: AppText.get("searchHint"),
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
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: filteredWords.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredWords[index].word),
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

            buildMenuItem(
              Icons.description,
              Colors.purple,
              AppText.get("textTranslate"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TextTranslateScreen()),
                );
              },
            ),

            buildVipCard(),

            buildMenuItem(
              Icons.star,
              Colors.orange,
              AppText.get("yourWords"),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                bool logged = prefs.getBool('isLoggedIn') ?? false;

                if (!logged) {
                  bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(loginType: "email"),
                    ),
                  );

                  if (result != true) return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const YourWordsScreen()),
                );
              },
            ),

            buildMenuItem(
              Icons.history,
              Colors.red,
              AppText.get("historyWords"),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                bool logged = prefs.getBool('isLoggedIn') ?? false;

                if (!logged) {
                  bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(loginType: "email"),
                    ),
                  );

                  if (result != true) return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
            ),

            buildMenuItem(
              Icons.phone_android,
              Colors.blue,
              AppText.get("englishSoftware"),
            ),

            buildMenuItem(
              Icons.settings,
              Colors.blueGrey,
              AppText.get("settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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

  Widget buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.card_giftcard, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Text(AppText.get("vipVocab"), style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),

              InkWell(
                child: Text(
                  AppText.get("oldTextbookVocab"),
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SGKVocabScreen(
                        title: AppText.get("oldTextbookVocab"),
                        startClass: 3,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 8),

              InkWell(
                child: Text(
                  AppText.get("newTextbookVocab"),
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SGKVocabScreen(
                        title: AppText.get("newTextbookVocab"),
                        startClass: 2,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 8),

              InkWell(
                child: Text(
                  AppText.get("examVocab"),
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ExamVocabScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
