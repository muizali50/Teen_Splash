class WaterSponsorModel {
  String? waterSponsorId;
  String? title;
  String? description;
  String? status;
  String? image;

  WaterSponsorModel({
    this.waterSponsorId,
    this.title,
    this.description,
    this.status,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'waterSponsorId': waterSponsorId,
      'title': title,
      'description': description,
      'status': status,
      'image': image,
    };
  }

  factory WaterSponsorModel.fromMap(Map<String, dynamic> map) {
    return WaterSponsorModel(
      waterSponsorId: map['waterSponsorId'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
      image: map['image'],
    );
  }
}
