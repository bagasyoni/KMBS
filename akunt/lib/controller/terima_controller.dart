// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/model_terimabhn.dart';
import 'package:akunt/model/master/operasional/model_brg.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerimabhnController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_terimabhn m_terima = model_terimabhn();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_terima_list = [];
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
    data_terima_list = await m_terima.select_terimabhn(
        searchController.text, tanggal_awal, tanggal_akhir);
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
    select_data();
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

  void proses_export() {
    if (data_terima_list.length > 0) {
      BotToast.showLoading();
      List header_excel = new List();
      List isi_excel = new List();
      header_excel.add("Tanggal");
      header_excel.add("No bukti");
      header_excel.add("Sales");
      header_excel.add("Customer");
      header_excel.add("keterangan");
      header_excel.add("Qty");
      header_excel.add("Total");
      header_excel.add("Status");
      for (int i = 0; i < data_terima_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_terima_list[i]['tanggal'];
        isi_map['b'] = data_terima_list[i]['no_bukti'];
        isi_map['c'] = data_terima_list[i]['sales'];
        isi_map['d'] = data_terima_list[i]['customer'];
        isi_map['e'] = data_terima_list[i]['keterangan'];
        isi_map['f'] = data_terima_list[i]['total_qty'];
        isi_map['g'] = data_terima_list[i]['total_so'];
        if (data_terima_list[i]['status'] == 1) {
          isi_map['h'] = "Diterima";
        } else {
          isi_map['h'] = "Belum Diterima";
        }
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Order Penjualan (${range.replaceAll("/", "")})";
      config().createExcel(header_excel, isi_excel, judul);
    } else {
      Toast("Tidak ada data untuk di export", "", false);
    }
  }

  Future<void> proses_export_detail() async {
    if (index_terpilih != null) {
      BotToast.showLoading();
      List header_excel = new List();
      List header_detail_excel = new List();
      List isi_excel = new List();
      List isi_detail_excel = new List();
      List footer_excel = new List();
      header_excel.add("Tanggal");
      header_excel.add("No bukti");
      header_excel.add("Sales");
      header_excel.add("Customer");
      header_excel.add("keterangan");
      header_excel.add("Status");
      Map<String, dynamic> map_transaksi = new Map<String, dynamic>();
      map_transaksi['a'] = data_terima_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_terima_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_terima_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_terima_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_terima_list[index_terpilih]['keterangan'];
      if (data_terima_list[index_terpilih]['status'] == 1) {
        map_transaksi['f'] = "Diterima";
      } else {
        map_transaksi['f'] = "Belum Diterima";
      }
      isi_excel.add(map_transaksi);

      header_detail_excel.add("Kode Barang");
      header_detail_excel.add("Nama Barang");
      header_detail_excel.add("Satuan");
      header_detail_excel.add("Qty");
      header_detail_excel.add("Harga");
      header_detail_excel.add("SubTotal");
      List data_bhn = await m_terima.select_terimabhn_detail(
          data_terima_list[index_terpilih]['no_bukti'], "NO_BUKTI", "terima");
      for (int i = 0; i < data_bhn.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_bhn[i]['kd_brg'];
        isi_map['b'] = data_bhn[i]['na_brg'];
        isi_map['c'] = data_bhn[i]['satuan'];
        isi_map['d'] = data_bhn[i]['qty'];
        isi_map['e'] = data_bhn[i]['harga_so'];
        isi_map['f'] = data_bhn[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_terima_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_terima_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_terima_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_bhn = await m_terima.select_terimabhn_detail(
        data_terima_list[index_terpilih]['no_bukti'], "NO_BUKTI", "terima");
    InvoiceOrderPenjualan()
        .proses_print(data_terima_list[index_terpilih], data_bhn);
  }

  //add stocka
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController total_qtyController = TextEditingController();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBrg> data_brg_keranjang = List<DataBrg>();
  double sumQty = 0;
  int no_urut = 0;
  List<DataBrg> brgList = List<DataBrg>();
  bool status_kasmasuk = true;

  Future<void> initData_addTerimabhn() async {
    await baca_periodePrefs();
    data_brg_keranjang = new List<DataBrg>();
    no_buktiController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    notesController.clear();
    total_qtyController.clear();
    sumQty = 0;
    await m_terima
        .countterimabhn(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        no_buktiController.text =
            "TR${format_no_bukti.format(DateTime.now())}BH-${no_urut + 1}";
      }
    });
    await model_brg().cari_barang("").then((value) {
      if (value != null) {
        brgList.clear();
        for (int i = 0; i < value.length; i++) {
          brgList.add(DataBrg.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editTerimabhn(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tglController.text = format_tanggal.format(chooseDate);
    notesController.text = data_edit['NOTES'];
    total_qtyController.text = data_edit['TOTAL_QTY'].toString();
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_terima.select_terimabhn_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "terimad");
    data_brg_keranjang = new List<DataBrg>();

    for (int i = 0; i < data_lama.length; i++) {
      DataBrg mAccount = DataBrg(
        noid: data_lama[i]['NO_ID'],
        kd_brg: data_lama[i]['KD_BRG'],
        na_brg: data_lama[i]['NA_BRG'],
        ket: data_lama[i]['KET'],
        qty: double.parse(data_lama[i]['QTY'].toString()),
        satuan: data_lama[i]['SATUAN'],
      );
      data_brg_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_brg().cari_barang("").then((value) {
      if (value != null) {
        brgList.clear();
        for (int i = 0; i < value.length; i++) {
          brgList.add(DataBrg.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataBrg mAccount) {
    // m_barang.stok_booking = 1;
    data_brg_keranjang.add(mAccount);
    sumQty += mAccount.qty ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    for (int i = 0; i < data_brg_keranjang.length; i++) {
      sumQty += data_brg_keranjang[i].qty;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveTerimabhn() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_terima.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "terima");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['NOTES'] = notesController.text;
          obj['TOTAL_QTY'] = sumQty;
          obj['PER'] = perx;
          obj['tabeld'] = await baca_tabeld();
          await m_terima.insert_terimabhn(obj);
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast("Peringatan !", "Belum ada detil Transaksi yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> editTerimabhn() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['NOTES'] = notesController.text;
        obj['TOTAL_QTY'] = sumQty;
        obj['PER'] = perx;
        obj['tabeld'] = await baca_tabeld();
        await m_terima.update_terimabhn(obj);
        BotToast.closeAllLoading();
        Toast("Success !", "Berhasil mengedit data", true);
        return true;
      } else {
        Toast("Peringatan !", "Belum ada detil Transaksi yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> deleteTerimabhn(String no_bukti) async {
    try {
      var delete = await m_terima.delete_terimabhn(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List brgList = [];
    for (int i = 0; i < data_brg_keranjang.length; i++) {
      Map obj = new Map();
      obj['KD_BRG'] = data_brg_keranjang[i].kd_brg;
      obj['NA_BRG'] = data_brg_keranjang[i].na_brg;
      obj['SATUAN'] = data_brg_keranjang[i].satuan;
      obj['KET'] = data_brg_keranjang[i].ket;
      obj['QTY'] = data_brg_keranjang[i].qty;
      brgList.add(obj);
    }
    return brgList;
  }
}
