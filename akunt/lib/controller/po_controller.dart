import 'dart:math';

import 'package:akunt/model/model_po.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/invoice/invoice_order_pembelian.dart';
import 'package:akunt/model/master/operasional/model_brg.dart';
import 'package:akunt/model/model_order_pembelian.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/master/operasional/model_supplier.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PoController with ChangeNotifier {
  model_order_pembelian m_order = model_order_pembelian();
  TextEditingController searchController = TextEditingController();
  TextEditingController filterTanggalController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_order_pembelian_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  int index_terpilih;
  String filter_supplier = "";
  String kodes = "";
  List<DropdownMenuItem<String>> dropdownList_supplier;
  List data_excel_bySupplier = new List();

  Future<void> select_data() async {
    data_order_pembelian_list = await m_order.select_order_pembelian(
        searchController.text, tanggal_awal, tanggal_akhir, kodes);
    notifyListeners();
  }

  void selectData(String cari) async {
    data_order_pembelian_list = await model_po().data_po(cari);
    notifyListeners();
  }

  void filterSupplier() async {
    List data_supplierList = await model_supplier().data_supplier_tampil("");
    dropdownList_supplier = new List();
    dropdownList_supplier.add(
        new DropdownMenuItem(value: "", child: new Text("Pilih Supplier")));
    for (int i = 0; i < data_supplierList.length; i++) {
      dropdownList_supplier.add(new DropdownMenuItem(
          value: data_supplierList[i]['KODES'],
          child: new Text(data_supplierList[i]['KODES'])));
    }
    filter_supplier = dropdownList_supplier[0].value;
  }

  void initData() {
    index_terpilih = null;
    tanggal_awal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggal_akhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('yyyy/MM/dd', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('yyyy/MM/dd', "id_ID").format(DateTime.now()).toString();
    filterTanggalController.text = range;
    select_data();
    filterSupplier();
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
    if (data_order_pembelian_list.length > 0) {
      BotToast.showLoading();
      List header_excel = new List();
      List isi_excel = new List();
      header_excel.add("Tanggal");
      header_excel.add("No bukti");
      header_excel.add("Sales");
      header_excel.add("Supplier");
      header_excel.add("keterangan");
      header_excel.add("Qty");
      header_excel.add("Total");
      header_excel.add("Status");
      for (int i = 0; i < data_order_pembelian_list.length; i++) {
        Map<String, dynamic> isi_map = new Map<String, dynamic>();
        isi_map['a'] = data_order_pembelian_list[i]['tanggal'];
        isi_map['b'] = data_order_pembelian_list[i]['no_bukti'];
        isi_map['c'] = data_order_pembelian_list[i]['sales'];
        isi_map['d'] = data_order_pembelian_list[i]['supplier'];
        isi_map['e'] = data_order_pembelian_list[i]['keterangan'];
        isi_map['f'] = data_order_pembelian_list[i]['total_qty'];
        isi_map['g'] = data_order_pembelian_list[i]['total_po'];
        if (data_order_pembelian_list[i]['status'] == 1) {
          isi_map['h'] = "Aktif";
        } else {
          isi_map['h'] = "Tidak Aktif";
        }
        isi_excel.add(isi_map);
      }
      String judul = "Laporan Order Pembelian (${range.replaceAll("/", "")})";
      config().createExcel(header_excel, isi_excel, judul);
    } else {
      Toast("Tidak ada data untuk di export", "", false);
    }
  }

  // Future<void> proses_export_detail() async {
  //   if (index_terpilih != null) {
  //     BotToast.showLoading();
  //     List header_excel = new List();
  //     List header_detail_excel = new List();
  //     List isi_excel = new List();
  //     List isi_detail_excel = new List();
  //     List footer_excel = new List();
  //     header_excel.add("Tanggal");
  //     header_excel.add("No bukti");
  //     header_excel.add("Sales");
  //     header_excel.add("Supplier");
  //     header_excel.add("keterangan");
  //     header_excel.add("Status");
  //     Map<String, dynamic> map_transaksi = new Map<String, dynamic>();
  //     map_transaksi['a'] = data_order_pembelian_list[index_terpilih]['tanggal'];
  //     map_transaksi['b'] =
  //         data_order_pembelian_list[index_terpilih]['no_bukti'];
  //     map_transaksi['c'] = data_order_pembelian_list[index_terpilih]['sales'];
  //     map_transaksi['d'] =
  //         data_order_pembelian_list[index_terpilih]['supplier'];
  //     map_transaksi['e'] =
  //         data_order_pembelian_list[index_terpilih]['keterangan'];
  //     if (data_order_pembelian_list[index_terpilih]['status'] == 1) {
  //       map_transaksi['f'] = "Aktif";
  //     } else {
  //       map_transaksi['f'] = "Tidak Aktif";
  //     }
  //     isi_excel.add(map_transaksi);

  //     header_detail_excel.add("Kode Barang");
  //     header_detail_excel.add("Nama Barang");
  //     header_detail_excel.add("Satuan");
  //     header_detail_excel.add("Qty");
  //     header_detail_excel.add("Harga");
  //     header_detail_excel.add("SubTotal");
  //     List data_barang = await m_order.select_order_pembelian_detail(
  //         data_order_pembelian_list[index_terpilih]['no_bukti']);
  //     for (int i = 0; i < data_barang.length; i++) {
  //       Map<String, dynamic> isi_map = new Map<String, dynamic>();
  //       isi_map['a'] = data_barang[i]['kd_brg'];
  //       isi_map['b'] = data_barang[i]['na_brg'];
  //       isi_map['c'] = data_barang[i]['satuan'];
  //       isi_map['d'] = data_barang[i]['qty'];
  //       isi_map['e'] = data_barang[i]['harga_po'];
  //       isi_map['f'] = data_barang[i]['sub_total'];
  //       isi_detail_excel.add(isi_map);
  //     }
  //     footer_excel.add("");
  //     footer_excel.add("");
  //     footer_excel.add("Jumlah");
  //     footer_excel.add(data_order_pembelian_list[index_terpilih]['total_qty']);
  //     footer_excel.add("Total");
  //     footer_excel.add(data_order_pembelian_list[index_terpilih]['total_po']);
  //     String judul =
  //         "Invoice Order Pembelian (${data_order_pembelian_list[index_terpilih]['no_bukti']})";
  //     config().createExcel2(header_excel, header_detail_excel, isi_excel,
  //         isi_detail_excel, footer_excel, judul);
  //   } else {
  //     Toast("Silahkan pilih 1 invoice untuk di download !", "", false);
  //   }
  // }

  // Future<void> proses_to_export_screen(BuildContext context) async {
  //   data_excel_bySupplier.clear();
  //   if (filter_supplier.isNotEmpty) {
  //     if (data_order_pembelian_list.length > 0) {
  //       BotToast.showLoading();
  //       for (int i = 0; i < data_order_pembelian_list.length; i++) {
  //         List data_barang = await m_order.select_order_pembelian_detail(
  //             data_order_pembelian_list[i]['no_bukti']);
  //         for (int j = 0; j < data_barang.length; j++) {
  //           Map<String, dynamic> isi_map = new Map<String, dynamic>();
  //           isi_map['a'] = data_order_pembelian_list[i]['tanggal'];
  //           isi_map['b'] = data_order_pembelian_list[i]['no_bukti'];
  //           isi_map['c'] = data_order_pembelian_list[i]['sales'];
  //           isi_map['d'] = data_barang[j]['kd_brg'];
  //           isi_map['e'] = data_barang[j]['na_brg'];
  //           isi_map['f'] = data_barang[j]['qty'];
  //           isi_map['g'] = data_barang[j]['satuan'];
  //           isi_map['h'] = data_barang[j]['harga_po'];
  //           isi_map['i'] = data_barang[j]['sub_total'];
  //           data_excel_bySupplier.add(isi_map);
  //         }
  //       }
  //       BotToast.closeAllLoading();
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (_) => ExportBySupplierScreen(filter_supplier)));
  //     } else {
  //       Toast("Tidak ada data untuk di export", "", false);
  //     }
  //   } else {
  //     Toast("Belum ada supplier yang terpilih",
  //         "Silahkan filter laporan berdasarkan supplier tertentu !", false);
  //   }
  // }

  // Future<void> proses_export_perSupplier(int mode) async {
  //   if (filter_supplier.isNotEmpty) {
  //     if (data_order_pembelian_list.length > 0) {
  //       BotToast.showLoading();
  //       List header_excel = new List();
  //       List isi_excel = new List();
  //       header_excel.add("Tanggal");
  //       header_excel.add("No bukti");
  //       header_excel.add("Sales");
  //       header_excel.add("Kode Barang");
  //       header_excel.add("Nama Barang");
  //       header_excel.add("Satuan");
  //       header_excel.add("Qty");
  //       header_excel.add("Harga PO");
  //       header_excel.add("SubTotal");
  //       for (int i = 0; i < data_order_pembelian_list.length; i++) {
  //           Map<String, dynamic> isi_map = new Map<String, dynamic>();
  //           if (j == 0) {
  //             isi_map['a'] = data_order_pembelian_list[i]['tanggal'];
  //             isi_map['b'] = data_order_pembelian_list[i]['no_bukti'];
  //             isi_map['c'] = data_order_pembelian_list[i]['sales'];
  //           } else {
  //             isi_map['a'] = "";
  //             isi_map['b'] = "";
  //             isi_map['c'] = "";
  //           }
  //           isi_map['d'] = data_barang[j]['kd_brg'];
  //           isi_map['e'] = data_barang[j]['na_brg'];
  //           isi_map['f'] = data_barang[j]['satuan'];
  //           isi_map['g'] = data_barang[j]['qty'];
  //           isi_map['h'] = data_barang[j]['harga_po'];
  //           isi_map['i'] = data_barang[j]['sub_total'];
  //           isi_excel.add(isi_map);
  //         }
  //       }
  //       String judul =
  //           "Laporan Order Pembelian By $filter_supplier(${range.replaceAll("/", "")})";
  //       String header_title = "Dari Supplier : $filter_supplier";
  //       if (mode == 0) {
  //         config().createExcel3(header_excel, isi_excel, header_title, judul);
  //       } else {
  //         ExportPDF(header_excel, isi_excel, judul);
  //       }
  //     } else {
  //       Toast("Tidak ada data untuk di export", "", false);
  //     }
  //   } else {
  //     Toast("Belum ada supplier yang terpilih",
  //         "Silahkan filter laporan berdasarkan supplier tertentu !", false);
  //   }
  // }

  Future<void> proses_print() async {
    List data_barang = await m_order.select_order_pembelian_detail(
        data_order_pembelian_list[index_terpilih]['NO_BUKTI'],
        "NO_BUKTI",
        "po");
    InvoiceOrderPembelian()
        .proses_print(data_order_pembelian_list[index_terpilih], data_barang);
  }

  //add order pembelian
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  final format_tanggal = new DateFormat("EEEE, d MMMM yyyy", "id_ID");
  final format_created_at = new DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = new DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = new DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataBrg> data_brg_keranjang = new List<DataBrg>();
  double sumQty = 0;
  double sumTotal = 0;
  int no_urut = 0;
  List<DataBrg> brgList = new List<DataBrg>();
  bool status_po = true;
  double total_used = 0;

  Future<void> initData_addPo() async {
    data_brg_keranjang = new List<DataBrg>();
    nobuktiController.clear();
    tanggalController.text = format_tanggal.format(chooseDate);
    kodesController.clear();
    namasController.clear();
    keteranganController.clear();
    sumQty = 0;
    sumTotal = 0;
    total_used = 0;
    await m_order
        .countOrderPembelian(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "PO${format_no_bukti.format(DateTime.now())}-${no_urut + 1}";
      }
    });
    await model_brg().data_brg_tampil('').then((value) {
      if (value != null) {
        brgList.clear();
        for (int i = 0; i < value.length; i++) {
          brgList.add(new DataBrg.fromJson(value[i]));
        }
      }
    });
  }

  Future<void> initData_editPo(var data_edit) async {
    nobuktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tanggalController.text = format_tanggal.format(chooseDate);
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    keteranganController.text = data_edit['KET'];
    // chooseDate = new DateFormat("yyyy-MM-dd").parse(data_edit['TGL']);
    // tanggalController.text = format_tanggal.format(chooseDate);
    // total_used = data_edit['total_used'];
    List data_lama = await m_order.select_order_pembelian_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "pod");
    data_brg_keranjang = new List<DataBrg>();

    for (int i = 0; i < data_lama.length; i++) {
      DataBrg m_brg = DataBrg(
        noid: data_lama[i]['NO_ID'],
        kd_brg: data_lama[i]['KD_BRG'],
        na_brg: data_lama[i]['NA_BRG'],
        harga: double.parse(data_lama[i]['HARGA'].toString()) ?? 0.00,
        qty: double.parse(data_lama[i]['QTY'].toString()) ?? 0.00,
        total: double.parse(data_lama[i]['TOTAL'].toString()) ?? 0.00,
      );
      data_brg_keranjang.add(m_brg);
    }
    hitungSubTotal();
    await model_brg().cari_barang("").then((value) {
      if (value != null) {
        brgList.clear();
        for (int i = 0; i < value.length; i++) {
          brgList.add(new DataBrg.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataBrg m_barang) {
    data_brg_keranjang.add(m_barang);
    sumQty += 1;
    sumTotal += m_barang.total ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_brg_keranjang.length; i++) {
      sumTotal += data_brg_keranjang[i].total ?? 0.00;
    }
    notifyListeners();
  }

  Future<bool> savePO() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_order.get_no_bukti(nobuktiController.text);
        // print(data_ready.length);
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${nobuktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['TGL'] = format_created_at.format(chooseDate);
          obj['NO_BUKTI'] = nobuktiController.text;
          obj['KODES'] = kodesController.text;
          obj['NAMAS'] = namasController.text;
          obj['KETERANGAN'] = keteranganController.text;
          obj['TOTAL'] = sumTotal;
          obj['TABELD'] = await baca_barang();
          await m_order.insert_order_pembelian(obj);
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

  Future<bool> editPO() async {
    hitungSubTotal();
    if (nobuktiController.text.isNotEmpty) {
      if (data_brg_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = nobuktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['KODES'] = kodesController.text;
        obj['NAMAS'] = namasController.text;
        obj['KET'] = keteranganController.text;
        obj['TOTAL'] = sumTotal;
        obj['TABLED'] = await baca_barang();
        await m_order.update_order_pembelian(obj);
        BotToast.closeAllLoading();
        Toast("Success !", "Berhasil mengedit data", true);
        return true;
      } else {
        Toast("Peringatan !", "Belum ada data barang yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> deletePO(String no_bukti) async {
    try {
      var delete = await m_order.delete_order_penjualan(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List> baca_barang() async {
    List barangList = [];
    for (int i = 0; i < data_brg_keranjang.length; i++) {
      double qty = data_brg_keranjang[i].qty;
      double harga = data_brg_keranjang[i].harga;
      double subTotal = harga * qty;
      Map obj = new Map();
      obj['KD_BRG'] = data_brg_keranjang[i].kd_brg;
      obj['NA_BRG'] = data_brg_keranjang[i].na_brg;
      obj['HARGA'] = data_brg_keranjang[i].harga;
      obj['QTY'] = qty ?? 0.00;
      obj['TOTAL'] = harga ?? 0.00;
      barangList.add(obj);
    }
    return barangList;
  }
}
