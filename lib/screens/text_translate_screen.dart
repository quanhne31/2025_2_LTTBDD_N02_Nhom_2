import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextTranslateScreen extends StatefulWidget {
  const TextTranslateScreen({super.key});

  @override
  State<TextTranslateScreen> createState() => _TextTranslateScreenState();
}

class _TextTranslateScreenState extends State<TextTranslateScreen> {
  final TextEditingController controller = TextEditingController();

  String result = "";
  bool isLoading = false;
  bool isEnglishToVietnamese = true;

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  /// Load history
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList("history") ?? [];
    });
  }

  /// Save history
  Future<void> saveHistory(String text) async {
    final prefs = await SharedPreferences.getInstance();
    history.insert(0, text);
    await prefs.setStringList("history", history);
    setState(() {});
  }

  /// Translate
  Future<void> translateText() async {
    if (controller.text.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    String from = isEnglishToVietnamese ? "en" : "vi";
    String to = isEnglishToVietnamese ? "vi" : "en";

    final url = Uri.parse(
      "https://api.mymemory.translated.net/get?q=${controller.text}&langpair=$from|$to",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        result = data["responseData"]["translatedText"];
        isLoading = false;
      });

      saveHistory("${controller.text} → $result");
    } else {
      setState(() {
        result = "Lỗi dịch";
        isLoading = false;
      });
    }
  }

  void copyResult() {
    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Đã copy")));
  }

  void clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("history");
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dịch Văn Bản")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Input
              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Nhập văn bản để dịch...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Language switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isEnglishToVietnamese ? "Anh" : "Việt"),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    onPressed: () {
                      setState(() {
                        isEnglishToVietnamese = !isEnglishToVietnamese;
                      });
                    },
                  ),
                  Text(isEnglishToVietnamese ? "Việt" : "Anh"),
                ],
              ),

              const SizedBox(height: 10),

              /// Translate button
              ElevatedButton(
                onPressed: translateText,
                child: const Text("Dịch"),
              ),

              const SizedBox(height: 20),

              if (isLoading) const CircularProgressIndicator(),

              const SizedBox(height: 20),

              /// Result
              if (result.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: copyResult,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),

              /// History
              if (history.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Lịch sử",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: clearHistory,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...history.map(
                      (item) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(item),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
