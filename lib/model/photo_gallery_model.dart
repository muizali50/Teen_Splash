class PhotoGalleryModel {
  String? photoGalleryId;
  String? name;
  String? description;
  String? image;
  String? websiteLink;

  PhotoGalleryModel({
    this.photoGalleryId,
    this.name,
    this.description,
    this.image,
    this.websiteLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'photoGalleryId': photoGalleryId,
      'name': name,
      'description': description,
      'image': image,
      'websiteLink': websiteLink,
    };
  }

  factory PhotoGalleryModel.fromMap(Map<String, dynamic> map) {
    return PhotoGalleryModel(
      photoGalleryId: map['photoGalleryId'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      websiteLink: map['websiteLink'],
    );
  }
}
