class MondayOffersModel {
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
  List<String>? isFavorite;
  List<String>? userIds;
  Map<String, String>? userOfferCodes;

  MondayOffersModel({
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
      'date': date,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
      'isFavorite': isFavorite,
      'userIds': userIds ?? [],
      'userOfferCodes': userOfferCodes ?? {},
    };
  }

  factory MondayOffersModel.fromMap(Map<String, dynamic> map) {
    return MondayOffersModel(
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
      isFavorite: List<String>.from(
        map['isFavorite'] ?? [],
      ),
      userIds: List<String>.from(map['userIds'] ?? []),
      userOfferCodes: Map<String, String>.from(map['userOfferCodes'] ?? {}),
    );
  }
  String? getUserOfferCode(String userId) {
    return userOfferCodes?[userId];
  }
}
