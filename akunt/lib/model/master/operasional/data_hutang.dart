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
  double sisa;
  double jumlahrp;
  String info;
  String flag;
  String curr;
  double rate;
  String noinv;

  DataHutang({
    this.noid,
    this.no_bukti,
    this.tgl,
    this.kodes,
    this.namas,
    this.acno,
    this.nacno,
    this.sisa,
    this.jumlahrp,
    this.info,
    this.flag,
    this.curr,
    this.rate,
    this.noinv
  });

  factory DataHutang.fromJson(var parsedJson) {
    return DataHutang(
      noid: parsedJson['NO_ID'],
      no_bukti: parsedJson['NO_BUKTI'] as String,
      tgl: parsedJson['TGL'] as String,
      kodes: parsedJson['KODES'] as String,
      namas: parsedJson['NAMAS'] as String,
      acno: parsedJson['ACNO'] as String,
      nacno: parsedJson['NACNO'] as String,
      sisa: 0.00,
      jumlahrp: 0.00,
      info: "",
      flag: parsedJson['FLAG'] as String,
      curr: parsedJson['CURR'] as String,
      rate: 0.00,
      noinv: "",
    );
  }
}
