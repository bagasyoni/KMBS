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

import '../config/export_pdf_array_10a.dart';
import '../model/model_lapkas.dart';

class LapKasController with ChangeNotifier {
  model_lapkas m_lapkas = model_lapkas();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      DateRangePickerController();
  List data_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  String filter_supplier = "";
  List<DropdownMenuItem<String>> dropdownList_supplier;
  int index_terpilih;

  Future<void> select_data() async {
    data_list = await m_lapkas.data_lap(tanggal_awal, tanggal_akhir);
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

  Future<void> proses_export_lapkas(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("No Bukti");
      header_excel.add("Tanggal");
      header_excel.add("Keterangan");
      header_excel.add("Bacno");
      header_excel.add("Bnama");
      header_excel.add("Type");
      header_excel.add("Sub Total");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['NO_BUKTI'];
        isi_map['b'] = data_list[i]['TGL'];
        isi_map['c'] = data_list[i]['KET'];
        isi_map['d'] = data_list[i]['BACNO'];
        isi_map['e'] = data_list[i]['BNAMA'];
        isi_map['f'] = data_list[i]['TYPE'];
        isi_map['g'] = data_list[i]['JUMLAH'];
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Kas Masuk Keluar";
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
