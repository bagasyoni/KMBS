import 'dart:convert';
import 'package:flutter/services.dart';

class DataPodBahanImport {
  int noid;
  String nobukti;
  double qtypo;
  String kdbhn;
  String nabhn;
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
  String acnonm;

  DataPodBahanImport(
      {this.noid,
      this.nobukti,
      this.qtypo,
      this.kdbhn,
      this.nabhn,
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
      this.acnonm});

  factory DataPodBahanImport.fromJson(var parsedJson) {
    return DataPodBahanImport(
      noid: parsedJson['NO_ID'],
      nobukti: parsedJson['NO_BUKTI'] as String,
      qtypo: double.parse(parsedJson['QTYPO'].toString()),
      kdbhn: parsedJson['KD_BHN'] as String,
      nabhn: parsedJson['NA_BHN'] as String,
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
      acnonm: parsedJson['ACNO_NM'] as String ?? "",
    );
  }
}
