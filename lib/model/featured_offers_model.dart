class FeaturedOffersModel {
  String? offerId;
  String? businessName;
  String? discountType;
  String? discount;
  String? address;
  String? details;
  String? image;
  String? offerName;
  String? businessLogo;
  List<String>? isFavorite;
  List<String>? userIds;
  Map<String, List<String>>? userOfferCodes;

  FeaturedOffersModel({
    this.offerId,
    this.businessName,
    this.discountType,
    this.discount,
    this.address,
    this.details,
    this.image,
    this.offerName,
    this.businessLogo,
    this.isFavorite,
    this.userIds,
    this.userOfferCodes,
  });

  Map<String, dynamic> toMap() {
    return {
      'offerId': offerId,
      'businessName': businessName,
      'discountType': discountType,
      'discount': discount,
      'address': address,
      'details': details,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
      'isFavorite': isFavorite,
      'userIds': userIds ?? [],
      'userOfferCodes': userOfferCodes?.map(
            (key, value) => MapEntry(key, value),
          ) ??
          {},
    };
  }

  factory FeaturedOffersModel.fromMap(Map<String, dynamic> map) {
    return FeaturedOffersModel(
      offerId: map['offerId'],
      businessName: map['businessName'],
      discountType: map['discountType'],
      discount: map['discount'],
      address: map['address'],
      details: map['details'],
      image: map['image'],
      offerName: map['offerName'],
      businessLogo: map['businessLogo'],
      isFavorite: List<String>.from(
        map['isFavorite'] ?? [],
      ),
      userIds: List<String>.from(map['userIds'] ?? []),
      userOfferCodes: (map['userOfferCodes'] != null)
          ? (map['userOfferCodes'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List<dynamic>).map((e) => e.toString()).toList(),
              ),
            )
          : {},
    );
  }

  List<String>? getUserOfferCodes(String userId) {
    return userOfferCodes?[userId];
  }
}
