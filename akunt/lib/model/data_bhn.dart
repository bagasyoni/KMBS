import 'dart:convert';

import 'package:flutter/services.dart';

class DataBhn {
  int noid;
  String kd_bhn;
  String na_bhn;
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
  double qtypo;
  double harga1;
  double total1;
  double blt;
  double disc;
  double rpdisc;

  DataBhn(
      {this.noid,
      this.kd_bhn,
      this.na_bhn,
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
      this.kirim,
      this.qtypo,
      this.harga1,
      this.total1,
      this.blt,
      this.disc,
      this.rpdisc});

  factory DataBhn.fromJson(var parsedJson) {
    return DataBhn(
      noid: parsedJson['NO_ID'],
      kd_bhn: parsedJson['KD_BHN'] as String,
      na_bhn: parsedJson['NA_BHN'] as String,
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
      qtypo: 0.00,
      harga1: 0.00,
      total1: 0.00,
      blt: 0.00,
      disc: 0.00,
      rpdisc: 0.00,
    );
  }
}
