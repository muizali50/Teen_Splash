class FeaturedOffersModel {
  String? offerId;
  String? businessName;
  String? discount;
  String? address;
  String? details;
  String? image;
  String? offerName;
  String? businessLogo;

  FeaturedOffersModel({
    this.offerId,
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
      'offerId': offerId,
      'businessName': businessName,
      'discount': discount,
      'address': address,
      'details': details,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
    };
  }

  factory FeaturedOffersModel.fromMap(Map<String, dynamic> map) {
    return FeaturedOffersModel(
      offerId: map['offerId'],
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
