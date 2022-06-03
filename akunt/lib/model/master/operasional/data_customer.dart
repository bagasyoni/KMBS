import 'dart:convert';
import 'package:flutter/services.dart';

class CusModel {
  int id;
  String kodec;
  String namac;
  String alamat;
  String kota;

  CusModel({this.id, this.kodec, this.namac, this.alamat, this.kota});

  factory CusModel.fromJson(var parsedJson) {
    return CusModel(
        id: parsedJson['NO_ID'],
        kodec: parsedJson['KODEC'] as String,
        namac: parsedJson['NAMAC'] as String,
        alamat: parsedJson['ALAMAT'] as String,
        kota: parsedJson['KOTA'] as String);
  }
}

class CustomerViewModel {
  static List<CusModel> customerList;

  static Future loadSupplier() async {
    try {
      customerList = new List<CusModel>();
      String jsonString =
          await rootBundle.loadString('assets/file/customer.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['customer'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        customerList.add(new CusModel.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
