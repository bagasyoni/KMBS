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

import '../config/export_pdf_array_7a.dart';
import '../model/model_lapperincian_hut.dart';
import '../model/model_periode.dart';

class LapPerincianhutController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapperincian_hut m_lapperincian_hut = model_lapperincian_hut();
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
  String periode = '';
  static String per = '';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  double awal = 0;
  double beli = 0;
  double bayar = 0;
  double lain = 0;
  double akhir = 0;
  List<DropdownMenuItem<String>> dropdown_periode;
  List<DropdownMenuItem<int>> dropdownLimit;
  TextEditingController c_page = new TextEditingController();
  int index_terpilih;
  double pageCount = 1;
  int page_index = 0;

  Future<void> select_data() async {
    String filterpermodal = per == '' ? periode : per;
    data_list = await m_lapperincian_hut.data_lap(filterpermodal);
    awal = 0;
    beli = 0;
    bayar = 0;
    lain = 0;
    akhir = 0;
    for (int i = 0; i < data_list.length; i++) {
      awal += double.parse(data_list[i]['AWAL'].toString());
      beli += double.parse(data_list[i]['MASUK'].toString());
      bayar += double.parse(data_list[i]['KELUAR'].toString());
      lain += double.parse(data_list[i]['LAIN'].toString());
      akhir += double.parse(data_list[i]['AKHIR'].toString());
    }
    notifyListeners();
  }

  Future<void> initData() async {
    per = "";
    await filter_periode();
    index_terpilih = null;
    periode = DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
    select_data();
  }

  Future<void> filter_periode() async {
    dropdown_periode = [];
    dropdown_periode
        .add(new DropdownMenuItem(value: "", child: new Text("Pilih Periode")));
    List periodeList = await model_periode().data_periode_tampil('');
    for (int i = 0; i < periodeList.length; i++) {
      dropdown_periode.add(new DropdownMenuItem(
          value: periodeList[i]['VALUE'].toString(),
          child: new Text(periodeList[i]['PERIO'])));
    }
  }

  TextEditingController periodeController = TextEditingController();
  TextEditingController yerController = TextEditingController();

  Future<void> proses_export_lapperincianhut(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("Kode Suplier");
      header_excel.add("Nama Suplier");
      header_excel.add("Awal");
      header_excel.add("Beli");
      header_excel.add("Bayar");
      header_excel.add("Lain");
      header_excel.add("Akhir");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['KODE'];
        isi_map['b'] = data_list[i]['NAMA'];
        isi_map['c'] = data_list[i]['AWAL'];
        isi_map['d'] = data_list[i]['MASUK'];
        isi_map['e'] = data_list[i]['KELUAR'];
        isi_map['f'] = data_list[i]['LAIN'];
        isi_map['g'] = data_list[i]['AKHIR'];
        isi_map['h'] = awal;
        isi_map['i'] = beli;
        isi_map['j'] = bayar;
        isi_map['k'] = lain;
        isi_map['l'] = akhir;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Perincian Hutang";
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
