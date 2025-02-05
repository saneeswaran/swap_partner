import 'dart:convert';

class DatabaseDetailModel {
  final String storeName;
  final int phoneNumber;
  final String category;
  final String location;

  DatabaseDetailModel(
      {required this.storeName,
      required this.phoneNumber,
      required this.category,
      required this.location});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeName': storeName,
      'phoneNumber': phoneNumber,
      'category': category,
      'location': location,
    };
  }

  factory DatabaseDetailModel.fromMap(Map<String, dynamic> map) {
    return DatabaseDetailModel(
      storeName: map['storeName'] as String,
      phoneNumber: map['phoneNumber'] as int,
      category: map['category'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DatabaseDetailModel.fromJson(String source) =>
      DatabaseDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
