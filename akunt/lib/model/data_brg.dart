import 'dart:convert';

import 'package:flutter/services.dart';

class DataBrg {
  int noid;
  String kd_brg;
  String na_brg;
  String satuan;
  String ket;
  String acno;
  String acno_nm;
  double harga;
  double qty;
  double stockr;
  double fisik;
  double total;
  double sisa;
  double kirim;

  DataBrg(
      {this.noid,
      this.kd_brg,
      this.na_brg,
      this.satuan,
      this.ket,
      this.acno,
      this.acno_nm,
      this.harga,
      this.qty,
      this.stockr,
      this.fisik,
      this.total,
      this.sisa,
      this.kirim});

  factory DataBrg.fromJson(var parsedJson) {
    return DataBrg(
      noid: parsedJson['NO_ID'],
      kd_brg: parsedJson['KD_BRG'] as String,
      na_brg: parsedJson['NA_BRG'] as String,
      satuan: parsedJson['SATUAN'] as String,
      ket: parsedJson['NOTES'] as String,
      acno: parsedJson['ACNO'] as String,
      acno_nm: parsedJson['ACNO_NM'] as String,
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
  static List<DataBrg> bahanList;

  static Future loadBahan() async {
    try {
      bahanList = new List<DataBrg>();
      String jsonString = await rootBundle.loadString('assets/file/bahan.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['bahan'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        bahanList.add(new DataBrg.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
