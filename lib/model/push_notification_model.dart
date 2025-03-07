class PushNotificationModel {
  String? pushNotificationId;
  String? title;
  String? content;
  String? date;
  List<String?>? userIds;
  bool? isForAllUsers;
  List<String>? userTokens;

  PushNotificationModel({
    this.pushNotificationId,
    this.title,
    this.content,
    this.date,
    this.userIds,
    this.isForAllUsers,
    this.userTokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'pushNotificationId': pushNotificationId,
      'title': title,
      'content': content,
      'date': date,
      'userIds': userIds,
      'isForAllUsers': isForAllUsers,
      'userTokens': userTokens,
    };
  }

  factory PushNotificationModel.fromMap(Map<String, dynamic> map) {
    return PushNotificationModel(
      pushNotificationId: map['pushNotificationId'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      userIds: map['userIds'] != null
          ? List<String>.from(
              map['userIds'],
            )
          : [],
      isForAllUsers: map['isForAllUsers'],
      userTokens:
          map['userTokens'] != null ? List<String>.from(map['userTokens']) : [],
    );
  }
}
