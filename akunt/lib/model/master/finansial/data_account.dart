import 'dart:convert';

import 'package:flutter/services.dart';

class DataAccount {
  int noid;
  String acno;
  String acnob;
  String nacno;
  String nacnob;
  String reff;
  double debet;
  double debet1;
  double kredit;
  double kredit1;
  double jumlah;
  double jumlah1;
  double jumlahinv;
  double um;
  double currd;
  double rated;
  String no_faktur;
  String noinv;
  double dk;

  DataAccount({
    this.noid,
    this.acno,
    this.acnob,
    this.nacno,
    this.nacnob,
    this.reff,
    this.debet,
    this.debet1,
    this.kredit,
    this.kredit1,
    this.jumlah,
    this.jumlah1,
    this.jumlahinv,
    this.um,
    this.currd,
    this.rated,
    this.no_faktur,
    this.noinv,
    this.dk,
  });

  factory DataAccount.fromJson(var parsedJson) {
    return DataAccount(
      noid: parsedJson['NO_ID'],
      acno: parsedJson['ACNO'] as String,
      acnob: "",
      nacno: parsedJson['NAMA'] as String,
      nacnob: "",
      reff: parsedJson['URAIAN'] as String ?? "",
      debet: 0.00,
      debet1: 0.00,
      kredit: 0.00,
      kredit1: 0.00,
      jumlah: 0.00,
      jumlah1: 0.00,
      jumlahinv: 0.00,
      um: 0.00,
      currd: 0.00,
      rated: 0.00,
      no_faktur: "",
      noinv: "",
      dk: 0.00,
    );
  }
}
