import 'dart:convert';

import 'package:flutter/services.dart';

class DataJual {
  int noid;
  double rec;
  String no_bukti;
  String notes;
  double total;
  double bayar;

  DataJual({
    this.noid,
    this.no_bukti,
    this.notes,
    this.total,
    this.bayar,
  });

  factory DataJual.fromJson(var parsedJson) {
    return DataJual(
      noid: parsedJson['NO_ID'],
      no_bukti: parsedJson['NO_BUKTI'] as String,
      notes: parsedJson['NOTES'] as String,
      total: double.parse(parsedJson['TOTAL'].toString()),
      bayar: 0.00,
    );
  }
}

class BarangViewModel {
  static List<DataJual> beliList;

  static Future loadBarang() async {
    try {
      beliList = new List<DataJual>();
      String jsonString =
          await rootBundle.loadString('assets/file/barang.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['barang'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        beliList.add(new DataJual.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
