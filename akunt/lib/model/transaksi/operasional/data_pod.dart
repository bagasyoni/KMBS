import 'dart:convert';
import 'package:flutter/services.dart';

class DataPod {
  int noid;
  String kdbhn;
  String nabhn;
  String dr;
  String satuanpp;
  double qtypp;
  String satuan;
  double qty;
  double harga;
  double bulat;
  double total;
  double disk;
  double val;
  String warna;
  String size;
  String golongan;
  double lusin;
  double pair;

  DataPod(
      {this.noid,
      this.kdbhn,
      this.nabhn,
      this.dr,
      this.satuanpp,
      this.qtypp,
      this.satuan,
      this.qty,
      this.harga,
      this.bulat,
      this.total,
      this.disk,
      this.val,
      this.warna,
      this.size,
      this.golongan,
      this.lusin,
      this.pair});

  factory DataPod.fromJson(var parsedJson) {
    return DataPod(
      noid: parsedJson['NO_ID'],
      kdbhn: parsedJson['KD_BHN'] as String,
      nabhn: parsedJson['NA_BHN'] as String,
      dr: parsedJson['DR'] as String,
      satuanpp: parsedJson['SATUANPP'] as String,
      qtypp: double.parse(parsedJson['QTYPP'].toString()),
      satuan: parsedJson['SATUAN'] as String,
      qty: double.parse(parsedJson['QTY'].toString()),
      harga: double.parse(parsedJson['HARGA'].toString()),
      bulat: 0,
      total: double.parse(parsedJson['TOTAL'].toString()),
      disk: 0,
      val: 0,
      warna: parsedJson['WARNA'] as String,
      size: parsedJson['SIZE'] as String,
      golongan: parsedJson['GOL'] as String,
      lusin: 0,
      pair: 0,
    );
  }
}

class BahanViewModel {
  static List<DataPod> bahanList;

  static Future loadBahan() async {
    try {
      bahanList = new List<DataPod>();
      String jsonString = await rootBundle.loadString('assets/file/bahan.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['bahan'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        bahanList.add(new DataPod.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
