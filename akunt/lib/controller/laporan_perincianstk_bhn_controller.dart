import 'dart:math';

import 'package:akunt/model/master/operasional/data_bhn.dart';
import 'package:akunt/model/master/operasional/model_bahan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/export_pdf_array_7a.dart';
import '../model/model_lapperincianstk_bhn.dart';
import '../model/model_periode.dart';

class LapPerincianstkbhnController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapperincianstk_bhn m_lapperincianstk_bhn = model_lapperincianstk_bhn();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      DateRangePickerController();
  List data_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  String periode = '';
  static String per = '';
  String perx = '';
  String rangeCount = '';
  double awal = 0;
  double masuk = 0;
  double keluar = 0;
  double lain = 0;
  double akhir = 0;
  List<DropdownMenuItem<String>> dropdown_periode;
  List<DropdownMenuItem<int>> dropdownLimit;
  TextEditingController c_page = new TextEditingController();
  int index_terpilih;
  double pageCount = 1;
  int page_index = 0;
  int index = 0;

  Future<void> select_data() async {
    String filterpermodal = per == '' ? periode : per;
    data_list = await m_lapperincianstk_bhn.data_lap(filterpermodal);
    awal = 0;
    masuk = 0;
    keluar = 0;
    lain = 0;
    akhir = 0;
    for (int i = 0; i < data_list.length; i++) {
      awal += double.parse(data_list[i]['AWAL'].toString());
      masuk += double.parse(data_list[i]['MASUK'].toString());
      keluar += double.parse(data_list[i]['KELUAR'].toString());
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

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

  Future<void> proses_export_lapperincianstkbhn(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("Kode Bahan");
      header_excel.add("Nama Bahan");
      header_excel.add("Awal");
      header_excel.add("Masuk");
      header_excel.add("Keluar");
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
        isi_map['i'] = masuk;
        isi_map['j'] = keluar;
        isi_map['k'] = lain;
        isi_map['l'] = akhir;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Perincian Stok Bahan";
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
