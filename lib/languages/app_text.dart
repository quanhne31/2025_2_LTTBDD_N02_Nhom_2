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
  };

  static String get(String key) {
    return text[currentLang]?[key] ?? key;
  }
}
