class SponsorsModel {
  String? sponsorId;
  String? businessName;
  String? address;
  String? details;
  String? image;
  String? offerName;
  String? businessLogo;
  String? websiteLink;

  SponsorsModel({
    this.sponsorId,
    this.businessName,
    this.address,
    this.details,
    this.image,
    this.offerName,
    this.businessLogo,
    this.websiteLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'sponsorId': sponsorId,
      'businessName': businessName,
      'address': address,
      'details': details,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
      'websiteLink': websiteLink,
    };
  }

  factory SponsorsModel.fromMap(Map<String, dynamic> map) {
    return SponsorsModel(
      sponsorId: map['sponsorId'],
      businessName: map['businessName'],
      address: map['address'],
      details: map['details'],
      image: map['image'],
      offerName: map['offerName'],
      businessLogo: map['businessLogo'],
      websiteLink: map['websiteLink'],
    );
  }
}
