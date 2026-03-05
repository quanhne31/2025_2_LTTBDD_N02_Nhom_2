import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

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
      appBar: AppBar(title: const Text("Cài đặt")),
      body: ListView(
        children: [
          /// 🌙 DARK MODE
          SwitchListTile(
            title: const Text("Chế độ tối"),
            value: isDark,
            onChanged: (value) {
              setState(() => isDark = value);
              MyApp.of(context)?.toggleTheme(value);
            },
          ),

          const Divider(),

          /// 📧 EMAIL PHẢN HỒI
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email phản hồi"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController controller = TextEditingController();

                  return AlertDialog(
                    title: const Text("Gửi phản hồi"),
                    content: TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: "Nhập nội dung phản hồi...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Hủy"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      ElevatedButton(
                        child: const Text("Gửi"),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Đã gửi phản hồi tới nhà phát hành",
                              ),
                            ),
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

          /// ⭐ ĐÁNH GIÁ THÔNG MINH
          ListTile(
            title: const Text("Đánh giá ứng dụng"),
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
                        const SnackBar(
                          content: Text("Cảm ơn bạn đã đánh giá cao ❤️"),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController reasonController =
                              TextEditingController();

                          return AlertDialog(
                            title: const Text("Bạn chưa hài lòng?"),
                            content: TextField(
                              controller: reasonController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText: "Hãy cho chúng tôi biết lý do...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Bỏ qua"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton(
                                child: const Text("Gửi"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Cảm ơn phản hồi của bạn!"),
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
