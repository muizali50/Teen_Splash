class FavoriteOfferModel {
  String? offerId;
  String? businessName;
  String? discountType;
  String? discount;
  String? address;
  String? details;
  String? date;
  String? image;
  String? offerName;
  String? businessLogo;

  FavoriteOfferModel({
    this.offerId,
    this.businessName,
    this.discountType,
    this.discount,
    this.address,
    this.details,
    this.date,
    this.image,
    this.offerName,
    this.businessLogo,
  });

  Map<String, dynamic> toMap() {
    return {
      'offerId': offerId,
      'businessName': businessName,
      'discountType': discountType,
      'discount': discount,
      'address': address,
      'details': details,
      'date': date,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
    };
  }

  factory FavoriteOfferModel.fromMap(Map<String, dynamic> map) {
    return FavoriteOfferModel(
      offerId: map['offerId'],
      businessName: map['businessName'],
      discountType: map['discountType'],
      discount: map['discount'],
      address: map['address'],
      details: map['details'],
      date: map['date'],
      image: map['image'],
      offerName: map['offerName'],
      businessLogo: map['businessLogo'],
    );
  }
}
