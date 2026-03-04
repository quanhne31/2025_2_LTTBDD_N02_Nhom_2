import '../models/word_model.dart';

class WordService {
  static List<WordModel> words = [
    WordModel(
      word: "eye",
      phonetic: "[aɪ]",
      type: "noun",
      meaning: "mắt",
      englishMeaning: "the organ of sight",
      synonyms: ["vision", "sight"],
      specialty: "Y học",
      grammar: "Eye là danh từ đếm được.",
    ),
    WordModel(
      word: "envelop",
      phonetic: "[ɪnˈveləp]",
      type: "verb",
      meaning: "bao bọc, phủ",
      englishMeaning: "the organ of sight",
      synonyms: ["wrap", "cover"],
      specialty: "Quân sự",
      grammar: "energy là danh từ không đếm được.",
    ),
  ];

  static List<WordModel> search(String query) {
    return words
        .where(
          (word) => word.word.toLowerCase().startsWith(query.toLowerCase()),
        )
        .toList();
  }
}
