import 'dart:convert';

import 'package:flutter/services.dart';

class DataBhn {
  int noid;
  String kd_bhn;
  String na_bhn;
  String satuan;
  String ket;
  double harga;
  double qty;
  double stockr;
  double fisik;
  double total;
  double sisa;
  double kirim;

  DataBhn(
      {this.noid,
      this.kd_bhn,
      this.na_bhn,
      this.satuan,
      this.ket,
      this.harga,
      this.qty,
      this.stockr,
      this.fisik,
      this.total,
      this.sisa,
      this.kirim});

  factory DataBhn.fromJson(var parsedJson) {
    return DataBhn(
      noid: parsedJson['NO_ID'],
      kd_bhn: parsedJson['KD_BHN'] as String,
      na_bhn: parsedJson['NA_BHN'] as String,
      satuan: parsedJson['SATUAN'] as String,
      ket: parsedJson['NOTES'] as String,
      sisa: 0.00,
      harga: 0.00,
      qty: 0.00,
      stockr: 0.00,
      fisik: 0.00,
      total: 0.00,
      kirim: 0.00,
    );
  }
}

class BahanViewModel {
  static List<DataBhn> bahanList;

  static Future loadBahan() async {
    try {
      bahanList = new List<DataBhn>();
      String jsonString = await rootBundle.loadString('assets/file/bahan.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['bahan'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        bahanList.add(new DataBhn.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
