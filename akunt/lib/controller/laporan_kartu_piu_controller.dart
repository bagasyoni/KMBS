// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_adjacent_string_concatenation, prefer_const_constructors, unused_import, prefer_is_empty

import 'dart:math';

import 'package:akunt/model/data_bhn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_pembelian.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/export_pdf_array_9a.dart';
import '../model/model_lapkartu_piu.dart';
import '../model/model_periode.dart';

class LapKartupiuController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapkartu_piu m_lapkartu_piu = model_lapkartu_piu();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      DateRangePickerController();
  List data_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  static String per = '';
  String periode = '';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  String filter_supplier = "";
  static String kode_1 = "";
  static String kode_2 = "";
  double awal = 0;
  double masuk = 0;
  double keluar = 0;
  double saldo = 0;
  List<DropdownMenuItem<String>> dropdown_customer;
  List<DropdownMenuItem<int>> dropdownLimit;
  TextEditingController c_page = new TextEditingController();
  int index_terpilih;
  double pageCount = 1;
  int page_index = 0;

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    String filterpermodal = per == '' ? perx : per;
    data_list = await m_lapkartu_piu.data_lap(
        filterpermodal, kode1Controller.text, kode2Controller.text);
    for (int i = 0; i < data_list.length; i++) {
      awal += double.parse(data_list[i]['AWAL'].toString());
      masuk += double.parse(data_list[i]['MASUK'].toString());
      keluar += double.parse(data_list[i]['KELUAR'].toString());
      saldo += double.parse(data_list[i]['SALDO'].toString());
    }
    notifyListeners();
  }

  Future<void> initData() async {
    per = "";
    index_terpilih = null;
    periode = DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
    baca_periodePrefs();
    select_data();
  }

  TextEditingController periodeController = TextEditingController();
  TextEditingController kode1Controller = TextEditingController();
  TextEditingController kode2Controller = TextEditingController();

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

  Future<void> proses_export_lapkartupiu(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("No Bukti");
      header_excel.add("Tanggal");
      header_excel.add("Kode Customer");
      header_excel.add("Nama Customer");
      header_excel.add("Uraian");
      header_excel.add("Awal");
      header_excel.add("Masuk");
      header_excel.add("Keluar");
      header_excel.add("Saldo");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['NO_BUKTI'];
        isi_map['b'] = data_list[i]['TGL'];
        isi_map['c'] = data_list[i]['KODE'];
        isi_map['d'] = data_list[i]['NAMA'];
        isi_map['e'] = data_list[i]['URAIAN'];
        isi_map['f'] = data_list[i]['AWAL'];
        isi_map['g'] = data_list[i]['MASUK'];
        isi_map['h'] = data_list[i]['KELUAR'];
        isi_map['i'] = data_list[i]['SALDO'];
        isi_map['t_aw'] = awal;
        isi_map['t_ma'] = masuk;
        isi_map['t_ke'] = keluar;
        isi_map['t_sd'] = saldo;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Kartu Piutang";
      String header_title = "";
      if (mode == 0) {
        config().createExcel3(header_excel, isi_excel, header_title, judul);
      } else {
        ExportPDF(header_excel, isi_excel, judul);
      }
    } else {
      Toast("Tidak ada data untuk di export", "", false);
    }
  }
}
