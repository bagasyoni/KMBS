import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/export_pdf_array_10a.dart';
import '../model/model_lapso.dart';

class LapSoController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_lapso m_lapbelibahan = model_lapso();
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
  static String customer_a = "";
  static String customer_b = "";
  static String barang_a = "";
  static String barang_b = "";
  double total = 0;
  double qty = 0;
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
    data_list = await m_lapbelibahan.data_lap(
        tanggal_awal,
        tanggal_akhir,
        cus1Controller.text,
        cus2Controller.text,
        brg1Controller.text,
        brg2Controller.text);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_list.length; i++) {
      total += double.parse(data_list[i]['TOTAL'].toString());
      qty += double.parse(data_list[i]['TOTAL_QTY'].toString());
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
    select_data();
  }

  TextEditingController cus1Controller = TextEditingController();
  TextEditingController cus2Controller = TextEditingController();
  TextEditingController brg1Controller = TextEditingController();
  TextEditingController brg2Controller = TextEditingController();

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

  Future<void> proses_export_lapso(int mode) async {
    if (data_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("No Bukti");
      header_excel.add("Tanggal");
      header_excel.add("Kode Cus.");
      header_excel.add("Nama Cus.");
      header_excel.add("Kode Brg.");
      header_excel.add("Nama Brg.");
      header_excel.add("Harga");
      header_excel.add("Qty");
      header_excel.add("Sub Total");
      header_excel.add("Keterangan");
      for (int i = 0; i < data_list.length; i++) {
        Map<String, dynamic> isi_map = <String, dynamic>{};
        isi_map['a'] = data_list[i]['NO_BUKTI'];
        isi_map['b'] = data_list[i]['TGL'];
        isi_map['c'] = data_list[i]['KODEC'];
        isi_map['d'] = data_list[i]['NAMAC'];
        isi_map['e'] = data_list[i]['KD_BRG'];
        isi_map['f'] = data_list[i]['NA_BRG'];
        isi_map['g'] = data_list[i]['HARGA'];
        isi_map['h'] = data_list[i]['TOTAL_QTY'];
        isi_map['i'] = data_list[i]['TOTAL'];
        isi_map['j'] = data_list[i]['KET'];
        isi_map['k'] = qty.toString();
        isi_map['l'] = total;
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Sales Order";
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
