class MondayOffersModel {
  String? offerId;
  String? businessName;
  String? discount;
  String? address;
  String? details;
  String? date;
  String? image;
  String? offerName;
  String? businessLogo;

  MondayOffersModel({
    this.offerId,
    this.businessName,
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
      'discount': discount,
      'address': address,
      'details': details,
      'date': date,
      'image': image,
      'offerName': offerName,
      'businessLogo': businessLogo,
    };
  }

  factory MondayOffersModel.fromMap(Map<String, dynamic> map) {
    return MondayOffersModel(
      offerId: map['offerId'],
      businessName: map['businessName'],
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
