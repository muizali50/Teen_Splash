class SurveyModel {
  String id;
  String name;
  List<String> questions;

  SurveyModel({
    required this.id,
    required this.name,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'questions': questions,
    };
  }

  factory SurveyModel.fromMap(Map<String, dynamic> map) {
    return SurveyModel(
      id: map['id'],
      name: map['name'],
      questions: List<String>.from(map['questions']),
    );
  }
}
