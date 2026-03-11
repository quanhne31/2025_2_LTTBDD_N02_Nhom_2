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
      "login": "Đăng nhập",
      "enterFullInfo": "Vui lòng nhập đầy đủ thông tin",
      "enterEmailPass": "Nhập Email và mật khẩu",
      "enterApplePass": "Nhập Apple ID và mật khẩu",
      "email": "Email",
      "appleId": "Apple ID",
      "password": "Mật khẩu",
      "confirmLogin": "Xác nhận đăng nhập",
      "notHappy": "Bạn chưa hài lòng?",
      "thanks": "Cảm ơn phản hồi của bạn!",
      "chooseLang": "Chọn ngôn ngữ",
      "sent": "Đã gửi phản hồi tới nhà phát hành",
      "thanksHigh": "Cảm ơn bạn đã đánh giá cao ❤️",
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
      "login": "Login",
      "enterFullInfo": "Please enter all information",
      "enterEmailPass": "Enter Email and Password",
      "enterApplePass": "Enter Apple ID and Password",
      "email": "Email",
      "appleId": "Apple ID",
      "password": "Password",
      "confirmLogin": "Confirm Login",
      "notHappy": "Not satisfied?",
      "thanks": "Thank you for your feedback!",
      "chooseLang": "Choose Language",
      "sent": "Feedback sent to developer",
      "thanksHigh": "Thank you for the high rating ❤️",
  };

  static String get(String key) {
    return text[currentLang]?[key] ?? key;
  }
}
