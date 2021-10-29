import 'dart:io';

class ProductPhotos {
  final File image1;
  final File image2;
  final File image3;
  final File image4;
  final File image5;

  ProductPhotos(
      {this.image1, this.image2, this.image3, this.image4, this.image5});
  factory ProductPhotos.fromJson(Map<String, dynamic> prod) {
    return ProductPhotos(
      image1: prod["image1"],
      image2: prod["image2"],
      image3: prod["image3"],
      image4: prod["image4"],
      image5: prod["image5"],
    );
  }
}
