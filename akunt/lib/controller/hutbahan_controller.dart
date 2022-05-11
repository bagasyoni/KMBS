import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/model_belibahan.dart';
import 'package:akunt/model/model_hutbahan.dart';
import 'package:akunt/model/data_beli.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HutbahanController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_hutbahan m_hutbahan = model_hutbahan();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_hutbahan_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  double hutang = 0;
  double bayar = 0;
  double sisa = 0;
  int index_terpilih;
  TextEditingController c_page = new TextEditingController();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void limitPaging() {
    dropdownLimit = [];
    dropdownLimit.add(DropdownMenuItem(
      child: Text('10'),
      value: 10,
    ));
    dropdownLimit.add(DropdownMenuItem(
      child: Text('30'),
      value: 30,
    ));
    dropdownLimit.add(DropdownMenuItem(
      child: Text('50'),
      value: 50,
    ));
    dropdownLimit.add(DropdownMenuItem(
      child: Text('100'),
      value: 100,
    ));
    limit = dropdownLimit[0].value;
  }

  ///paginate
  Future<void> selectDataPaginate(bool reload) async {
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    data_hutbahan_list = await m_hutbahan.data_hutbahanpaginate(
        searchController.text, offset, limit);
    var count = await m_hutbahan.countHutbahanPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  // void modalData(String cari) async {
  //   data_hutbahan_list = await model_hutbahan().data_modal(cari);
  //   notifyListeners();
  // }

  Future<void> select_data() async {
    data_hutbahan_list = await m_hutbahan.select_hut_bahan(
        searchController.text, tanggal_awal, tanggal_akhir);
    hutang = 0;
    bayar = 0;
    sisa = 0;
    for (int i = 0; i < data_hutbahan_list.length; i++) {
      hutang += double.parse(data_hutbahan_list[i]['TOTAL'].toString());
      bayar += double.parse(data_hutbahan_list[i]['BAYAR'].toString());
      sisa += double.parse(data_hutbahan_list[i]['SISA'].toString());
    }
    notifyListeners();
  }

  void selectData(String cari) async {
    data_hutbahan_list = await model_hutbahan().cari_hut_bahan(cari);
    notifyListeners();
  }

  void initData() {
    c_page.text = '1';
    limitPaging();
    selectDataPaginate(true);
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
    if (data_hutbahan_list.length > 0) {
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
      for (int i = 0; i < data_hutbahan_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_hutbahan_list[i]['tanggal'];
        isi_map['b'] = data_hutbahan_list[i]['no_bukti'];
        isi_map['c'] = data_hutbahan_list[i]['sales'];
        isi_map['d'] = data_hutbahan_list[i]['customer'];
        isi_map['e'] = data_hutbahan_list[i]['keterangan'];
        isi_map['f'] = data_hutbahan_list[i]['total_qty'];
        isi_map['g'] = data_hutbahan_list[i]['total_so'];
        if (data_hutbahan_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_hutbahan_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_hutbahan_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_hutbahan_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_hutbahan_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_hutbahan_list[index_terpilih]['keterangan'];
      if (data_hutbahan_list[index_terpilih]['status'] == 1) {
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
      List data_thut = await m_hutbahan.select_hut_bahan_detail(
          data_hutbahan_list[index_terpilih]['no_bukti'], "NO_BUKTI", "kas");
      for (int i = 0; i < data_thut.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_thut[i]['kd_brg'];
        isi_map['b'] = data_thut[i]['na_brg'];
        isi_map['c'] = data_thut[i]['satuan'];
        isi_map['d'] = data_thut[i]['qty'];
        isi_map['e'] = data_thut[i]['harga_so'];
        isi_map['f'] = data_thut[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_hutbahan_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_hutbahan_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_hutbahan_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_thut = await m_hutbahan.select_hut_bahan_detail(
        data_hutbahan_list[index_terpilih]['no_bukti'], "NO_BUKTI", "po");
    InvoiceOrderPenjualan()
        .proses_print(data_hutbahan_list[index_terpilih], data_thut);
  }

  //add hut bahan
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController bayarController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBeli> data_beli_keranjang = List<DataBeli>();
  double sumQty = 0;
  double sumTotal = 0;
  double sumBayar = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataBeli> beliList = List<DataBeli>();
  bool status_kasmasuk = true;

  Future<void> initData_addHutbahan() async {
    data_beli_keranjang = new List<DataBeli>();
    no_buktiController.clear();
    tglController.clear();
    kodesController.clear();
    namasController.clear();
    alamatController.clear();
    kotaController.clear();
    notesController.clear();
    bayarController.clear();
    totalController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    sumTotal = 0;
    sumBayar = 0;
    await baca_periodePrefs();
    await m_hutbahan
        .countBukti(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        no_buktiController.text =
            "HUT${format_no_bukti.format(DateTime.now())}BH-${no_urut + 1}";
      }
    });
    await model_belibahan().cari_belibahan_hut("").then((value) {
      if (value != null) {
        beliList.clear();
        for (int i = 0; i < value.length; i++) {
          beliList.add(DataBeli.fromJson(value[i]));
        }
      }
    });
  }

  Future<void> initBeliBahan(String kodesupl) async {
    await model_belibahan().cari_belibahan_hut(kodesupl).then((value) {
      if (value != null) {
        beliList.clear();
        for (int i = 0; i < value.length; i++) {
          beliList.add(DataBeli.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editHutbahan(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    tglController.text = data_edit['TGL'];
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    alamatController.text = data_edit['ALAMAT'];
    kotaController.text = data_edit['KOTA'];
    notesController.text = data_edit['NOTES'];
    bayarController.text = data_edit['BAYAR'].toString();
    totalController.text = data_edit['TOTAL'].toString();
    chooseDate = DateTime.parse(data_edit['TGL']);
    tglController.text = format_tanggal.format(chooseDate);
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_hutbahan.select_hut_bahan_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "hutd");
    data_beli_keranjang = new List<DataBeli>();
    for (int i = 0; i < data_lama.length; i++) {
      DataBeli mAccount = DataBeli(
        noid: data_lama[i]['NO_ID'],
        no_bukti: data_lama[i]['NO_FAKTUR'],
        notes: data_lama[i]['URAIAN'],
        total: double.parse(data_lama[i]['TOTAL'].toString()),
        bayar: double.parse(data_lama[i]['BAYAR'].toString()),
      );
      data_beli_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_belibahan().cari_belibahan("").then((value) {
      if (value != null) {
        beliList.clear();
        for (int i = 0; i < value.length; i++) {
          beliList.add(DataBeli.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataBeli mAccount) {
    data_beli_keranjang.add(mAccount);
    sumQty += 1;
    sumTotal += mAccount.total;
    sumBayar += mAccount.bayar;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    sumBayar = 0;
    for (int i = 0; i < data_beli_keranjang.length; i++) {
      sumTotal += data_beli_keranjang[i].total;
      sumBayar += data_beli_keranjang[i].bayar;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveHutbahan() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_beli_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_hutbahan.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "hut");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['KODES'] = kodesController.text;
          obj['NAMAS'] = namasController.text;
          obj['ALAMAT'] = alamatController.text;
          obj['KOTA'] = kotaController.text;
          obj['NOTES'] = notesController.text;
          obj['BAYAR'] = sumBayar;
          obj['TOTAL'] = sumTotal;
          obj['PER'] = perx;
          obj['tabeld'] = await baca_tabeld();
          await m_hutbahan.insert_hut_bahan(obj);
          print(m_hutbahan);
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast(
            "Peringatan !", "Belum ada detail Transaksi yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> editHutbahan() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_beli_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['KODES'] = kodesController.text;
        obj['NAMAS'] = namasController.text;
        obj['ALAMAT'] = alamatController.text;
        obj['KOTA'] = kotaController.text;
        obj['NOTES'] = notesController.text;
        obj['BAYAR'] = sumBayar;
        obj['TOTAL'] = sumTotal;
        obj['PER'] = perx;
        obj['tabeld'] = await baca_tabeld();
        await m_hutbahan.update_hut_bahan(obj);
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

  Future<bool> deleteHutbahan(String no_bukti) async {
    try {
      var delete = await m_hutbahan.delete_hut_bahan(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List beliList = [];
    for (int i = 0; i < data_beli_keranjang.length; i++) {
      // double qty = data_beli_keranjang[i].qty;
      // double harga = data_beli_keranjang[i].harga;
      // double subTotal = harga * qty;
      Map obj = new Map();
      obj['NO_BELI'] = data_beli_keranjang[i].no_bukti;
      obj['NOTES'] = data_beli_keranjang[i].notes;
      obj['TOTAL'] = data_beli_keranjang[i].total;
      obj['BAYAR'] = data_beli_keranjang[i].bayar;
      beliList.add(obj);
    }
    return beliList;
  }
}
