// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/master/operasional/model_brg.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_dragonpo.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DragonpoController with ChangeNotifier {
  model_dragonpo m_order = model_dragonpo();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_order_dragonpo_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  int index_terpilih;

  Future<void> select_data() async {
    data_order_dragonpo_list = await m_order.select_dragonpo(
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
    if (data_order_dragonpo_list.length > 0) {
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
      for (int i = 0; i < data_order_dragonpo_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_order_dragonpo_list[i]['tanggal'];
        isi_map['b'] = data_order_dragonpo_list[i]['no_bukti'];
        isi_map['c'] = data_order_dragonpo_list[i]['sales'];
        isi_map['d'] = data_order_dragonpo_list[i]['customer'];
        isi_map['e'] = data_order_dragonpo_list[i]['keterangan'];
        isi_map['f'] = data_order_dragonpo_list[i]['total_qty'];
        isi_map['g'] = data_order_dragonpo_list[i]['total_so'];
        if (data_order_dragonpo_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_order_dragonpo_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_order_dragonpo_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_order_dragonpo_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_order_dragonpo_list[index_terpilih]['customer'];
      map_transaksi['e'] =
          data_order_dragonpo_list[index_terpilih]['keterangan'];
      if (data_order_dragonpo_list[index_terpilih]['status'] == 1) {
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
      List data_account = await m_order.select_po_detail(
          data_order_dragonpo_list[index_terpilih]['no_bukti'],
          "NO_BUKTI",
          "kas");
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
      footer_excel.add(data_order_dragonpo_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_order_dragonpo_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_order_dragonpo_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_account = await m_order.select_po_detail(
        data_order_dragonpo_list[index_terpilih]['no_bukti'], "NO_BUKTI", "po");
    InvoiceOrderPenjualan()
        .proses_print(data_order_dragonpo_list[index_terpilih], data_account);
  }

  //add order pembelian
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController dragonController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController jtempoController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController matauangController = TextEditingController();
  TextEditingController kursController = TextEditingController();
  TextEditingController produkController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController subdivController = TextEditingController();
  TextEditingController anController = TextEditingController();
  TextEditingController notabayarController = TextEditingController();
  TextEditingController notakirimController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController pajakController = TextEditingController();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBrg> data_brg_keranjang = List<DataBrg>();
  double sumQty = 0;
  double sumTotal = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataBrg> brgList = List<DataBrg>();
  bool status_kasmasuk = true;

  Future<void> initData_addPo() async {
    data_brg_keranjang = new List<DataBrg>();
    nobuktiController.clear();
    dragonController.clear();
    kodesController.clear();
    namasController.clear();
    tanggalController.clear();
    jtempoController.clear();
    kotaController.clear();
    alamatController.clear();
    matauangController.clear();
    kursController.clear();
    produkController.clear();
    jenisController.clear();
    subdivController.clear();
    anController.clear();
    notabayarController.clear();
    notakirimController.clear();
    notesController.clear();
    pajakController.clear();
    tanggalController.text = format_tanggal.format(chooseDate);
    sumQty = 0;
    sumTotal = 0;
    await m_order
        .countKasMasuk(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "PO${format_no_bukti.format(DateTime.now())}B-${no_urut + 1}";
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
  Future<void> initData_editPo(var data_edit) async {
    nobuktiController.text = data_edit['NO_BUKTI'];
    dragonController.text = data_edit['DR'];
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    tanggalController.text = data_edit['TGL'];
    jtempoController.text = data_edit['JTEMPO'];
    kotaController.text = data_edit['KOTA'];
    alamatController.text = data_edit['ALAMAT'];
    matauangController.text = data_edit['KURS'];
    kursController.text = data_edit['RATE'];
    produkController.text = data_edit['PROD'];
    jenisController.text = data_edit['JENIS'];
    subdivController.text = data_edit['SUBDIV'];
    notabayarController.text = data_edit['NOTESBL'];
    notakirimController.text = data_edit['NOTESKRM'];
    notesController.text = data_edit['NOTES'];
    pajakController.text = data_edit['PKP'].toString();
    chooseDate = DateTime.parse(data_edit['TGL']);
    tanggalController.text = format_tanggal.format(chooseDate);
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_order.select_po_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "pod");
    data_brg_keranjang = new List<DataBrg>();

    for (int i = 0; i < data_lama.length; i++) {
      DataBrg mAccount = DataBrg(
        noid: data_lama[i]['NO_ID'],
        kd_brg: data_lama[i]['KD_BRG'],
        na_brg: data_lama[i]['NA_BRG'],
        satuan: '-',
        qty: 0.00,
        harga: 0.00,
        total: double.parse(data_lama[i]['TOTAL'].toString()) ?? 0.00,
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
    sumQty += 1;
    sumTotal += mAccount.total ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_brg_keranjang.length; i++) {
      sumTotal +=
          data_brg_keranjang[i].harga ?? 0 * data_brg_keranjang[i].qty ?? 0;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> savePo() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_order.get_no_bukti(
            nobuktiController.text, "NO_BUKTI", "po");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${nobuktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['no_bukti'] = nobuktiController.text;
          obj['dragon'] = dragonController.text;
          obj['kodes'] = kodesController.text;
          obj['namas'] = namasController.text;
          obj['tanggal'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['jtempo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['kota'] = kotaController.text;
          obj['alamat'] = alamatController.text;
          obj['matauang'] = matauangController.text;
          obj['kurs'] = kursController.text;
          obj['produk'] = produkController.text;
          obj['jenis'] = jenisController.text;
          obj['subdiv'] = subdivController.text;
          obj['an'] = anController.text;
          obj['notabayar'] = notabayarController.text;
          obj['notakirim'] = notakirimController.text;
          obj['notes'] = notesController.text;
          obj['pajak'] = pajakController.text;
          obj['total'] = sumTotal;
          obj['tabeld'] = await baca_tabeld();
          await m_order.insert_po(obj);
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

  Future<bool> editPo() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['no_bukti'] = nobuktiController.text;
        obj['dragon'] = dragonController.text;
        obj['kodes'] = kodesController.text;
        obj['namas'] = namasController.text;
        obj['tanggal'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['jtempo'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['kota'] = kotaController.text;
        obj['alamat'] = alamatController.text;
        obj['matauang'] = matauangController.text;
        obj['kurs'] = kursController.text;
        obj['produk'] = produkController.text;
        obj['jenis'] = jenisController.text;
        obj['subdiv'] = subdivController.text;
        obj['an'] = anController.text;
        obj['notabayar'] = notabayarController.text;
        obj['notakirim'] = notakirimController.text;
        obj['notes'] = notesController.text;
        obj['pajak'] = pajakController.text;
        obj['total'] = sumTotal;
        obj['tabeld'] = await baca_tabeld();
        await m_order.update_po(obj);
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

  Future<bool> deletePo(String no_bukti) async {
    try {
      var delete = await m_order.delete_po(no_bukti);
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
      double qty = data_brg_keranjang[i].qty;
      double harga = data_brg_keranjang[i].harga;
      double subTotal = harga * qty;
      Map obj = new Map();
      obj['kd_brg'] = data_brg_keranjang[i].kd_brg;
      obj['na_brg'] = data_brg_keranjang[i].na_brg;
      obj['satuan'] = data_brg_keranjang[i].satuan;
      obj['qty'] = data_brg_keranjang[i].qty;
      obj['satuan'] = data_brg_keranjang[i].satuan;
      obj['harga'] = harga;
      obj['qty'] = qty;
      obj['total'] = subTotal;
      brgList.add(obj);
    }
    return brgList;
  }
}
