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
}
