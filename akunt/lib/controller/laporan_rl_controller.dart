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

import '../config/export_pdf_array_3.dart';
import '../model/model_lap_rl.dart';
import '../model/model_periode.dart';

class LapRlController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lap_rl m_lap_rl = model_lap_rl();
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
  String filter_supplier = "";
  double jum = 0;
  double ak = 0;
  List<DropdownMenuItem<String>> dropdown_periode;
  List<DropdownMenuItem<int>> dropdownLimit;
  TextEditingController c_page = new TextEditingController();
  int index_terpilih;
  double pageCount = 1;
  int page_index = 0;

  Future<void> select_data() async {
    String filterpermodal = per == '' ? periode : per;
    data_list = await m_lap_rl.data_lap(filterpermodal);
    jum = 0;
    ak = 0;
    for (int i = 0; i < data_list.length; i++) {
      jum += double.parse(data_list[i]['JUM'].toString());
      ak += double.parse(data_list[i]['AK'].toString());
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

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

  Future<void> proses_export_lapnera(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("Nama");
      header_excel.add("Jumlah");
      header_excel.add("Akhir");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['NAMA'];
        isi_map['b'] = jum;
        isi_map['c'] = ak;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Laba Rugi";
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
