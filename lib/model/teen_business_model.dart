class TeenBusinessModel {
  String? businessId;
  String? businessName;
  String? details;
  String? image;
  String? businessLogo;
  String? websiteLink;

  TeenBusinessModel({
    this.businessId,
    this.businessName,
    this.details,
    this.image,
    this.businessLogo,
    this.websiteLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'businessName': businessName,
      'details': details,
      'image': image,
      'businessLogo': businessLogo,
      'websiteLink': websiteLink,
    };
  }

  factory TeenBusinessModel.fromMap(Map<String, dynamic> map) {
    return TeenBusinessModel(
      businessId: map['businessId'],
      businessName: map['businessName'],
      details: map['details'],
      image: map['image'],
      businessLogo: map['businessLogo'],
      websiteLink: map['websiteLink'],
    );
  }
}
