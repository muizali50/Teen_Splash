class PushNotificationModel {
  String? pushNotificationId;
  String? title;
  String? status;
  
  PushNotificationModel({
    this.pushNotificationId,
    this.title,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'pushNotificationId': pushNotificationId,
      'title': title,
      'status': status,
    };
  }

  factory PushNotificationModel.fromMap(Map<String, dynamic> map) {
    return PushNotificationModel(
      pushNotificationId: map['pushNotificationId'],
      title: map['title'],
      status: map['status'],
    );
  }
}
