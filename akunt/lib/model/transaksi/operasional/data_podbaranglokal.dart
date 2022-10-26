import 'dart:convert';
import 'package:flutter/services.dart';

class DataPodBarangLokal {
  int noid;
  String no_bukti;
  double qtypo;
  String kd_brg;
  String na_brg;
  String satuan;
  double qty;
  String satuanbl;
  double qtybl;
  double harga1;
  double total1;
  String ket;
  double harga;
  double total;
  double blt;
  double disc;
  double rpdisc;
  String typ;
  String gol;
  double htg;
  String siz;
  String kd;
  String kodecab;
  String warna;
  String produk;
  String grp;
  String acno;
  String acno_nm;

  DataPodBarangLokal(
      {this.noid,
      this.no_bukti,
      this.qtypo,
      this.kd_brg,
      this.na_brg,
      this.satuan,
      this.qty,
      this.satuanbl,
      this.qtybl,
      this.harga1,
      this.total1,
      this.ket,
      this.harga,
      this.total,
      this.blt,
      this.disc,
      this.rpdisc,
      this.typ,
      this.gol,
      this.htg,
      this.siz,
      this.kd,
      this.kodecab,
      this.warna,
      this.produk,
      this.grp,
      this.acno,
      this.acno_nm});

  factory DataPodBarangLokal.fromJson(var parsedJson) {
    return DataPodBarangLokal(
      noid: parsedJson['NO_ID'],
      no_bukti: parsedJson['NO_BUKTI'] as String,
      qtypo: double.parse(parsedJson['QTYPO'].toString()),
      kd_brg: parsedJson['KD_BRG'] as String,
      na_brg: parsedJson['NA_BRG'] as String,
      satuan: parsedJson['SATUAN'] as String,
      qty: double.parse(parsedJson['QTY'].toString()),
      satuanbl: parsedJson['SATUANBL'] as String ?? "",
      qtybl: 0.00,
      harga1: double.parse(parsedJson['HARGA1'].toString()),
      total1: double.parse(parsedJson['TOTAL1'].toString()),
      ket: parsedJson['RATE'] as String,
      harga: double.parse(parsedJson['HARGA'].toString()),
      total: double.parse(parsedJson['TOTAL'].toString()),
      blt: double.parse(parsedJson['BLT'].toString()),
      disc: double.parse(parsedJson['DISC'].toString()),
      rpdisc: double.parse(parsedJson['RPDISC'].toString()),
      typ: parsedJson['TYP'] as String ?? "",
      gol: parsedJson['GOL'] as String ?? "",
      htg: double.parse(parsedJson['HTG'].toString()),
      siz: parsedJson['SIZ'] as String ?? "",
      kd: parsedJson['KD'] as String ?? "",
      kodecab: parsedJson['KODECAB'] as String ?? "",
      warna: parsedJson['WARNA'] as String ?? "",
      produk: parsedJson['PRODUK'] as String ?? "",
      grp: parsedJson['GRP'] as String ?? "",
      acno: parsedJson['ACNO'] as String ?? "",
      acno_nm: parsedJson['ACNO_NM'] as String ?? "",
    );
  }
}
