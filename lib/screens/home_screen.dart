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
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
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
              "Dịch văn bản",
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
              "Từ của bạn",
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
              "Từ đã tra",
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
              "Phần mềm học tiếng Anh",
            ),

            buildMenuItem(
              Icons.settings,
              Colors.blueGrey,
              "Cài đặt",
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
        child: const Padding(
          padding: EdgeInsets.all(16),
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
