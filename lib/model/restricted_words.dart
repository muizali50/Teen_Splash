import 'package:cloud_firestore/cloud_firestore.dart';

class RestrictedWordsModel {
  final List<String> words;
  final DateTime updatedAt;

  RestrictedWordsModel({
    required this.words,
    required this.updatedAt,
  });

  factory RestrictedWordsModel.fromMap(Map<String, dynamic> map) {
    return RestrictedWordsModel(
      words: List<String>.from(map['words'] ?? []),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'words': words,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
