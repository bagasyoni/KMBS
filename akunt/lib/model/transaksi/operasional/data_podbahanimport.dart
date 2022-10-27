import 'dart:convert';
import 'package:flutter/services.dart';

class DataPodBahanImport {
  int noid;
  String nobukti;
  String kdbhn;
  String nabhn;
  String satuan;
  double qty;
  String satuanbl;
  double qtybl;
  double harga1;
  double total1;
  String notes;
  double harga;
  double total;


  DataPodBahanImport(
      {this.noid,
      this.nobukti,
      this.kdbhn,
      this.nabhn,
      this.satuan,
      this.qty,
      this.satuanbl,
      this.qtybl,
      this.harga1,
      this.total1,
      this.notes,
      this.harga,
      this.total});

  factory DataPodBahanImport.fromJson(var parsedJson) {
    return DataPodBahanImport(
      noid: parsedJson['NO_ID'],
      nobukti: parsedJson['NO_BUKTI'] as String,
      kdbhn: parsedJson['KD_BHN'] as String,
      nabhn: parsedJson['NA_BHN'] as String,
      satuan: parsedJson['SATUAN'] as String,
      qty: double.parse(parsedJson['QTY'].toString()),
      satuanbl: parsedJson['SATUANBL'] as String ?? "",
      qtybl: 0.00,
      harga1: double.parse(parsedJson['HARGA1'].toString()),
      total1: double.parse(parsedJson['TOTAL1'].toString()),
      notes: parsedJson['NOTES'] as String,
      harga: double.parse(parsedJson['HARGA'].toString()),
      total: double.parse(parsedJson['TOTAL'].toString()),
    );
  }
}
