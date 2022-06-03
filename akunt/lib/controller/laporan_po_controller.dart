// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_adjacent_string_concatenation, prefer_const_constructors, unused_import, prefer_is_empty

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_pembelian.dart';
import 'package:akunt/model/master/operasional/model_brg.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../config/export_pdf_array_10a.dart';
import '../model/master/operasional/data_brg.dart';
import '../model/model_order_pembelian.dart';
import '../model/master/operasional/model_supplier.dart';

class LapPoController with ChangeNotifier {
  model_order_pembelian m_data = model_order_pembelian();
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
    data_list = await m_data.data_lap(tanggal_awal, tanggal_akhir);
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

  //add order pembelian
  TextEditingController no_bukti = TextEditingController();
  TextEditingController tgl = TextEditingController();
  TextEditingController kd_brg = TextEditingController();
  TextEditingController na_brg = TextEditingController();
  TextEditingController ket = TextEditingController();
  TextEditingController qty = TextEditingController();
  final format_tanggal = DateFormat("EEEE, d MMMM yyyy", "id_ID");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBrg> data_barang_keranjang = List<DataBrg>();
  double sumQty = 0;
  double sumTotal = 0;
  int no_urut = 0;
  List<DataBrg> barangList = List<DataBrg>();
  bool status_po = true;
  double total_used = 0;

  Future<void> initData_add() async {
    no_bukti.clear();
    tgl.text = format_tanggal.format(chooseDate);
    kd_brg.clear();
    na_brg.clear();
    ket.clear();
    qty.clear();
    no_bukti.text = "ST${format_no_bukti.format(DateTime.now())}-";
  }

  Future<void> proses_export_perSupplier(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("Tanggal");
      header_excel.add("No bukti");
      header_excel.add("Kode Barang");
      header_excel.add("Nama Barang");
      header_excel.add("Qty");
      header_excel.add("Harga PO");
      header_excel.add("SubTotal");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['TGL'];
        isi_map['b'] = data_list[i]['NO_PO'];
        isi_map['c'] = data_list[i]['KD_BRG'];
        isi_map['d'] = data_list[i]['NA_BRG'];

        isi_map['e'] = data_list[i]['KG'];
        isi_map['f'] = data_list[i]['HARGA'];
        isi_map['g'] = data_list[i]['TOTAL'];
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Order Pembelian";
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
