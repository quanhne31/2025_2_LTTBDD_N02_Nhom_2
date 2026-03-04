import 'dart:convert';

class WordModel {
  final String word;
  final String phonetic;
  final String type;
  final String meaning;
  final String grammar;
  final List<String> synonyms;
  final String specialty;

  WordModel({
    required this.word,
    required this.phonetic,
    required this.type,
    required this.meaning,
    required this.grammar,
    required this.synonyms,
    required this.specialty,
  });

  // 🔹 Convert object → Map
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'phonetic': phonetic,
      'type': type,
      'meaning': meaning,
      'grammar': grammar,
      'synonyms': synonyms,
      'specialty': specialty,
    };
  }

  // 🔹 Map → Object
  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      word: map['word'] ?? '',
      phonetic: map['phonetic'] ?? '',
      type: map['type'] ?? '',
      meaning: map['meaning'] ?? '',
      grammar: map['grammar'] ?? '',
      synonyms: List<String>.from(map['synonyms'] ?? []),
      specialty: map['specialty'] ?? '',
    );
  }

  // 🔹 Object → JSON String
  String toJson() => jsonEncode(toMap());

  // 🔹 JSON String → Object
  factory WordModel.fromJson(String source) =>
      WordModel.fromMap(jsonDecode(source));
}
