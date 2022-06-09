// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/model_pod.dart';
import 'package:akunt/model/transaksi/operasional/data_pod.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_belinonbahan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BelinonbahanController with ChangeNotifier {
  model_belinonbahan m_belinonbahan = model_belinonbahan();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_belinonbahan_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  int index_terpilih;

  void selectData(String cari) async {
    data_belinonbahan_list = await model_belinonbahan().cari_belinonbahan(cari);
    notifyListeners();
  }

  Future<void> select_data() async {
    data_belinonbahan_list = await m_belinonbahan.select_beli_nonbahan(
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
    if (data_belinonbahan_list.length > 0) {
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
      for (int i = 0; i < data_belinonbahan_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_belinonbahan_list[i]['tanggal'];
        isi_map['b'] = data_belinonbahan_list[i]['no_bukti'];
        isi_map['c'] = data_belinonbahan_list[i]['sales'];
        isi_map['d'] = data_belinonbahan_list[i]['customer'];
        isi_map['e'] = data_belinonbahan_list[i]['keterangan'];
        isi_map['f'] = data_belinonbahan_list[i]['total_qty'];
        isi_map['g'] = data_belinonbahan_list[i]['total_so'];
        if (data_belinonbahan_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_belinonbahan_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_belinonbahan_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_belinonbahan_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_belinonbahan_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_belinonbahan_list[index_terpilih]['keterangan'];
      if (data_belinonbahan_list[index_terpilih]['status'] == 1) {
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
      List data_nonbahan = await m_belinonbahan.select_beli_nonbahan_detail(
          data_belinonbahan_list[index_terpilih]['no_bukti'],
          "NO_BUKTI",
          "beli");
      for (int i = 0; i < data_nonbahan.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_nonbahan[i]['kd_brg'];
        isi_map['b'] = data_nonbahan[i]['na_brg'];
        isi_map['c'] = data_nonbahan[i]['satuan'];
        isi_map['d'] = data_nonbahan[i]['qty'];
        isi_map['e'] = data_nonbahan[i]['harga_so'];
        isi_map['f'] = data_nonbahan[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_belinonbahan_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_belinonbahan_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_belinonbahan_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_nonbahan = await m_belinonbahan.select_beli_nonbahan_detail(
        data_belinonbahan_list[index_terpilih]['no_bukti'], "NO_BUKTI", "beli");
    InvoiceOrderPenjualan()
        .proses_print(data_belinonbahan_list[index_terpilih], data_nonbahan);
  }

  //add order pembelian
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController drController = TextEditingController();
  TextEditingController nopoController = TextEditingController();
  TextEditingController tglpoController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController jtempoController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController kursController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tglfktrController = TextEditingController();
  TextEditingController nofktrController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController ppnController = TextEditingController();
  TextEditingController nettController = TextEditingController();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataPod> data_pod_keranjang = List<DataPod>();
  double sumQty = 0;
  double sumTotal = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataPod> podList = List<DataPod>();
  bool status_kasmasuk = true;

  Future<void> initData_addBelinonbahan() async {
    data_pod_keranjang = new List<DataPod>();
    nobuktiController.clear();
    drController.clear();
    nopoController.clear();
    tglpoController.clear();
    tglController.clear();
    jtempoController.clear();
    kodesController.clear();
    namasController.clear();
    kursController.clear();
    kotaController.clear();
    alamatController.clear();
    tglfktrController.clear();
    nofktrController.clear();
    notesController.clear();
    ppnController.clear();
    nettController.clear();
    tglpoController.text = format_tanggal.format(chooseDate);
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_tanggal.format(chooseDate);
    tglfktrController.text = format_tanggal.format(chooseDate);
    sumQty = 0;
    sumTotal = 0;
    await m_belinonbahan
        .countBukti(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "BL${format_no_bukti.format(DateTime.now())}NB-${no_urut + 1}";
      }
    });
    await model_pod().cari_pod_nonbahan("").then((value) {
      if (value != null) {
        podList.clear();
        for (int i = 0; i < value.length; i++) {
          podList.add(DataPod.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editBelinonbahan(var data_edit) async {
    nobuktiController.text = data_edit['NO_BUKTI'];
    drController.text = data_edit['DR'];
    nopoController.text = data_edit['NO_PO'];
    tglpoController.text = data_edit['TGL_PO'];
    tglController.text = data_edit['TGL'];
    jtempoController.text = data_edit['JTEMPO'];
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    kursController.text = data_edit['KURS'];
    kotaController.text = data_edit['KOTA'];
    alamatController.text = data_edit['ALAMAT'];
    tglfktrController.text = data_edit['TGL_FKTR'];
    nofktrController.text = data_edit['NO_FKTR'];
    notesController.text = data_edit['NOTES'];
    ppnController.text = data_edit['PPN'].toString();
    nettController.text = data_edit['NETT'].toString();
    chooseDate = DateTime.parse(data_edit['TGL']);
    tglpoController.text = format_tanggal.format(chooseDate);
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_tanggal.format(chooseDate);
    tglfktrController.text = format_tanggal.format(chooseDate);
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_belinonbahan.select_beli_nonbahan_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "belid");
    data_pod_keranjang = new List<DataPod>();

    for (int i = 0; i < data_lama.length; i++) {
      DataPod mAccount = DataPod(
        noid: data_lama[i]['NO_ID'],
        kdbhn: data_lama[i]['KD_BHN'],
        nabhn: data_lama[i]['NA_BHN'],
        dr: data_lama[i]['DR'],
        satuanpp: data_lama[i]['SATUANPP'],
        qtypp: double.parse(data_lama[i]['QTYPP'].toString()),
        satuan: data_lama[i]['SATUAN'].toString(),
        qty: double.parse(data_lama[i]['QTY'].toString()),
        harga: double.parse(data_lama[i]['HARGA'].toString()),
        bulat: double.parse(data_lama[i]['BULAT'].toString()),
        total: double.parse(data_lama[i]['TOTAL'].toString()),
        disk: double.parse(data_lama[i]['DISK'].toString()),
        val: double.parse(data_lama[i]['VAL'].toString()),
      );
      data_pod_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_pod().cari_pod_nonbahan("").then((value) {
      if (value != null) {
        podList.clear();
        for (int i = 0; i < value.length; i++) {
          podList.add(DataPod.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataPod mAccount) {
    // m_barang.stok_booking = 1;
    data_pod_keranjang.add(mAccount);
    sumQty += 1;
    sumTotal += mAccount.total;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_pod_keranjang.length; i++) {
      sumTotal += data_pod_keranjang[i].harga * data_pod_keranjang[i].qty;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveBelinonbahan() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_pod_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_belinonbahan.get_no_bukti(
            nobuktiController.text, "NO_BUKTI", "beli");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${nobuktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['nobukti'] = nobuktiController.text;
          obj['dr'] = drController.text;
          obj['nopo'] = nopoController.text;
          obj['tglpo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['tgl'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['jtempo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['kodes'] = kodesController.text;
          obj['namas'] = namasController.text;
          obj['kurs'] = kursController.text;
          obj['kota'] = kotaController.text;
          obj['alamat'] = alamatController.text;
          obj['tglfktr'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['nofktr'] = nofktrController.text;
          obj['notes'] = notesController.text;
          obj['ppn'] = ppnController.text;
          obj['nett'] = sumTotal;
          obj['tabeld'] = await baca_tabeld();
          await m_belinonbahan.insert_beli_nonbahan(obj);
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

  Future<bool> editBelinonbahan() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_pod_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['nobukti'] = nobuktiController.text;
        obj['dr'] = drController.text;
        obj['nopo'] = nopoController.text;
        obj['tglpo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['tgl'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['jtempo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['kodes'] = kodesController.text;
        obj['namas'] = namasController.text;
        obj['kurs'] = kursController.text;
        obj['kota'] = kotaController.text;
        obj['alamat'] = alamatController.text;
        obj['tglfktr'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['nofktr'] = nofktrController.text;
        obj['notes'] = notesController.text;
        obj['ppn'] = ppnController.text;
        obj['nett'] = sumTotal;
        obj['tabeld'] = await baca_tabeld();
        await m_belinonbahan.update_beli_nonbahan(obj);
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

  Future<bool> deleteBelinonbahan(String no_bukti) async {
    try {
      var delete = await m_belinonbahan.delete_beli_nonbahan(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List podList = [];
    for (int i = 0; i < data_pod_keranjang.length; i++) {
      double qty = data_pod_keranjang[i].qty;
      double harga = data_pod_keranjang[i].harga;
      double subTotal = harga * qty;
      Map obj = new Map();
      obj['kdbhn'] = data_pod_keranjang[i].kdbhn;
      obj['nabhn'] = data_pod_keranjang[i].nabhn;
      obj['dr'] = data_pod_keranjang[i].dr;
      obj['satuanpp'] = data_pod_keranjang[i].satuanpp;
      obj['qtypp'] = data_pod_keranjang[i].qtypp;
      obj['satuan'] = data_pod_keranjang[i].satuan;
      obj['qty'] = qty;
      obj['harga'] = harga;
      obj['bulat'] = data_pod_keranjang[i].bulat;
      obj['total'] = subTotal;
      obj['disk'] = data_pod_keranjang[i].disk;
      obj['val'] = data_pod_keranjang[i].val;
      podList.add(obj);
    }
    return podList;
  }
}
