import 'dart:convert';

import 'package:flutter/services.dart';

class DataBarang {
  int id;
  String kd_brg;
  String na_brg;
  String satuan;
  double stok;
  double harga_po;
  double harga_beli;
  double harga_jual;
  double stok_booking;

  DataBarang(
      {this.kd_brg,
      this.id,
      this.na_brg,
      this.satuan,
      this.stok,
      this.harga_jual,
      this.harga_beli,
      this.harga_po,
      this.stok_booking});

  factory DataBarang.fromJson(var parsedJson) {
    return DataBarang(
        kd_brg: parsedJson['kd_brg'] as String,
        id: parsedJson['id'],
        na_brg: parsedJson['na_brg'] as String,
        satuan: parsedJson['satuan'] as String,
        stok: parsedJson['stok'],
        harga_beli: parsedJson['harga_beli'],
        harga_jual: parsedJson['harga_jual']);
  }
}

class BarangViewModel {
  static List<DataBarang> barangList;

  static Future loadBarang() async {
    try {
      barangList = new List<DataBarang>();
      String jsonString =
          await rootBundle.loadString('assets/file/barang.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['barang'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        barangList.add(new DataBarang.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
