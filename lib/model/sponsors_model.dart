class SponsorsModel {
  String? sponsorId;
  String? businessName;
  String? discount;
  String? address;
  String? details;
  String? image;
  String? offerName;
  String? businessLogo;

  SponsorsModel({
    this.sponsorId,
    this.businessName,
    this.discount,
    this.address,
    this.details,
    this.image,
    this.offerName,
    this.businessLogo,
  });

  Map<String, dynamic> toMap() {
    return {
      'sponsorId': sponsorId,
      'businessName': businessName,
      'discount': discount,
      'address': address,
      'details': details,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
    };
  }

  factory SponsorsModel.fromMap(Map<String, dynamic> map) {
    return SponsorsModel(
      sponsorId: map['sponsorId'],
      businessName: map['businessName'],
      discount: map['discount'],
      address: map['address'],
      details: map['details'],
      image: map['image'],
      offerName: map['offerName'],
      businessLogo: map['businessLogo'],
    );
  }
}
