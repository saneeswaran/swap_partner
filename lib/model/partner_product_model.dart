class PartnerProductModel {
  int productId;
  String imageUrl;
  String productName;
  int productPrice;
  String category;
  int swapPoints;
  PartnerProductModel({
    required this.productId,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.swapPoints,
  });
}

List<String> categories = [
  "Electronics",
  "Clothing",
  "Books",
  "Home Appliances",
  "Dining",
  "Bed",
  "Wardrobe",
  "Sofa"
];
