import 'dart:convert';

import 'package:flutter/services.dart';

class DataCurr {
  int noid;
  String kode;
  String nama;
  String ket;
  double rate;
  double rate_byr;

  DataCurr(
      {this.noid, this.kode, this.nama, this.ket, this.rate, this.rate_byr});

  factory DataCurr.fromJson(var parsedJson) {
    return DataCurr(
      noid: parsedJson['NO_ID'],
      kode: parsedJson['KODE'] as String,
      nama: parsedJson['NAMA'] as String,
      ket: parsedJson['KET'] as String,
      rate: double.parse(parsedJson['Rate']),
      rate_byr: double.parse(parsedJson['Rate_BYR']),
    );
  }
}
