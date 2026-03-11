import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/foundation.dart';
import '../languages/app_text.dart';

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
      "https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(controller.text)}&langpair=$from|$to",
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
        result = AppText.get("translateError");
        isLoading = false;
      });
    }
  }

  void copyResult() {
    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(AppText.get("copied"))));
  }

  void clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("history");
    setState(() {
      history.clear();
    });
  }

  Future<void> pickImageAndExtractText() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      isLoading = true;
    });

    /// ================= WEB =================
    if (kIsWeb) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.ocr.space/parse/image'),
        );

        request.fields['apikey'] = 'helloworld';
        request.fields['language'] = 'eng';

        var bytes = await pickedFile.readAsBytes();

        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: pickedFile.name,
          ),
        );

        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 20),
        );

        var response = await http.Response.fromStream(streamedResponse);

        var jsonData = json.decode(response.body);

        if (jsonData['IsErroredOnProcessing'] == false) {
          setState(() {
            controller.text = jsonData['ParsedResults'][0]['ParsedText'] ?? '';
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${AppText.get("ocrError")} $e")),
          );
      }
    }
    /// ================= ANDROID / IOS =================
    else {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      setState(() {
        controller.text = recognizedText.text;
        isLoading = false;
      });

      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("translateText"))),
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
                  hintText: AppText.get("enterText"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: pickImageAndExtractText,
                icon: const Icon(Icons.image),
                label: Text(AppText.get("translateImage")),
              ),

              /// Language switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isEnglishToVietnamese ? AppText.get("english") : AppText.get("vietnamese")),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    onPressed: () {
                      setState(() {
                        isEnglishToVietnamese = !isEnglishToVietnamese;
                      });
                    },
                  ),
                  Text(isEnglishToVietnamese ? AppText.get("vietnamese") : AppText.get("english")),
                ],
              ),

              const SizedBox(height: 10),

              /// Translate button
              ElevatedButton(
                onPressed: translateText,
                child: Text(AppText.get("translate")),
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
                        Text(AppText.get("history"),
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
