// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerProductModel {
  int productId;
  String productName;
  String productDescription;
  String productImage;
  int productPrice;
  int swapPoints;
  String location;

  CustomerProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.productPrice,
    required this.swapPoints,
    required this.location,
  });
  static List<CustomerProductModel> dummy = List.generate(
      10,
      (index) => CustomerProductModel(
            productId: index + 1,
            productName: 'Product $index',
            swapPoints: (index + 1) * 10,
            productDescription: 'Description for product $index',
            productImage:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            productPrice: (index + 1) * 10,
            location: 'Location $index',
          ));
}
