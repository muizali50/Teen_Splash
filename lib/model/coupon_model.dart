class CouponModel {
  String? couponId;
  String? businessName;
  String? discountType;
  String? discount;
  String? item;
  String? validDate;
  String? image;
  String? qrCodeUrl;
  List<String>? userIds;
  List<String>? views;
  List<DateTime>? redemptionDates;

  CouponModel({
    this.couponId,
    this.businessName,
    this.discountType,
    this.discount,
    this.item,
    this.validDate,
    this.image,
    this.qrCodeUrl,
    this.userIds,
    this.views,
    this.redemptionDates,
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
      'qrCodeUrl': qrCodeUrl,
      'userIds': userIds ?? [],
      'views': views ?? [],
      'redemptionDates':
          redemptionDates?.map((e) => e.toIso8601String()).toList() ?? [],
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
      qrCodeUrl: map['qrCodeUrl'],
      userIds: List<String>.from(map['userIds'] ?? []),
      views: List<String>.from(map['views'] ?? []),
      redemptionDates: (map['redemptionDates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );
  }
}
