import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_thutsparepart.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThutsparepartController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_thutsparepart_list = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_thutsparepart m_thutsparepart = model_thutsparepart();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_thutsparepart() async {
    data_thutsparepart_list =
        await model_thutsparepart().data_thutsparepart_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_thutsparepart_list =
        await model_thutsparepart().cari_thutsparepart(cari);
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
    data_thutsparepart_list = await m_thutsparepart.data_thutsparepart_paginate(
        searchController.text, offset, limit);
    var count = await m_thutsparepart
        .count_thutsparepart_Paginate(searchController.text);
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
    data_thutsparepart_list =
        await model_thutsparepart().data_modal_thutsparepart(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_thutsparepart_list =
        await model_thutsparepart().data_thutsparepart_tampil(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah hutang sparepart
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController nobeliController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController drController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  String satuan_barang = "";
  int no_urut = 0;
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_thutsparepart() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_thutsparepart(var data_hutsparepart) async {
    nobuktiController.text = data_hutsparepart['NO_BUKTI'] ?? "";
    tglController.text = data_hutsparepart['TGL'] ?? "";
    nobeliController.text = data_hutsparepart['NO_BELI'] ?? "";
    kodesController.text = data_hutsparepart['KODES'] ?? "";
    namasController.text = data_hutsparepart['NAMAS'] ?? "";
    drController.text = data_hutsparepart['DR'] ?? "";
    totalController.text = data_hutsparepart['TOTAL'].toString() ?? 0.00;
    notesController.text = data_hutsparepart['NOTES'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_hutsparepart['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_hutsparepart['SATUAN'].toString();
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
    nobeliController.clear();
    kodesController.clear();
    namasController.clear();
    drController.clear();
    totalController.clear();
    notesController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    await m_thutsparepart
        .countBukti(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "THUT${format_no_bukti.format(DateTime.now())}SP-${no_urut + 1}";
      }
    });
  }

  Future<bool> daftar_thutsparepart() async {
    if (nobuktiController.text.isNotEmpty) {
      if (namasController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['NO_BUKTI'] = nobuktiController.text;
        data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        data_insert['NO_BELI'] = nobeliController.text;
        data_insert['KODES'] = kodesController.text;
        data_insert['NAMAS'] = namasController.text;
        data_insert['DR'] = drController.text;
        data_insert['TOTAL'] = totalController.text;
        data_insert['NOTES'] = notesController.text;
        await model_thutsparepart().insert_data_thutsparepart(data_insert);
        Toast("Success !!", "Berhasil menambah hutang sparepart !", true);
        ambil_thutsparepart();
        BotToast.closeAllLoading();
        return true;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi kode sparepart !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama supplier !", false);
      return false;
    }
  }

  Future<bool> edit_thutsparepart(var id) async {
    if (kodesController.text.isNotEmpty) {
      if (namasController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['NO_BUKTI'] = nobuktiController.text;
        data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        data_insert['NO_BELI'] = nobeliController.text;
        data_insert['KODES'] = kodesController.text;
        data_insert['NAMAS'] = namasController.text;
        data_insert['DR'] = drController.text;
        data_insert['TOTAL'] = totalController.text;
        data_insert['NOTES'] = notesController.text;
        await model_thutsparepart()
            .update_data_thutsparepart_by_id(data_insert);
        ambil_thutsparepart();
        Toast("Success !!", "Berhasil Mengedit Transaksi Hutang Sparepart !",
            true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode supplier !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama supplier !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_thutsparepart()
        .delete_thutsparepart_byID(data['NO_ID'].toString());
    selectData("");
  }
}
