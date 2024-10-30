class CouponModel {
  String? couponId;
  String? businessName;
  String? discount;
  String? item;
  String? validDate;
  String? image;
  List<String>? userIds;

  CouponModel({
    this.couponId,
    this.businessName,
    this.discount,
    this.item,
    this.validDate,
    this.image,
    this.userIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'couponId': couponId,
      'businessName': businessName,
      'discount': discount,
      'item': item,
      'validDate': validDate,
      'image': image,
      'userIds': userIds ?? [],
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      couponId: map['couponId'],
      businessName: map['businessName'],
      discount: map['discount'],
      item: map['item'],
      validDate: map['validDate'],
      image: map['image'],
      userIds: List<String>.from(map['userIds'] ?? []),
    );
  }
}
