import 'package:akunt/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/data_bhn.dart';
import 'package:akunt/model/model_bahan.dart';
import 'package:akunt/model/model_pobahan.dart';
import 'package:akunt/model/model_belibahan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BelibahanController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_belibahan m_belibahan = model_belibahan();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_belibahan_list = [];
  static List home_belibahan_list = [];
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
    data_belibahan_list = await m_belibahan.data_belibahanpaginate(
        searchController.text, offset, limit);
    var count = await m_belibahan.countBelibahanPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_belibahan_list = await model_pobahan().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  void selectData(String cari) async {
    data_belibahan_list = await model_belibahan().cari_belibahan(cari);
    await baca_periodePrefs();
    notifyListeners();
  }

  Future<void> select_data() async {
    data_belibahan_list = await m_belibahan.select_beli_bahan(
        searchController.text, tanggal_awal, tanggal_akhir);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_belibahan_list.length; i++) {
      total += double.parse(data_belibahan_list[i]['TOTAL'].toString());
      qty += double.parse(data_belibahan_list[i]['TOTAL_QTY'].toString());
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
    if (data_belibahan_list.length > 0) {
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
      for (int i = 0; i < data_belibahan_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_belibahan_list[i]['tanggal'];
        isi_map['b'] = data_belibahan_list[i]['no_bukti'];
        isi_map['c'] = data_belibahan_list[i]['sales'];
        isi_map['d'] = data_belibahan_list[i]['customer'];
        isi_map['e'] = data_belibahan_list[i]['keterangan'];
        isi_map['f'] = data_belibahan_list[i]['total_qty'];
        isi_map['g'] = data_belibahan_list[i]['total_so'];
        if (data_belibahan_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_belibahan_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_belibahan_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_belibahan_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_belibahan_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_belibahan_list[index_terpilih]['keterangan'];
      if (data_belibahan_list[index_terpilih]['status'] == 1) {
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
      List data_bahan = await m_belibahan.select_beli_bahan_detail(
          data_belibahan_list[index_terpilih]['no_bukti'], "NO_BUKTI", "beli");
      for (int i = 0; i < data_bahan.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_bahan[i]['kd_brg'];
        isi_map['b'] = data_bahan[i]['na_brg'];
        isi_map['c'] = data_bahan[i]['satuan'];
        isi_map['d'] = data_bahan[i]['qty'];
        isi_map['e'] = data_bahan[i]['harga_so'];
        isi_map['f'] = data_bahan[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("");
      footer_excel.add("");
      footer_excel.add("Jumlah");
      footer_excel.add(data_belibahan_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_belibahan_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_belibahan_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_bahan = await m_belibahan.select_beli_bahan_detail(
        data_belibahan_list[index_terpilih]['no_bukti'], "NO_BUKTI", "beli");
    InvoiceOrderPenjualan()
        .proses_print(data_belibahan_list[index_terpilih], data_bahan);
  }

  //add beli bahan
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController jtempoController = TextEditingController();
  TextEditingController nopoController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController total_qtyController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController nettController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_jtempo = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  DateTime chooseDateJT = DateTime.now();
  String tanggal;
  String tanggalJT;
  List<DataBhn> data_bhn_keranjang = List<DataBhn>();
  double nett = 0;
  double ppn = 0;
  double sumQty = 0;
  double sumTotal = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataBhn> bhnList = List<DataBhn>();

  Future<void> initData_addBelibahan() async {
    data_bhn_keranjang = new List<DataBhn>();
    no_buktiController.clear();
    tglController.clear();
    jtempoController.clear();
    nopoController.clear();
    kodesController.clear();
    namasController.clear();
    alamatController.clear();
    kotaController.clear();
    notesController.clear();
    total_qtyController.clear();
    totalController.clear();
    nettController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_jtempo.format(chooseDateJT);
    nett = 0;
    ppn = 0;
    sumQty = 0;
    sumTotal = 0;
    await baca_periodePrefs();
    await m_belibahan.get_no_bukti('BL', 'NO_BUKTI', 'beli').then((value) {
      if (value != null) {
        no_buktiController.text =
            "BL${format_no_bukti.format(DateTime.now())}BH-${value[0]['NOMOR']}";
      }
    });
  }

  ///HEADER///
  Future<void> initData_editBelibahan(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    tglController.text = data_edit['TGL'];
    jtempoController.text = data_edit['JTEMPO'];
    nopoController.text = data_edit['NO_PO'];
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    alamatController.text = data_edit['ALAMAT'];
    kotaController.text = data_edit['KOTA'];
    notesController.text = data_edit['NOTES'];
    total_qtyController.text = data_edit['TOTAL_QTY'].toString();
    totalController.text = data_edit['TOTAL'].toString();
    nettController.text = data_edit['NETT'].toString();
    chooseDate = DateTime.parse(data_edit['TGL']);
    chooseDateJT = DateTime.parse(data_edit['JTEMPO']);
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_jtempo.format(chooseDateJT);
    // chooseDate = DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // status_kasmasuk = data_edit['POSTED'] == 1 ? true : false;
    List data_lama = await m_belibahan.select_beli_bahan_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "belid");
    data_bhn_keranjang = new List<DataBhn>();
    for (int i = 0; i < data_lama.length; i++) {
      DataBhn mAccount = DataBhn(
        noid: data_lama[i]['NO_ID'],
        kd_bhn: data_lama[i]['KD_BHN'],
        na_bhn: data_lama[i]['NA_BHN'],
        satuan: data_lama[i]['SATUAN'],
        ket: data_lama[i]['KET'],
        harga: double.parse(data_lama[i]['HARGA'].toString()),
        qty: double.parse(data_lama[i]['QTY'].toString()),
        total: double.parse(data_lama[i]['TOTAL'].toString()),
      );
      data_bhn_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_bahan().cari_bahan("").then((value) {
      if (value != null) {
        bhnList.clear();
        for (int i = 0; i < value.length; i++) {
          bhnList.add(DataBhn.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataBhn mAccount) {
    data_bhn_keranjang.add(mAccount);
    sumQty += mAccount.qty;
    sumTotal += mAccount.total;
    notifyListeners();
  }

  void hitungSubTotal() {
    nett = 0;
    ppn = 0;
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_bhn_keranjang.length; i++) {
      sumTotal += data_bhn_keranjang[i].harga * data_bhn_keranjang[i].qty;
      sumQty += data_bhn_keranjang[i].qty;
    }
    ppn = 10 / 100 * sumTotal;
    nett = sumTotal - ppn;
    notifyListeners();
  }

  /// data header
  Future<bool> saveBelibahan() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_bhn_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_belibahan.check_no_bukti(
            no_buktiController.text, "NO_BUKTI", "beli");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDateJT);
          obj['NO_PO'] = nopoController.text;
          obj['KODES'] = kodesController.text;
          obj['NAMAS'] = namasController.text;
          obj['ALAMAT'] = alamatController.text;
          obj['KOTA'] = kotaController.text;
          obj['NOTES'] = notesController.text;
          obj['TOTAL_QTY'] = sumQty;
          obj['TOTAL'] = sumTotal;
          obj['PER'] = perx;
          obj['PPN'] = perx;
          obj['NETT'] = perx;
          obj['USRNM'] = LoginController.nama_staff;
          obj['tabeld'] = await baca_tabeld();
          await m_belibahan.insert_beli_bahan(obj);
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

  Future<bool> editBelibahan() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_bhn_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDateJT);
        obj['NO_PO'] = nopoController.text;
        obj['KODES'] = kodesController.text;
        obj['NAMAS'] = namasController.text;
        obj['ALAMAT'] = alamatController.text;
        obj['KOTA'] = kotaController.text;
        obj['NOTES'] = notesController.text;
        obj['TOTAL_QTY'] = sumQty;
        obj['TOTAL'] = sumTotal;
        obj['PER'] = perx;
        obj['PPN'] = perx;
        obj['NETT'] = perx;
        obj['USRNM'] = LoginController.nama_staff;
        obj['tabeld'] = await baca_tabeld();
        await m_belibahan.update_beli_bahan(obj);
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

  Future<bool> deleteBelibahan(String no_bukti) async {
    try {
      var delete = await m_belibahan.delete_beli_bahan(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List bhnList = [];
    for (int i = 0; i < data_bhn_keranjang.length; i++) {
      double qty = data_bhn_keranjang[i].qty;
      double harga = data_bhn_keranjang[i].harga;
      double subTotal = harga * qty;
      Map obj = new Map();
      obj['KD_BHN'] = data_bhn_keranjang[i].kd_bhn;
      obj['NA_BHN'] = data_bhn_keranjang[i].na_bhn;
      obj['SATUAN'] = data_bhn_keranjang[i].satuan;
      obj['KET'] = data_bhn_keranjang[i].ket;
      obj['HARGA'] = data_bhn_keranjang[i].harga;
      obj['QTY'] = data_bhn_keranjang[i].qty;
      obj['TOTAL'] = subTotal;
      bhnList.add(obj);
    }
    return bhnList;
  }

  Future<void> importDataFromPO(var data_po) async {
    nopoController.text = data_po['NO_BUKTI'].toString();
    kodesController.text = data_po['KODES'].toString();
    namasController.text = data_po['NAMAS'].toString();
    tglController.text = data_po['TGL'].toString();
    List data_detail_po = await model_pobahan()
        .select_po_bahan_detail(data_po['NO_BUKTI'], "NO_BUKTI", "pod");
    data_bhn_keranjang = [];
    for (int i = 0; i < data_detail_po.length; i++) {
      DataBhn m_bhn = DataBhn(
        noid: int.parse(data_detail_po[i]['NO_ID'].toString()),
        kd_bhn: data_detail_po[i]['KD_BHN'],
        na_bhn: data_detail_po[i]['NA_BHN'],
        satuan: data_detail_po[i]['SATUAN'],
        ket: data_detail_po[i]['KET'],
        harga: double.parse(data_detail_po[i]['HARGA'].toString()),
        qty: double.parse(data_detail_po[i]['SISA'].toString()),
      );
      data_bhn_keranjang.add(m_bhn);
      hitungSubTotal();
    }
  }
}
