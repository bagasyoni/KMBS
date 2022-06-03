// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_adjacent_string_concatenation, prefer_const_constructors, unused_import, prefer_is_empty

import 'dart:math';

import 'package:akunt/model/master/operasional/data_bhn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_pembelian.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/export_pdf_array_9a.dart';
import '../model/model_lapbuku_besar.dart';
import '../model/model_periode.dart';
import '../model/master/finansial/model_account.dart';

class LapBukubesarController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapbuku_besar m_lapbuku_besar = model_lapbuku_besar();
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
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  String filter_supplier = "";
  String periode = "";
  String account = "";
  double awal = 0;
  double debet = 0;
  double kredit = 0;
  double akhir = 0;
  List<DropdownMenuItem<String>> dropdown_periode;
  List<DropdownMenuItem<String>> dropdown_account;
  List<DropdownMenuItem<int>> dropdownLimit;
  TextEditingController c_page = new TextEditingController();
  int index_terpilih;
  double pageCount = 1;
  int page_index = 0;

  Future<void> select_data() async {
    data_list = await m_lapbuku_besar.data_lap(tanggal_awal, tanggal_akhir);
    awal = 0;
    debet = 0;
    kredit = 0;
    akhir = 0;
    for (int i = 0; i < data_list.length; i++) {
      awal += double.parse(data_list[i]['AWAL'].toString());
      debet += double.parse(data_list[i]['DEBET'].toString());
      kredit += double.parse(data_list[i]['KREDIT'].toString());
      akhir += double.parse(data_list[i]['AKHIR'].toString());
    }
    notifyListeners();
  }

  Future<void> initData() async {
    periode = "";
    await filter_periode();
    account = "";
    await filter_account();
    index_terpilih = null;
    tanggal_awal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggal_akhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString();
    filterSupplier("");
    select_data();
  }

  Future<void> filter_periode() async {
    dropdown_periode = [];
    dropdown_periode
        .add(new DropdownMenuItem(value: "", child: new Text("Pilih Periode")));
    List periodeList = await model_periode().data_periode_tampil('');
    for (int i = 0; i < periodeList.length; i++) {
      dropdown_periode.add(new DropdownMenuItem(
          value: periodeList[i]['PERIO'].toString(),
          child: new Text(periodeList[i]['PERIO'])));
    }
    // dropdown_periode.add(new DropdownMenuItem(
    //     value: "Tambah Baru ?", child: new Text("Tambah Baru ?")));
    // status_supplier = dropdown_periode[0].value;
  }

  Future<void> filter_account() async {
    dropdown_account = [];
    dropdown_account
        .add(new DropdownMenuItem(value: "", child: new Text("Pilih Account")));
    List accountList = await model_account().data_accountcari('');
    for (int i = 0; i < accountList.length; i++) {
      dropdown_account.add(new DropdownMenuItem(
          value: accountList[i]['ACNO'].toString(),
          child: new Text(accountList[i]['ACNO'])));
    }
    // dropdown_account.add(new DropdownMenuItem(
    //     value: "Tambah Baru ?", child: new Text("Tambah Baru ?")));
    // status_supplier = dropdown_account[0].value;
  }

  void filterSupplier(kodes) async {
    filter_supplier = kodes;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value != null) {
      if (args.value is PickerDateRange) {
        if (args.value.startDate != null) {
          range = DateFormat('dd/MM/yyyy', "id_ID")
                  .format(args.value.startDate)
                  .toString() +
              ' - ' +
              DateFormat('dd/MM/yyyy', "id_ID")
                  .format(args.value.endDate ?? args.value.startDate)
                  .toString();
        }
        if (args.value.startDate != null && args.value.endDate != null) {
          tanggal_awal = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.startDate)
              .toString();
          tanggal_akhir = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.endDate)
              .toString();
          isEnable_button = true;
        } else {
          isEnable_button = false;
        }
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
        isEnable_button = false;
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
        isEnable_button = false;
      } else {
        rangeCount = args.value.length.toString();
        isEnable_button = false;
      }
      notifyListeners();
    }
  }

  Future<void> proses_export_lapbukubesar(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("No Bukti");
      header_excel.add("Tanggal");
      header_excel.add("Kode");
      header_excel.add("Nama");
      header_excel.add("Uraian");
      header_excel.add("Awal");
      header_excel.add("Masuk");
      header_excel.add("Keluar");
      header_excel.add("Akhir");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['NO_BUKTI'];
        isi_map['b'] = data_list[i]['TGL'];
        isi_map['c'] = data_list[i]['ACNO'];
        isi_map['d'] = data_list[i]['NAMA'];
        isi_map['e'] = data_list[i]['URAIAN'];
        isi_map['f'] = data_list[i]['AWAL'];
        isi_map['g'] = data_list[i]['DEBET'];
        isi_map['h'] = data_list[i]['KREDIT'];
        isi_map['i'] = data_list[i]['AKHIR'];
        isi_map['t_aw'] = awal;
        isi_map['t_ma'] = debet;
        isi_map['t_ke'] = kredit;
        isi_map['t_sd'] = akhir;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Buku Besar";
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
