class AppText {
  static String currentLang = "vi";

  static Map<String, Map<String, String>> text = {
    "vi": {
      "settings": "Cài đặt",
      "darkmode": "Chế độ tối",
      "language": "Ngôn ngữ",
      "email": "Email phản hồi",
      "rating": "Đánh giá ứng dụng",
      "about": "Về chúng tôi",
      "feedback": "Gửi phản hồi",
      "cancel": "Hủy",
      "send": "Gửi",
      },
    "en": {
      "settings": "Settings",
      "darkmode": "Dark Mode",
      "language": "Language",
      "email": "Feedback Email",
      "rating": "Rate App",
      "about": "About Us",
      "feedback": "Send Feedback",
      "cancel": "Cancel",
      "send": "Send",},
  };

  static String get(String key) {
    return text[currentLang]?[key] ?? key;
  }
}
