# 📚 Dictionary App - Ứng dụng Học Từ Vựng Tiếng Anh

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

**Dictionary App** là một ứng dụng di động đa nền tảng (Android, iOS, Web) được phát triển bằng Flutter. Ứng dụng cung cấp các chức năng như tra cứu từ điển, dịch văn bản, học từ vựng theo bộ và quản lý từ vựng cá nhân.
Dự án được xây dựng nhằm hỗ trợ người học tiếng Anh tra cứu và ghi nhớ từ vựng hiệu quả hơn.

---

## 🔗 Demo



---

# 📸 Giao diện & Tính năng


---

# 🌟 Tính năng chính

## 🔎 Tra cứu từ vựng

Ứng dụng cho phép người dùng tra cứu từ vựng tiếng Anh một cách nhanh chóng và chi tiết.

Kết quả tra cứu hiển thị nhiều thông tin bao gồm:

- **Anh – Việt:** Nghĩa tiếng Việt của từ
- **Anh – Anh:** Giải thích nghĩa bằng tiếng Anh
- **Ngữ pháp:** Loại từ và cách sử dụng
- **Chuyên ngành:** Nghĩa của từ trong các lĩnh vực chuyên môn

Tính năng này giúp người học hiểu rõ nghĩa và cách sử dụng từ trong nhiều ngữ cảnh khác nhau.

---

## 🌐 Dịch văn bản

Ứng dụng hỗ trợ dịch nội dung với hai hình thức:

### Dịch đoạn văn bản
Người dùng có thể nhập một đoạn văn bản để dịch giữa các ngôn ngữ.

### Dịch hình ảnh
Người dùng có thể chụp hoặc tải lên hình ảnh chứa văn bản để hệ thống nhận diện và dịch nội dung trong ảnh.

Tính năng này giúp người dùng dịch nhanh nội dung trong học tập và đời sống.

---

## 💎 Gói từ vựng VIP

Ứng dụng cung cấp các **gói từ vựng VIP** giúp người dùng học từ vựng theo từng bộ từ.

Các gói từ vựng bao gồm:

- Từ vựng **SGK cũ**
- Từ vựng **SGK mới**
- Từ vựng **luyện thi**

Những gói từ này hỗ trợ người học ôn tập từ vựng theo chương trình học hoặc mục tiêu thi cử.

---

## ⭐ Từ của bạn

Màn hình **Từ của bạn** cho phép người dùng lưu lại các từ vựng quan trọng bằng cách đánh dấu yêu thích.

Người dùng có thể:

- Lưu từ vựng
- Xem danh sách các từ đã lưu
- Xóa từ khỏi danh sách

⚠️ Tính năng này yêu cầu **người dùng đăng nhập** trước khi sử dụng.

---

## 📜 Từ đã tra

Ứng dụng lưu lại **lịch sử các từ đã tra cứu** của người dùng.

Người dùng có thể:

- Xem lại danh sách các từ đã tra
- Tra cứu lại nhanh chóng các từ trước đó

⚠️ Tính năng này yêu cầu **đăng nhập** để sử dụng.

---

## ⚙️ Cài đặt

Màn hình cài đặt cho phép người dùng tùy chỉnh và quản lý ứng dụng.

Các tùy chọn bao gồm:

- 🌙 Chế độ **Sáng / Tối**
- 🌍 Chuyển đổi **ngôn ngữ (Tiếng Việt / English)**
- 📧 Gửi **email phản hồi**
- ⭐ **Đánh giá ứng dụng**
- ℹ️ Trang **Về chúng tôi**

---

# 🛠️ Công nghệ sử dụng

* **Framework:** Flutter 3.x  
* **Ngôn ngữ:** Dart  
* **UI Framework:** Material Design (Flutter Material Widgets)  
* **State Management:** setState  
* **Lưu trữ cục bộ:** SharedPreferences  
* **Quản lý dữ liệu:** Model JSON (`WordModel`)  
* **Đa ngôn ngữ:** Custom Localization (`AppText`)  
* **Xử lý hình ảnh:** Flutter Image Picker / Camera (dùng cho dịch hình ảnh)

---

# 🚀 Cài đặt và chạy dự án

### 1️⃣ Clone project

```bash
git clone https://github.com/quanhne31/2025_2_LTTBDD_N02_Nhom_2
cd 2025_2_LTTBDD_N02_Nhom_2
```

### 2️⃣ Cài dependencies

```bash
flutter pub get
```

### 3️⃣ Chạy ứng dụng

```bash
flutter run
```

Hoặc chạy trên Chrome:

```bash
flutter run -d chrome
```

---

# 📂 Cấu trúc thư mục

```
dictionary_app/
    ├── android/                # Cấu hình và mã nguồn dành cho Android
    ├── ios/                    # Cấu hình và mã nguồn dành cho iOS
    ├── linux/                  # Hỗ trợ chạy trên Linux
    ├── macos/                  # Hỗ trợ chạy trên macOS
    ├── web/                    # Hỗ trợ chạy trên Web
    ├── windows/                # Hỗ trợ chạy trên Windows
    │
    ├── lib/                    # Thư mục chính chứa source code Flutter
    │   ├── data/               # Dữ liệu của ứng dụng
    │   │
    |   ├── languages/          # Dữ liệu ngôn ngữ
    │   │
    │   ├── models/             # Các model dữ liệu
    │   │
    │   ├── screens/            # Các màn hình giao diện của ứng dụng
    │   │   ├── about_screen.dart
    │   │   ├── account_screen.dart
    │   │   ├── detail_screen.dart
    │   │   ├── exam_list_screen.dart
    │   │   ├── exam_vocab_screen.dart
    │   │   ├── favorite_screen.dart
    │   │   ├── history_screen.dart
    │   │   ├── home_screen.dart
    │   │   ├── login_screen.dart
    │   │   ├── settings_screen.dart
    │   │   ├── skg_vocab_screen.dart
    │   │   ├── text_translate_screen.dart
    │   │   ├── unit_screen.dart
    │   │   ├── vocab_list_screen.dart
    │   │   └── your_words_screen.dart
    │   │
    │   ├── services/           # Các service xử lý logic / API / database
    │   │
    │   └── main.dart           # Điểm khởi đầu, cấu hình MaterialApp
    │
    ├── test/                   # Unit test và widget test
    │
    ├── .gitignore              # File bỏ qua khi push Git
    ├── metadata                # Metadata của Flutter project
    ├── analysis_options.yaml   # Cấu hình lint cho Dart
    ├── pubspec.yaml            # Quản lý thư viện và assets
    └── pubspec.lock            # Lock version dependencies
```

---

# 🔮 Hướng phát triển trong tương lai

- Tích hợp API từ điển thật (Oxford / Free Dictionary API)
- Thêm phát âm audio
- Thêm flashcard học từ vựng
- Thêm quiz kiểm tra từ vựng
- Lưu dữ liệu bằng Firebase

---

# 📬 Liên hệ

**Email:**  

**GitHub:**  https://github.com/quanhne31/2025_2_LTTBDD_N02_Nhom_2