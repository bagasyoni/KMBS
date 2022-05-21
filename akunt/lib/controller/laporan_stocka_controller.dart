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

import '../config/export_pdf_array_7.dart';
import '../model/model_lapstocka.dart';

class LapStockaController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapstocka m_lapstocka = model_lapstocka();
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
  double total = 0;
  double qty = 0;
  List<DropdownMenuItem<String>> dropdownList_supplier;
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
    data_list = await m_lapstocka.data_lap(perx, tanggal_awal, tanggal_akhir);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_list.length; i++) {
      qty += double.parse(data_list[i]['total_qty'].toString());
    }
    notifyListeners();
  }

  void initData() {
    index_terpilih = null;
    tanggal_awal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggal_akhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString();
    baca_periodePrefs();
    filterSupplier("");
    select_data();
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

  Future<void> print() async {
    await m_lapstocka.print_data(perx, tanggal_awal, tanggal_akhir);
    notifyListeners();
  }
}
