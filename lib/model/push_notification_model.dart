class PushNotificationModel {
  String? pushNotificationId;
  String? title;
  String? content;
  String? date;
  List<String?>? userIds;

  PushNotificationModel({
    this.pushNotificationId,
    this.title,
    this.content,
    this.date,
    this.userIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'pushNotificationId': pushNotificationId,
      'title': title,
      'content': content,
      'date': date,
      'userIds': userIds,
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
    );
  }
}
