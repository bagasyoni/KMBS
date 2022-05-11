import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:akunt/model/model_order_pembelian.dart';
// import 'package:akunt/model/model_order_penjualan.dart';
// import 'package:akunt/model/model_pembelian.dart';
// import 'package:akunt/model/model_penjualan.dart';

class HomeController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  static String perx = '';

  final format_created = new DateFormat("yyyy-MM", "id_ID");
  int trx_count = 0;

  int po_count = 0;
  int so_count = 0;
  int buy_count = 0;
  int sale_count = 0;

  double po_percent = 0;
  double so_percent = 0;
  double buy_percent = 0;
  double sale_percent = 0;

  //pemasukan
  double pemasukan_januari = 0;
  double pemasukan_februari = 0;
  double pemasukan_maret = 0;
  double pemasukan_april = 0;
  double pemasukan_mei = 0;
  double pemasukan_juni = 0;
  double pemasukan_juli = 0;
  double pemasukan_agustus = 0;
  double pemasukan_september = 0;
  double pemasukan_oktober = 0;
  double pemasukan_november = 0;
  double pemasukan_desember = 0;

  // pengeluaran
  double pengeluaran_januari = 0;
  double pengeluaran_februari = 0;
  double pengeluaran_maret = 0;
  double pengeluaran_april = 0;
  double pengeluaran_mei = 0;
  double pengeluaran_juni = 0;
  double pengeluaran_juli = 0;
  double pengeluaran_agustus = 0;
  double pengeluaran_september = 0;
  double pengeluaran_oktober = 0;
  double pengeluaran_november = 0;
  double pengeluaran_desember = 0;

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
    notifyListeners();
  }
}
