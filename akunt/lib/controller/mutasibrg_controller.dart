import 'package:flutter/material.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/model_mutasibrg.dart';
import 'package:akunt/model/model_brg.dart';
import 'package:akunt/model/data_brg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MutasibrgController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_mutasibrg m_mutasibrg = model_mutasibrg();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_mutasibrg_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  int index_terpilih;
  double total = 0;
  double qty = 0;
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
    data_mutasibrg_list = await m_mutasibrg.data_mutasibrgpaginate(
        searchController.text, offset, limit);
    var count = await m_mutasibrg.countMutasibrgPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_mutasibrg_list = await m_mutasibrg.select_mutasibrg(
        searchController.text, tanggal_awal, tanggal_akhir);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_mutasibrg_list.length; i++) {
      total += double.parse(data_mutasibrg_list[i]['TOTAL'].toString());
      qty += double.parse(data_mutasibrg_list[i]['TOTAL_QTY'].toString());
    }
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
    if (data_mutasibrg_list.length > 0) {
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
      for (int i = 0; i < data_mutasibrg_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_mutasibrg_list[i]['tanggal'];
        isi_map['b'] = data_mutasibrg_list[i]['no_bukti'];
        isi_map['c'] = data_mutasibrg_list[i]['sales'];
        isi_map['d'] = data_mutasibrg_list[i]['customer'];
        isi_map['e'] = data_mutasibrg_list[i]['keterangan'];
        isi_map['f'] = data_mutasibrg_list[i]['total_qty'];
        isi_map['g'] = data_mutasibrg_list[i]['total_so'];
        if (data_mutasibrg_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_mutasibrg_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_mutasibrg_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_mutasibrg_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_mutasibrg_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_mutasibrg_list[index_terpilih]['keterangan'];
      if (data_mutasibrg_list[index_terpilih]['status'] == 1) {
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
      List data_brg = await m_mutasibrg.select_mutasibrg_detail(
          data_mutasibrg_list[index_terpilih]['no_bukti'], "NO_BUKTI", "kas");
      for (int i = 0; i < data_brg.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_brg[i]['kd_brg'];
        isi_map['b'] = data_brg[i]['na_brg'];
        isi_map['c'] = data_brg[i]['satuan'];
        isi_map['d'] = data_brg[i]['qty'];
        isi_map['e'] = data_brg[i]['harga_so'];
        isi_map['f'] = data_brg[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_mutasibrg_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_mutasibrg_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_mutasibrg_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_brg = await m_mutasibrg.select_mutasibrg_detail(
        data_mutasibrg_list[index_terpilih]['no_bukti'], "NO_BUKTI", "stockb");
    InvoiceOrderPenjualan()
        .proses_print(data_mutasibrg_list[index_terpilih], data_brg);
  }

  //add stockb
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

  Future<void> initData_addMutasibrg() async {
    data_brg_keranjang = new List<DataBrg>();
    no_buktiController.clear();
    tglController.clear();
    notesController.clear();
    total_qtyController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    sumQty = 0;
    await m_mutasibrg
        .countmutasibrg(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        no_buktiController.text =
            "KA${format_no_bukti.format(DateTime.now())}BRG-${no_urut + 1}";
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
  Future<void> initData_editMutasibrg(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tglController.text = format_tanggal.format(chooseDate);
    notesController.text = data_edit['NOTES'];
    total_qtyController.text = data_edit['TOTAL_QTY'].toString();
    List data_lama = await m_mutasibrg.select_mutasibrg_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "stockbd");
    data_brg_keranjang = new List<DataBrg>();

    for (int i = 0; i < data_lama.length; i++) {
      DataBrg mAccount = DataBrg(
        noid: data_lama[i]['NO_ID'],
        kd_brg: data_lama[i]['KD_BRG'],
        na_brg: data_lama[i]['NA_BRG'],
        qty: double.parse(data_lama[i]['QTY'].toString()),
        satuan: data_lama[i]['SATUAN'],
        stockr: double.parse(data_lama[i]['STOCKR'].toString()),
        fisik: double.parse(data_lama[i]['FISIK'].toString()),
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
  Future<bool> saveMutasibrg() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_mutasibrg.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "stockb");
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
          obj['USRNM'] = LoginController.nama_staff;
          obj['tabeld'] = await baca_tabeld();
          await m_mutasibrg.insert_mutasibrg(obj);
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

  Future<bool> editMutasibrg() async {
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
        obj['USRNM'] = LoginController.nama_staff;
        obj['tabeld'] = await baca_tabeld();
        await m_mutasibrg.update_mutasibrg(obj);
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

  Future<bool> deleteMutasibrg(String no_bukti) async {
    try {
      var delete = await m_mutasibrg.delete_mutasibrg(no_bukti);
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
      obj['QTY'] = data_brg_keranjang[i].qty;
      obj['STOCKR'] = data_brg_keranjang[i].stockr;
      obj['FISIK'] = data_brg_keranjang[i].fisik;
      brgList.add(obj);
    }
    return brgList;
  }
}
