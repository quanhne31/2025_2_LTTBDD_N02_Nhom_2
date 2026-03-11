import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../languages/app_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('isDarkMode') ?? false;
      rating = prefs.getInt('rating') ?? 0;
    });
  }

  Future<void> saveRating(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rating', value);

    setState(() {
      rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get("settings"))),
      body: ListView(
        children: [
          /// DARK MODE
          SwitchListTile(
            title: Text(AppText.get("darkmode")),
            value: isDark,
            onChanged: (value) {
              setState(() => isDark = value);
              MyApp.of(context)?.toggleTheme(value);
            },
          ),

          const Divider(),

          /// NGÔN NGỮ
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppText.get("language")),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppText.get("chooseLang")),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppText.get("vietnamese")),
                          onTap: () {
                            MyApp.of(context)?.changeLanguage("vi");
                            AppText.currentLang = "vi";
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(AppText.get("english")),
                          onTap: () {
                            MyApp.of(context)?.changeLanguage("en");
                            AppText.currentLang = "en";
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          const Divider(),

          /// EMAIL PHẢN HỒI
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(AppText.get("email")),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController controller = TextEditingController();

                  return AlertDialog(
                    title: Text(AppText.get("feedback")),
                    content: TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: AppText.get("feedbackHint"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(AppText.get("cancel")),
                        onPressed: () => Navigator.pop(context),
                      ),
                      ElevatedButton(
                        child: Text(AppText.get("send")),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppText.get("sent"))),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const Divider(),

          /// ĐÁNH GIÁ THÔNG MINH
          ListTile(
            title: Text(AppText.get("rating")),
            subtitle: Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    int newRating = index + 1;
                    saveRating(newRating);

                    if (newRating >= 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppText.get("thanksHigh"))),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController reasonController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text(AppText.get("notHappy")),
                            content: TextField(
                              controller: reasonController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: AppText.get("reasonHint"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text(AppText.get("cancel")),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton(
                                child: Text(AppText.get("send")),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppText.get("thanks")),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
