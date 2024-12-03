class PushNotificationModel {
  String? pushNotificationId;
  String? title;
  String? content;
  List<String?>? userIds;

  PushNotificationModel({
    this.pushNotificationId,
    this.title,
    this.content,
    this.userIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'pushNotificationId': pushNotificationId,
      'title': title,
      'content': content,
      'userIds': userIds,
    };
  }

  factory PushNotificationModel.fromMap(Map<String, dynamic> map) {
    return PushNotificationModel(
      pushNotificationId: map['pushNotificationId'],
      title: map['title'],
      content: map['content'],
      userIds: map['userIds'] != null
          ? List<String>.from(
              map['userIds'],
            )
          : [],
    );
  }
}
