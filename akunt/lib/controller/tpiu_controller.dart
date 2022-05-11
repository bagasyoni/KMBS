import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_tpiu.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TpiuController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_tpiu_list = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_tpiu m_tpiu = model_tpiu();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_tpiu() async {
    data_tpiu_list = await model_tpiu().data_tpiu_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_tpiu_list = await model_tpiu().cari_tpiu(cari);
    notifyListeners();
  }

  ///paginate
  Future<void> initData() async {
    c_page.text = '1';
    limitPaging();
    await selectDataPaginate(true);
  }

  ///paginate
  Future<void> selectDataPaginate(bool reload) async {
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    data_tpiu_list =
        await m_tpiu.data_tpiu_paginate(searchController.text, offset, limit);
    var count = await m_tpiu.count_tpiu_Paginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  ///paginate
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

  void modalData(String cari) async {
    data_tpiu_list = await model_tpiu().data_modal_tpiu(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_tpiu_list = await model_tpiu().data_tpiu_tampil(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah hutang bahan
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController nojualController = TextEditingController();
  TextEditingController kodecController = TextEditingController();
  TextEditingController namacController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  String satuan_barang = "";
  int no_urut = 0;
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_tpiu() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_tpiu(var data_tpiu) async {
    nobuktiController.text = data_tpiu['NO_BUKTI'] ?? "";
    tglController.text = data_tpiu['TGL'] ?? "";
    nojualController.text = data_tpiu['NO_JUAL'] ?? "";
    kodecController.text = data_tpiu['KODEC'] ?? "";
    namacController.text = data_tpiu['NAMAC'] ?? "";
    totalController.text = data_tpiu['TOTAL'].toString() ?? 0.00;
    notesController.text = data_tpiu['NOTES'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_tpiu['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_tpiu['SATUAN'].toString();
    } else {
      satuan_barang = "";
    }
    notifyListeners();
  }

  Future<void> data_satuan_barang() async {
    dropdownList_satuan_barang = [];
    dropdownList_satuan_barang
        .add(new DropdownMenuItem(value: "", child: new Text("Pilih Satuan")));
    List satuanList = await model_satuan().data_satuan("");
    for (int i = 0; i < satuanList.length; i++) {
      dropdownList_satuan_barang.add(new DropdownMenuItem(
          value: satuanList[i]['nama_satuan'].toString().toLowerCase(),
          child: new Text(satuanList[i]['nama_satuan'])));
    }
    dropdownList_satuan_barang.add(new DropdownMenuItem(
        value: "Tambah Baru ?", child: new Text("Tambah Baru ?")));
    satuan_barang = dropdownList_satuan_barang[0].value;
  }

  Future<void> resetField() async {
    nobuktiController.clear();
    tglController.clear();
    nojualController.clear();
    kodecController.clear();
    namacController.clear();
    totalController.clear();
    notesController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    await m_tpiu
        .countBukti(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "TPIU${format_no_bukti.format(DateTime.now())}BR-${no_urut + 1}";
      }
    });
  }

  Future<bool> daftar_tpiu() async {
    if (nobuktiController.text.isNotEmpty) {
      if (namacController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['NO_BUKTI'] = nobuktiController.text;
        data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        data_insert['NO_JUAL'] = nojualController.text;
        data_insert['KODEC'] = kodecController.text;
        data_insert['NAMAC'] = namacController.text;
        data_insert['TOTAL'] = totalController.text;
        data_insert['NOTES'] = notesController.text;
        await model_tpiu().insert_data_tpiu(data_insert);
        Toast("Success !!", "Berhasil menambah transaksi piutang !", true);
        ambil_tpiu();
        BotToast.closeAllLoading();
        return true;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi kode customer !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama customer !", false);
      return false;
    }
  }

  Future<bool> edit_tpiu(var id) async {
    if (kodecController.text.isNotEmpty) {
      if (namacController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['NO_BUKTI'] = nobuktiController.text;
        data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        data_insert['NO_JUAL'] = nojualController.text;
        data_insert['KODEC'] = kodecController.text;
        data_insert['NAMAC'] = namacController.text;
        data_insert['TOTAL'] = totalController.text;
        data_insert['NOTES'] = notesController.text;
        await model_tpiu().update_data_tpiu_by_id(data_insert);
        ambil_tpiu();
        Toast("Success !!", "Berhasil Mengedit Transaksi Piutang !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode customer !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama customer !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_tpiu().delete_tpiu_byID(data['NO_ID'].toString());
    selectData("");
  }
}
