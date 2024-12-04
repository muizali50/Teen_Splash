class SurveyAnswerModel {
  String userId;
  String userName;
  String userEmail;
  Map<String, String> answers;

  SurveyAnswerModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'answers': answers,
    };
  }

  factory SurveyAnswerModel.fromMap(Map<String, dynamic> map) {
    return SurveyAnswerModel(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      answers: Map<String, String>.from(map['answers']),
    );
  }
}
