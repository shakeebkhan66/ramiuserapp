// To parse this JSON data, do
//
//     final myVehicleModel = myVehicleModelFromJson(jsonString);

import 'dart:convert';

List<MyVehicleModel> myVehicleModelFromJson(String str) => List<MyVehicleModel>.from(json.decode(str).map((x) => MyVehicleModel.fromJson(x)));

String myVehicleModelToJson(List<MyVehicleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyVehicleModel {
  MyVehicleModel({
    required this.id,
    required this.nickName,
    required this.year,
    required this.plateNumber,
    required this.type,
    required this.image,
  });

  String id;
  String nickName;
  String year;
  String plateNumber;
  String type;
  String image;

  factory MyVehicleModel.fromJson(Map<String, dynamic> json) => MyVehicleModel(
    id: json["id"],
    nickName: json["nickName"],
    year: json["year"],
    plateNumber: json["plateNumber"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "year": year,
    "plateNumber": plateNumber,
    "type": type,
    "image": image,
  };
}
