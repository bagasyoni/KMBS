import 'dart:convert';

import 'package:flutter/services.dart';

class DataBeli {
  int noid;
  double rec;
  String no_bukti;
  String notes;
  double total;
  double bayar;
  double sisa;

  DataBeli({
    this.noid,
    this.no_bukti,
    this.notes,
    this.total,
    this.bayar,
    this.sisa,
  });

  factory DataBeli.fromJson(var parsedJson) {
    return DataBeli(
      noid: parsedJson['NO_ID'],
      no_bukti: parsedJson['NO_BUKTI'] as String,
      notes: parsedJson['NOTES'] as String,
      total: double.parse(parsedJson['TOTAL'].toString()),
      sisa: double.parse(parsedJson['SISA'].toString()),
      bayar: 0.00,
    );
  }
}

class BarangViewModel {
  static List<DataBeli> beliList;

  static Future loadBarang() async {
    try {
      beliList = new List<DataBeli>();
      String jsonString =
          await rootBundle.loadString('assets/file/barang.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['barang'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        beliList.add(new DataBeli.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
