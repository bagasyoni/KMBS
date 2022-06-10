import 'dart:convert';

import 'package:flutter/services.dart';

class DataAccount {
  int noid;
  String acno;
  String nacno;
  String reff;
  double debet;
  double kredit;
  double jumlah;
  double jumlah1;
  double jumlahinv;
  double um;
  double currd;
  double rated;
  String no_faktur;
  String noinv;

  DataAccount({
    this.noid,
    this.acno,
    this.nacno,
    this.reff,
    this.debet,
    this.kredit,
    this.jumlah,
    this.jumlah1,
    this.jumlahinv,
    this.um,
    this.currd,
    this.rated,
    this.no_faktur,
    this.noinv,
  });

  factory DataAccount.fromJson(var parsedJson) {
    return DataAccount(
      noid: parsedJson['NO_ID'],
      acno: parsedJson['ACNO'] as String,
      nacno: parsedJson['NAMA'] as String,
      reff: parsedJson['URAIAN'] as String ?? "",
      debet: 0.00,
      kredit: 0.00,
      jumlah: 0.00,
      jumlah1: 0.00,
      jumlahinv: 0.00,
      um: 0.00,
      currd: 0.00,
      rated: 0.00,
      no_faktur: "",
      noinv: "",
    );
  }
}
