// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/master/finansial/model_account.dart';
import 'package:akunt/model/master/finansial/data_account.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_memo.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MemoController with ChangeNotifier {
  model_memo m_order = model_memo();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_memo_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  int index_terpilih;

  Future<void> select_data() async {
    data_memo_list = await m_order.select_memo(
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
    if (data_memo_list.length > 0) {
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
      for (int i = 0; i < data_memo_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_memo_list[i]['tanggal'];
        isi_map['b'] = data_memo_list[i]['no_bukti'];
        isi_map['c'] = data_memo_list[i]['sales'];
        isi_map['d'] = data_memo_list[i]['customer'];
        isi_map['e'] = data_memo_list[i]['keterangan'];
        isi_map['f'] = data_memo_list[i]['total_qty'];
        isi_map['g'] = data_memo_list[i]['total_so'];
        if (data_memo_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_memo_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_memo_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_memo_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_memo_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_memo_list[index_terpilih]['keterangan'];
      if (data_memo_list[index_terpilih]['status'] == 1) {
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
      List data_account = await m_order.select_memo_detail(
          data_memo_list[index_terpilih]['no_bukti'], "NO_BUKTI", "kas");
      for (int i = 0; i < data_account.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_account[i]['kd_brg'];
        isi_map['b'] = data_account[i]['na_brg'];
        isi_map['c'] = data_account[i]['satuan'];
        isi_map['d'] = data_account[i]['qty'];
        isi_map['e'] = data_account[i]['harga_so'];
        isi_map['f'] = data_account[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_memo_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_memo_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_memo_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_account = await m_order.select_memo_detail(
        data_memo_list[index_terpilih]['no_bukti'], "NO_BUKTI", "kas");
    InvoiceOrderPenjualan()
        .proses_print(data_memo_list[index_terpilih], data_account);
  }

  //add memo
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController debetController = TextEditingController();
  TextEditingController kreditController = TextEditingController();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataAccount> data_account_keranjang = List<DataAccount>();
  double sumDebet = 0;
  double sumKredit = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataAccount> accountList = List<DataAccount>();
  bool status_kasmasuk = true;

  Future<void> initData_addMemo() async {
    data_account_keranjang = new List<DataAccount>();
    no_buktiController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    ketController.clear();
    debetController.clear();
    kreditController.clear();
    sumDebet = 0;
    sumKredit = 0;
    await m_order
        .countmemo(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        no_buktiController.text =
            "MEMO${format_no_bukti.format(DateTime.now())}B-${no_urut + 1}";
      }
    });
    await model_account().data_accountcari("").then((value) {
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editMemo(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tglController.text = format_tanggal.format(chooseDate);
    ketController.text = data_edit['KET'];
    debetController.text = data_edit['DEBET'].toString();
    kreditController.text = data_edit['KREDIT'].toString();
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_order.select_memo_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "memod");
    data_account_keranjang = new List<DataAccount>();

    for (int i = 0; i < data_lama.length; i++) {
      DataAccount mAccount = DataAccount(
        noid: data_lama[i]['NO_ID'],
        acno: data_lama[i]['ACNO'],
        nacno: data_lama[i]['NACNO'],
        reff: data_lama[i]['URAIAN'],
        debet: double.parse(data_lama[i]['DEBET'].toString()),
        kredit: double.parse(data_lama[i]['KREDIT'].toString()),
      );
      data_account_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_account().data_accountcari("").then((value) {
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataAccount mAccount) {
    // m_barang.stok_booking = 1;
    data_account_keranjang.add(mAccount);
    sumDebet += mAccount.debet ?? 0.00;
    sumKredit += mAccount.kredit ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumDebet = 0;
    sumKredit = 0;
    for (int i = 0; i < data_account_keranjang.length; i++) {
      sumDebet += data_account_keranjang[i].debet;
      sumKredit += data_account_keranjang[i].kredit;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveMemo() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_order.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "memo");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['KET'] = ketController.text;
          obj['DEBET'] = sumDebet;
          obj['KREDIT'] = sumKredit;
          obj['tabeld'] = await baca_tabeld();
          await m_order.insert_memo(obj);
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

  Future<bool> editMemo() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['KET'] = ketController.text;
        obj['DEBET'] = sumDebet;
        obj['KREDIT'] = sumKredit;
        obj['tabeld'] = await baca_tabeld();
        await m_order.update_memo(obj);
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

  Future<bool> deleteMemo(String no_bukti) async {
    try {
      var delete = await m_order.delete_memo(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List accountList = [];
    for (int i = 0; i < data_account_keranjang.length; i++) {
      Map obj = new Map();
      obj['ACNO'] = data_account_keranjang[i].acno;
      obj['NACNO'] = data_account_keranjang[i].nacno;
      obj['URAIAN'] = data_account_keranjang[i].reff;
      obj['DEBET'] = data_account_keranjang[i].debet;
      obj['KREDIT'] = data_account_keranjang[i].kredit;
      accountList.add(obj);
    }
    return accountList;
  }
}
