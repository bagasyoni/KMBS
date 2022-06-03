import 'dart:convert';
import 'package:flutter/services.dart';

class SuppModel {
  int id;
  String no_supp;
  String kodes;
  String namas;
  String nama;
  String almt_k;

  SuppModel(
      {this.id, this.no_supp, this.kodes, this.namas, this.nama, this.almt_k});

  factory SuppModel.fromJson(var parsedJson) {
    return SuppModel(
        id: parsedJson['NO_ID'],
        no_supp: parsedJson['NO_SUPP'] as String,
        kodes: parsedJson['KODES'] as String,
        namas: parsedJson['NAMAS'] as String,
        nama: parsedJson['NAMA'] as String,
        almt_k: parsedJson['ALMT_K'] as String);
  }
}

class SupplierViewModel {
  static List<SuppModel> supplierList;

  static Future loadSupplier() async {
    try {
      supplierList = new List<SuppModel>();
      String jsonString =
          await rootBundle.loadString('assets/file/supplier.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['supplier'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        supplierList.add(new SuppModel.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
