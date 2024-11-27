class CouponModel {
  String? couponId;
  String? businessName;
  String? discountType;
  String? discount;
  String? item;
  String? validDate;
  String? image;
  List<String>? userIds;
  List<String>? views;

  CouponModel({
    this.couponId,
    this.businessName,
    this.discountType,
    this.discount,
    this.item,
    this.validDate,
    this.image,
    this.userIds,
    this.views,
  });

  Map<String, dynamic> toMap() {
    return {
      'couponId': couponId,
      'businessName': businessName,
      'discountType': discountType,
      'discount': discount,
      'item': item,
      'validDate': validDate,
      'image': image,
      'userIds': userIds ?? [],
      'views': views ?? [],
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      couponId: map['couponId'],
      businessName: map['businessName'],
      discountType: map['discountType'],
      discount: map['discount'],
      item: map['item'],
      validDate: map['validDate'],
      image: map['image'],
      userIds: List<String>.from(map['userIds'] ?? []),
      views: List<String>.from(map['views'] ?? []),
    );
  }
}
