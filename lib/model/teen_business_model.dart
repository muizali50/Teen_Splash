class TeenBusinessModel {
  String? businessId;
  String? businessName;
  String? details;
  String? image;
  String? offerName;
  String? businessLogo;
  String? websiteLink;

  TeenBusinessModel({
    this.businessId,
    this.businessName,
    this.details,
    this.image,
    this.offerName,
    this.businessLogo,
    this.websiteLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'businessName': businessName,
      'details': details,
      'image': image,
      'offerName': offerName,
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
      offerName: map['offerName'],
      businessLogo: map['businessLogo'],
      websiteLink: map['websiteLink'],
    );
  }
}
