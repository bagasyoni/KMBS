import 'package:akunt/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_penjualan.dart';
import 'package:akunt/model/model_pakaibhn.dart';
import 'package:akunt/model/master/operasional/model_bahan.dart';
import 'package:akunt/model/master/operasional/data_bhn.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PakaibhnController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_pakaibhn m_pakaibhn = model_pakaibhn();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_pakaibhn_list = [];
  static List home_stockbhn_list = [];
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
  double total = 0;
  double qty = 0;
  int index_terpilih;
  TextEditingController c_page = new TextEditingController();
  List<DropdownMenuItem<int>> dropdownLimit;
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
    data_pakaibhn_list = await m_pakaibhn.data_pakaibhnpaginate(
        searchController.text, offset, limit);
    home_stockbhn_list = await m_pakaibhn.data_pakaibhnpaginate(
        searchController.text, offset, limit);
    var count = await m_pakaibhn.countPakaibhnPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_pakaibhn_list = await model_pakaibhn().data_modal(cari);
    home_stockbhn_list = await model_pakaibhn().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_pakaibhn_list = await m_pakaibhn.select_pakaibhn(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    home_stockbhn_list = await m_pakaibhn.select_pakaibhn(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_pakaibhn_list.length; i++) {
      total += double.parse(data_pakaibhn_list[i]['TOTAL'].toString());
      qty += double.parse(data_pakaibhn_list[i]['total_qty'].toString());
    }
    notifyListeners();
  }

  void selectData(String cari) async {
    data_pakaibhn_list = await model_pakaibhn().cari_pakai_bhn(cari);
    home_stockbhn_list = await model_pakaibhn().cari_pakai_bhn(cari);
    await baca_periodePrefs();
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
    if (data_pakaibhn_list.length > 0) {
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
      for (int i = 0; i < data_pakaibhn_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_pakaibhn_list[i]['tanggal'];
        isi_map['b'] = data_pakaibhn_list[i]['no_bukti'];
        isi_map['c'] = data_pakaibhn_list[i]['sales'];
        isi_map['d'] = data_pakaibhn_list[i]['customer'];
        isi_map['e'] = data_pakaibhn_list[i]['keterangan'];
        isi_map['f'] = data_pakaibhn_list[i]['total_qty'];
        isi_map['g'] = data_pakaibhn_list[i]['total_so'];
        if (data_pakaibhn_list[i]['status'] == 1) {
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
      map_transaksi['a'] = data_pakaibhn_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_pakaibhn_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_pakaibhn_list[index_terpilih]['sales'];
      map_transaksi['d'] = data_pakaibhn_list[index_terpilih]['customer'];
      map_transaksi['e'] = data_pakaibhn_list[index_terpilih]['keterangan'];
      if (data_pakaibhn_list[index_terpilih]['status'] == 1) {
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
      List data_bhn = await m_pakaibhn.select_pakaibhn_detail(
          data_pakaibhn_list[index_terpilih]['no_bukti'], "NO_BUKTI", "pakai");
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
      footer_excel.add(data_pakaibhn_list[index_terpilih]['total_qty']);
      footer_excel.add("Total");
      footer_excel.add(data_pakaibhn_list[index_terpilih]['total_so']);
      String judul =
          "Invoice Order Penjualan (${data_pakaibhn_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_print() async {
    List data_bhn = await m_pakaibhn.select_pakaibhn_detail(
        data_pakaibhn_list[index_terpilih]['no_bukti'], "NO_BUKTI", "pakai");
    InvoiceOrderPenjualan()
        .proses_print(data_pakaibhn_list[index_terpilih], data_bhn);
  }

  //add pakai
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController total_qtyController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("MMyyyy", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBhn> data_bhn_keranjang = List<DataBhn>();
  double sumQty = 0;
  int no_urut = 0;
  List<DataBhn> bhnList = List<DataBhn>();
  bool status_kasmasuk = true;

  Future<void> initData_addPakaibhn() async {
    data_bhn_keranjang = new List<DataBhn>();
    no_buktiController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    notesController.clear();
    total_qtyController.clear();
    sumQty = 0;
    await baca_periodePrefs();
    await m_pakaibhn
        .get_no_bukti('PK/BHN/I', 'NO_BUKTI', 'pakai')
        .then((value) {
      if (value != null) {
        no_buktiController.text =
            "PK/BHN/I/${format_no_bukti.format(DateTime.now())}/${value[0]['NOMOR']}";
      }
    });
    await model_bahan().cari_bahan("").then((value) {
      if (value != null) {
        bhnList.clear();
        for (int i = 0; i < value.length; i++) {
          bhnList.add(DataBhn.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editPakaibhn(var data_edit) async {
    no_buktiController.text = data_edit['no_bukti'];
    chooseDate = DateTime.parse(data_edit['tgl']);
    notesController.text = data_edit['notes'];
    total_qtyController.text = data_edit['total_qty'].toString();
    tglController.text = format_tanggal.format(chooseDate);
    List data_lama = await m_pakaibhn.select_pakaibhn_detail(
        data_edit['no_bukti'], "NO_BUKTI", "pakaid");
    data_bhn_keranjang = new List<DataBhn>();

    for (int i = 0; i < data_lama.length; i++) {
      DataBhn mAccount = DataBhn(
        noid: data_lama[i]['NO_ID'],
        kd_bhn: data_lama[i]['kd_bHN'],
        na_bhn: data_lama[i]['na_bHN'],
        qty: double.parse(data_lama[i]['qty'].toString()),
        satuan: data_lama[i]['satuan'],
        ket: data_lama[i]['ket'],
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
    // m_barang.stok_booking = 1;
    data_bhn_keranjang.add(mAccount);
    sumQty += mAccount.qty;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    for (int i = 0; i < data_bhn_keranjang.length; i++) {
      sumQty += data_bhn_keranjang[i].qty;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> savePakaibhn() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_bhn_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_pakaibhn.check_no_bukti(
            no_buktiController.text, "NO_BUKTI", "pakai");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['FLAG'] = "PK";
          obj['NOTES'] = notesController.text;
          obj['TOTAL_QTY'] = sumQty;
          obj['USRIN'] = LoginController.nama_staff;
          obj['PER'] = perx;
          obj['TG_IN'] = DateTime.now();
          obj['tabeld'] = await baca_tabeld();
          await m_pakaibhn.insert_pakaibhn(obj);
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

  Future<bool> editPakaibhn() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_bhn_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['FLAG'] = "PK";
        obj['NOTES'] = notesController.text;
        obj['TOTAL_QTY'] = sumQty;
        obj['USRNM'] = LoginController.nama_staff;
        obj['PER'] = perx;
        obj['TG_SMP'] = DateTime.now();
        obj['tabeld'] = await baca_tabeld();
        await m_pakaibhn.update_pakaibhn(obj);
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

  Future<bool> deletePakaibhn(String no_bukti) async {
    try {
      var delete = await m_pakaibhn.delete_pakaibhn(no_bukti);
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
      Map obj = new Map();
      obj['KD_BHN'] = data_bhn_keranjang[i].kd_bhn;
      obj['NA_BHN'] = data_bhn_keranjang[i].na_bhn;
      obj['SATUAN'] = data_bhn_keranjang[i].satuan;
      obj['QTY'] = data_bhn_keranjang[i].qty;
      obj['KET'] = data_bhn_keranjang[i].ket;
      bhnList.add(obj);
    }
    return bhnList;
  }
}
