import 'dart:convert';
import 'package:flutter/services.dart';

class DataHutang {
  int noid;
  String no_bukti;
  String tgl;
  String kodes;
  String namas;
  String acno;
  String nacno;
  String uraian;
  double sisa;
  double jumlah;
  double jumlahrp;
  String info;
  String flag;
  String curr;
  double rate;
  String noinv;

  DataHutang(
      {this.noid,
      this.no_bukti,
      this.tgl,
      this.kodes,
      this.namas,
      this.acno,
      this.nacno,
      this.uraian,
      this.sisa,
      this.jumlah,
      this.jumlahrp,
      this.info,
      this.flag,
      this.curr,
      this.rate,
      this.noinv});

  factory DataHutang.fromJson(var parsedJson) {
    return DataHutang(
      noid: parsedJson['NO_ID'],
      no_bukti: parsedJson['NO_BUKTI'] as String,
      tgl: parsedJson['TGL'] as String,
      kodes: parsedJson['KODES'] as String,
      namas: parsedJson['NAMAS'] as String,
      acno: parsedJson['ACNO'] as String,
      nacno: parsedJson['NACNO'] as String,
      uraian: parsedJson['INFO'] as String,
      sisa: double.parse(parsedJson['SISA'].toString()),
      jumlah: double.parse(parsedJson['JUMLAH'].toString()),
      jumlahrp: double.parse(parsedJson['JUMLAH'].toString()),
      info: parsedJson['INFO'] as String,
      flag: parsedJson['FLAG'] as String,
      curr: parsedJson['CURR'] as String,
      rate: double.parse(parsedJson['RATE'].toString()),
      noinv: "",
    );
  }
}
