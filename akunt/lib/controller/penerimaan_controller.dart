import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/config/export_pdf_array_10a.dart';
import 'package:akunt/invoice/invoice_penerimaan.dart';
import 'package:akunt/model/data_barang.dart';
import 'package:akunt/model/model_barang.dart';
import 'package:akunt/model/model_po_penerimaan.dart';
import 'package:akunt/model/model_penerimaan.dart';
import 'package:akunt/model/model_sales.dart';
// import 'package:akunt/model/model_supplier.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/view/penerimaan/export_by_supplier_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenerimaanController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_penerimaan m_order = model_penerimaan();
  TextEditingController searchController = TextEditingController();
  TextEditingController filterTanggalController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_penerimaan_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  double total_pengeluaran = 0;
  int index_terpilih;
  List data_excel_bySupplier = [];
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

  Future<void> initData() async {
    c_page.text = '1';
    index_terpilih = null;
    limitPaging();
    /*
    tanggal_awal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggal_akhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('yyyy/MM/dd', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('yyyy/MM/dd', "id_ID").format(DateTime.now()).toString();
    */
    await baca_periodePrefs();
    await select_data(true);
    // initFilterSupplier();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    range = prefs.getString("filter") ?? "";
    filterTanggalController.text = range.replaceAll('-', '/');
    tanggal_awal = range;
  }

  Future<void> select_data(bool reload) async {
    // data_penerimaan_list = await m_order.select_penerimaan(
    //     searchController.text,
    //     tanggal_awal + " 00:00:00",
    //     tanggal_akhir + " 23:59:59",
    //     filter_supplier);
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    if (tanggal_akhir != "") {
      data_penerimaan_list = await m_order.select_penerimaan(
          searchController.text,
          tanggal_awal,
          tanggal_akhir,
          filter_supplier,
          offset,
          limit);
      var count = await m_order.countDataTerima(
          searchController.text, tanggal_awal, tanggal_akhir, filter_supplier);
      totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
      pageCount = totalNotaTerima / limit;
    } else {
      data_penerimaan_list = await m_order.select_penerimaan(
          searchController.text,
          tanggal_awal,
          "",
          filter_supplier,
          offset,
          limit);
      var count = await m_order.countDataTerima(
          searchController.text, tanggal_awal, "", filter_supplier);
      totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
      pageCount = totalNotaTerima / limit;
    }
    total_pengeluaran = 0;
    for (int i = 0; i < data_penerimaan_list.length; i++) {
      total_pengeluaran += double.parse(data_penerimaan_list[i]['total']);
    }
    prefs.setString("filter", filterTanggalController.text);
    notifyListeners();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value != null) {
      if (args.value is PickerDateRange) {
        if (args.value.startDate != null) {
          range = DateFormat('yyyy/MM/dd', "id_ID")
                  .format(args.value.startDate)
                  .toString() +
              ' - ' +
              DateFormat('yyyy/MM/dd', "id_ID")
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
      filterTanggalController.text = range;
      notifyListeners();
    }
  }

  void proses_export() {
    if (data_penerimaan_list.length > 0) {
      BotToast.showLoading();
      List header_excel = [];
      List isi_excel = [];
      header_excel.add("Tanggal");
      header_excel.add("No bukti");
      header_excel.add("No SP");
      header_excel.add("Supplier");
      header_excel.add("kode");
      header_excel.add("jatuh_tempo");
      header_excel.add("keterangan");
      header_excel.add("Qty");
      header_excel.add("Pajak(%)");
      header_excel.add("Total");
      for (int i = 0; i < data_penerimaan_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_penerimaan_list[i]['tanggal'];
        isi_map['b'] = data_penerimaan_list[i]['no_bukti'];
        isi_map['c'] = data_penerimaan_list[i]['no_sp'];
        isi_map['d'] = data_penerimaan_list[i]['supplier'];
        isi_map['e'] = data_penerimaan_list[i]['kode'];
        isi_map['f'] = data_penerimaan_list[i]['jatuh_tempo'];
        isi_map['g'] = data_penerimaan_list[i]['keterangan'];
        isi_map['h'] = data_penerimaan_list[i]['qty'];
        isi_map['i'] = data_penerimaan_list[i]['pajak'];
        isi_map['j'] = data_penerimaan_list[i]['total'];
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Penerimaan (${range.replaceAll("/", "")})";
      config().createExcel(header_excel, isi_excel, judul);
    } else {
      Toast("Tidak ada data untuk di export", "", false);
    }
  }

  Future<void> proses_export_detail() async {
    if (index_terpilih != null) {
      BotToast.showLoading();
      List header_excel = [];
      List header_detail_excel = [];
      List isi_excel = [];
      List isi_detail_excel = [];
      List footer_excel = [];
      header_excel.add("Tanggal");
      header_excel.add("No Bukti");
      header_excel.add("No SP");
      header_excel.add("Supplier");
      header_excel.add("keterangan");
      header_excel.add("Jatuh Tempo");
      Map<String, dynamic> map_transaksi = new Map<String, dynamic>();
      map_transaksi['a'] = data_penerimaan_list[index_terpilih]['tanggal'];
      map_transaksi['b'] = data_penerimaan_list[index_terpilih]['no_bukti'];
      map_transaksi['c'] = data_penerimaan_list[index_terpilih]['no_sp'];
      map_transaksi['d'] = data_penerimaan_list[index_terpilih]['supplier'];
      map_transaksi['e'] = data_penerimaan_list[index_terpilih]['keterangan'];
      map_transaksi['f'] = data_penerimaan_list[index_terpilih]['jatuh_tempo'];
      isi_excel.add(map_transaksi);

      header_detail_excel.add("Kode Barang");
      header_detail_excel.add("Nama Barang");
      header_detail_excel.add("Satuan");
      header_detail_excel.add("Qty");
      header_detail_excel.add("Harga");
      header_detail_excel.add("SubTotal");
      List data_barang = await m_order.select_penerimaan_detail(
          data_penerimaan_list[index_terpilih]['no_bukti']);
      for (int i = 0; i < data_barang.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_barang[i]['kd_brg'];
        isi_map['b'] = data_barang[i]['na_brg'];
        isi_map['c'] = data_barang[i]['satuan'];
        isi_map['d'] = data_barang[i]['qty'];
        isi_map['e'] = data_barang[i]['harga_beli'];
        isi_map['f'] = data_barang[i]['sub_total'];
        isi_detail_excel.add(isi_map);
      }
      footer_excel.add("Pajak(%)");
      footer_excel.add(data_penerimaan_list[index_terpilih]['pajak']);
      footer_excel.add("Jumlah");
      footer_excel.add(data_penerimaan_list[index_terpilih]['qty']);
      footer_excel.add("Total");
      footer_excel.add(data_penerimaan_list[index_terpilih]['total']);
      String judul =
          "Invoice Pembelian (${data_penerimaan_list[index_terpilih]['no_bukti']})";
      config().createExcel2(header_excel, header_detail_excel, isi_excel,
          isi_detail_excel, footer_excel, judul);
    } else {
      Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
    }
  }

  Future<void> proses_to_export_screen(BuildContext context) async {
    data_excel_bySupplier.clear();
    if (filter_supplier.isNotEmpty) {
      if (data_penerimaan_list.length > 0) {
        BotToast.showLoading();
        for (int i = 0; i < data_penerimaan_list.length; i++) {
          List data_barang = await m_order
              .select_penerimaan_detail(data_penerimaan_list[i]['no_bukti']);
          for (int j = 0; j < data_barang.length; j++) {
            Map<String, dynamic> isi_map = new Map<String, dynamic>();
            isi_map['a'] = data_penerimaan_list[i]['tanggal'];
            isi_map['b'] = data_penerimaan_list[i]['no_bukti'];
            isi_map['c'] = data_penerimaan_list[i]['no_sp'];
            isi_map['d'] = data_barang[j]['kd_brg'];
            isi_map['e'] = data_barang[j]['na_brg'];
            isi_map['f'] = data_barang[j]['qty'];
            isi_map['g'] = data_barang[j]['satuan'];
            isi_map['h'] = data_barang[j]['harga_beli'];
            isi_map['i'] = data_barang[j]['sub_total'];
            data_excel_bySupplier.add(isi_map);
          }
        }
        BotToast.closeAllLoading();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ExportBySupplierScreen(filter_supplier)));
      } else {
        Toast("Tidak ada data untuk di export", "", false);
      }
    } else {
      Toast("Belum ada supplier yang terpilih",
          "Silahkan filter laporan berdasarkan supplier tertentu !", false);
    }
  }

  Future<void> proses_export_perSupplier(int mode) async {
    if (filter_supplier.isNotEmpty) {
      if (data_penerimaan_list.length > 0) {
        BotToast.showLoading();
        List header_excel = new List();
        List isi_excel = new List();
        header_excel.add("Tanggal");
        header_excel.add("No bukti");
        header_excel.add("No SP");
        header_excel.add("Kode Barang");
        header_excel.add("Nama Barang");
        header_excel.add("Satuan");
        header_excel.add("Qty");
        header_excel.add("Harga Beli");
        header_excel.add("SubTotal");
        for (int i = 0; i < data_penerimaan_list.length; i++) {
          List data_barang = await m_order
              .select_penerimaan_detail(data_penerimaan_list[i]['no_bukti']);
          for (int j = 0; j < data_barang.length; j++) {
            Map<String, dynamic> isi_map = new Map<String, dynamic>();
            if (j == 0) {
              isi_map['a'] = data_penerimaan_list[i]['tanggal'];
              isi_map['b'] = data_penerimaan_list[i]['no_bukti'];
              isi_map['c'] = data_penerimaan_list[i]['no_sp'];
            } else {
              isi_map['a'] = "";
              isi_map['b'] = "";
              isi_map['c'] = "";
            }
            isi_map['d'] = data_barang[j]['kd_brg'];
            isi_map['e'] = data_barang[j]['na_brg'];
            isi_map['f'] = data_barang[j]['satuan'];
            isi_map['g'] = data_barang[j]['qty'];
            isi_map['h'] = data_barang[j]['harga_beli'];
            isi_map['i'] = data_barang[j]['sub_total'];
            isi_excel.add(isi_map);
          }
        }
        String judul =
            "Laporan Penerimaan By $filter_supplier(${range.replaceAll("/", "")})";
        String header_title = "Dari Supplier : $filter_supplier";
        if (mode == 0) {
          config().createExcel3(header_excel, isi_excel, header_title, judul);
        } else {
          ExportPDF(header_excel, isi_excel, judul);
        }
      } else {
        Toast("Tidak ada data untuk di export", "", false);
      }
    } else {
      Toast("Belum ada supplier yang terpilih",
          "Silahkan filter laporan berdasarkan supplier tertentu !", false);
    }
  }

  Future<void> proses_print() async {
    List data_barang = await m_order.select_penerimaan_detail(
        data_penerimaan_list[index_terpilih]['no_bukti']);
    InvoicePembelian()
        .proses_print(data_penerimaan_list[index_terpilih], data_barang);
  }

  //add pembelian
  TextEditingController noBuktiController = TextEditingController();
  TextEditingController noSpController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController jTempoController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController pajakController = TextEditingController();
  final format_tanggal = new DateFormat("EEEE, d MMMM yyyy", "id_ID");
  // final format_tanggal = DateFormat("yyyy-MM-dd");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  final format_periode = new DateFormat("yyyy/MM", "id_ID");
  DateTime chooseDate = DateTime.now();
  DateTime chooseDateJT = DateTime.now();
  String tanggal;
  String tanggalJT;
  List<DataBarang> data_barang_keranjang = new List<DataBarang>();
  double sumQty = 0;
  double sumTotal = 0;
  double pajak, nilai_pajak = 0;
  String namas, hari;
  int no_urut = 0;
  List<DataBarang> brgList = [];
  bool status_penerimaan = true;

  Future<void> initData_addPenerimaan() async {
    await baca_periodePrefs();
    try {
      chooseDate = format_periode.parse(range);
    } catch (e) {
      chooseDate = DateTime.now();
    }
    data_barang_keranjang = new List<DataBarang>();
    noBuktiController.clear();
    noSpController.clear();
    supplierController.clear();
    keteranganController.clear();
    pajakController.clear();
    // tanggalController.text = format_tanggal.format(chooseDate);
    try {
      tanggalController.text =
          format_tanggal.format(format_periode.parse(range));
    } catch (e) {
      tanggalController.text = format_tanggal.format(chooseDate);
    }
    sumQty = 0;
    sumTotal = 0;
    await m_order
        .countPenerimaan(DateFormat("y-M-d").format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        // noBuktiController.text =
        //     "BL${format_no_bukti.format(DateTime.now())}-${no_urut + 1}";
        try {
          noBuktiController.text =
              "BL${format_no_bukti.format(format_periode.parse(range))}-${no_urut + 1}";
        } catch (e) {
          noBuktiController.text =
              "BL${format_no_bukti.format(DateTime.now())}-${no_urut + 1}";
        }
      }
    });
  }

  Future<void> initData_editPenerimaan(var data_edit) async {
    noBuktiController.text = data_edit['NO_BUKTI'];
    supplierController.text = data_edit['KODES'];
    noSpController.text = data_edit['NO_PO'];
    keteranganController.text = data_edit['notes'];
    chooseDate = DateTime.tryParse(data_edit['TGL']);
    // chooseDateJT = data_edit['JTEMPO'];
    chooseDateJT = DateTime.tryParse(data_edit['JTEMPO']);
    namas = data_edit['NAMAS'].toString();
    hari = data_edit['HARI'].toString();
    pajak = data_edit['GOLONGAN'].toString() == "P1" ? 10.00 : 0.00;
    pajakController.text = data_edit['ppn'].toString();
    tanggalController.text = format_tanggal.format(chooseDate);
    jTempoController.text = format_tanggal.format(chooseDateJT);
    status_penerimaan = data_edit['POSTED'] == 1 ? true : false;
    List data_lama =
        await m_order.select_penerimaan_detail(data_edit['NO_BUKTI']);
    data_barang_keranjang = [];
    for (int i = 0; i < data_lama.length; i++) {
      DataBarang mBrg = DataBarang(
        id: int.parse(data_lama[i]['NO_ID']),
        kd_brg: data_lama[i]['KD_BRG'],
        na_brg: data_lama[i]['NA_BRG'],
        satuan: data_lama[i]['KET_UK'],
        stok_booking: double.parse(data_lama[i]['qty']),
        harga_beli: double.parse(data_lama[i]['harga']),
      );
      data_barang_keranjang.add(mBrg);
    }
    hitungSubTotal();
    await model_barang().data_brg_tampil("").then((value) {
      if (value != null) {
        brgList.clear();
        for (int i = 0; i < value.length; i++) {
          brgList.add(DataBarang.fromJson(value[i]));
        }
      }
    });
  }

  Future<bool> savePenerimaan() async {
    hitungSubTotal();
    if (noBuktiController.text.isNotEmpty) {
      if (data_barang_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_order.get_no_bukti(noBuktiController.text);
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${noBuktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['tanggal'] = DateFormat('y-M-d').format(chooseDate);
          obj['no_bukti'] = noBuktiController.text;
          obj['no_sp'] = noSpController.text;
          obj['supplier'] = supplierController.text;
          obj['namasupplier'] = namas;
          obj['gol'] = pajak == 0.00 ? "" : "P1";
          obj['hari'] = hari;
          obj['jatuh_tempo'] = DateFormat('y-M-d').format(chooseDateJT);
          obj['qty'] = sumQty;
          obj['total'] = sumTotal;
          obj['pajak'] = pajakController.text;
          obj['keterangan'] = keteranganController.text;
          obj['barang'] = await baca_barang();
          await m_order.insert_penerimaan(obj);
          // await model_order_pembelian().update_total_used(noSpController.text);
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast("Peringatan !", "Belum ada data barang yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> editPenerimaan() async {
    hitungSubTotal();
    if (noBuktiController.text.isNotEmpty) {
      if (data_barang_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['tanggal'] = DateFormat('y-M-d').format(chooseDate);
        obj['no_bukti'] = noBuktiController.text;
        obj['no_sp'] = noSpController.text;
        obj['supplier'] = supplierController.text;
        obj['namasupplier'] = namas;
        obj['gol'] = pajak == 0.00 ? "" : "P1";
        obj['hari'] = hari;
        obj['jatuh_tempo'] = DateFormat('y-M-d').format(chooseDateJT);
        obj['qty'] = sumQty;
        obj['total'] = sumTotal;
        obj['pajak'] = pajakController.text;
        obj['keterangan'] = keteranganController.text;
        obj['barang'] = await baca_barang();
        await m_order.update_penerimaan(obj);
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

  Future<bool> deletePenerimaan(String no_bukti) async {
    try {
      var delete = await m_order.delete_penerimaan(no_bukti);
      await select_data(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List> baca_barang() async {
    List barangList = [];
    for (int i = 0; i < data_barang_keranjang.length; i++) {
      double qty = data_barang_keranjang[i].stok_booking;
      double harga = data_barang_keranjang[i].harga_beli;
      double subTotal = harga * qty;
      Map obj = new Map();
      obj['kd_brg'] = data_barang_keranjang[i].kd_brg;
      obj['na_brg'] = data_barang_keranjang[i].na_brg;
      obj['satuan'] = data_barang_keranjang[i].satuan;
      obj['qty'] = qty;
      obj['harga_beli'] = harga;
      obj['sub_total'] = subTotal;
      barangList.add(obj);
    }
    return barangList;
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_barang_keranjang.length; i++) {
      sumQty += data_barang_keranjang[i].stok_booking;
      sumTotal += data_barang_keranjang[i].harga_beli *
          data_barang_keranjang[i].stok_booking;
    }
    nilai_pajak = (sumTotal * pajak) / 100;
    sumTotal += nilai_pajak;
    pajakController.text = nilai_pajak.toString();
    notifyListeners();
  }

  //pilih no sp
  String filter_sales = "";
  String filter_supplier = "";
  List<DropdownMenuItem<String>> dropdownList_filter_supplier;
  List data_order_pembelian_list = [];

  Future<void> initDataPO() async {
    data_order_pembelian_list = await model_po_penerimaan()
        .select_po_penerimaan_aktif(
            searchController.text,
            filter_sales,
            filter_supplier,
            tanggal_awal + " 00:00:00",
            tanggal_akhir + " 23:59:59");
    notifyListeners();
  }

  void initFilterSupplier() async {
    dropdownList_filter_supplier = [];
    dropdownList_filter_supplier
        .add(DropdownMenuItem(value: "", child: Text("Pilih Supplier")));
    List data_salesList = await model_sales().data_sales("");
    for (int i = 0; i < data_salesList.length; i++) {
      dropdownList_filter_supplier.add(DropdownMenuItem(
          value: data_salesList[i]['KODES'],
          child: Text(
              data_salesList[i]['KODES'] + "~" + data_salesList[i]['NAMAS'])));
    }
    filter_supplier = dropdownList_filter_supplier[0].value;
  }

  Future<void> importDataFromPO(var data_po) async {
    noSpController.text = data_po['NO_BUKTI'].toString();
    supplierController.text = data_po['KODES'].toString();
    namas = data_po['NAMAS'].toString();
    hari = data_po['KLB2'].toString();
    pajak = data_po['GOLO'].toString() == "P1" ? 10.00 : 0.00;
    List data_detail_po = await model_po_penerimaan()
        .select_po_penerimaan_detail(data_po['NO_BUKTI']);
    data_barang_keranjang = [];
    for (int i = 0; i < data_detail_po.length; i++) {
      DataBarang m_brg = DataBarang(
        id: int.parse(data_detail_po[i]['ID']),
        kd_brg: data_detail_po[i]['KD_BRG'],
        na_brg: data_detail_po[i]['NA_BRG'],
        harga_beli: double.parse(data_detail_po[i]['harga']),
        satuan: data_detail_po[i]['ket_uk'],
        stok_booking: double.parse(data_detail_po[i]['qty']),
      );
      data_barang_keranjang.add(m_brg);
    }
    hitungSubTotal();
    pajakController.text =
        data_po['GOLO'].toString() == "P1" ? nilai_pajak.toString() : "0.00";
  }
}
