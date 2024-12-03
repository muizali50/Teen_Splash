class TickerNotificationModel {
  String? pushNotificationId;
  String? title;
  String? status;
  
  TickerNotificationModel({
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

  factory TickerNotificationModel.fromMap(Map<String, dynamic> map) {
    return TickerNotificationModel(
      pushNotificationId: map['pushNotificationId'],
      title: map['title'],
      status: map['status'],
    );
  }
}
