import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_thutnonbahan.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThutnonbahanController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_thutnonbahan_list = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_thutnonbahan m_thutnonbahan = model_thutnonbahan();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_thutnonbahan() async {
    data_thutnonbahan_list =
        await model_thutnonbahan().data_thutnonbahan_cari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_thutnonbahan_list = await model_thutnonbahan().cari_thutnonbahan(cari);
    notifyListeners();
  }

  ///paginate
  Future<void> initData() async {
    c_page.text = '1';
    limitPaging();
    await selectDataPaginate(true);
    // initFilterSupplier();
  }

  ///paginate
  Future<void> selectDataPaginate(bool reload) async {
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    data_thutnonbahan_list = await m_thutnonbahan.data_thutnonbahan_paginate(
        searchController.text, offset, limit);
    var count =
        await m_thutnonbahan.count_thutnonbahan_Paginate(searchController.text);
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
    data_thutnonbahan_list =
        await model_thutnonbahan().data_modal_thutnonbahan(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_thutnonbahan_list = await model_thutnonbahan().cari_thutnonbahan(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah hutang bahan
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

  Future<void> init_add_thutbahan() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_thutnonbahan(var data_hutbahan) async {
    nobuktiController.text = data_hutbahan['NO_BUKTI'] ?? "";
    tglController.text = data_hutbahan['TGL'] ?? "";
    nobeliController.text = data_hutbahan['NO_BELI'] ?? "";
    kodesController.text = data_hutbahan['KODES'] ?? "";
    namasController.text = data_hutbahan['NAMAS'] ?? "";
    drController.text = data_hutbahan['DR'] ?? "";
    totalController.text = data_hutbahan['TOTAL'].toString() ?? 0.00;
    notesController.text = data_hutbahan['NOTES'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_hutbahan['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_hutbahan['SATUAN'].toString();
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
    await m_thutnonbahan
        .countBukti(format_created_at2.format(DateTime.now()))
        .then((value) {
      if (value != null) {
        if (value.length > 0) {
          no_urut = value.length;
        } else {
          no_urut = 0;
        }
        nobuktiController.text =
            "THUT${format_no_bukti.format(DateTime.now())}NB-${no_urut + 1}";
      }
    });
  }

  Future<bool> daftar_thutnonbahan() async {
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
        await model_thutnonbahan().insert_data_thutnonbahan(data_insert);
        Toast("Success !!", "Berhasil menambah hutang non bahan !", true);
        ambil_thutnonbahan();
        BotToast.closeAllLoading();
        return true;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi kode bahan !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama supplier !", false);
      return false;
    }
  }

  Future<bool> edit_thutnonbahan(var id) async {
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
        await model_thutnonbahan().update_data_thutnonbahan_by_id(data_insert);
        ambil_thutnonbahan();
        Toast("Success !!", "Berhasil Mengedit Transaksi Hutang Bahan !", true);
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
    await model_thutnonbahan()
        .delete_thutnonbahan_byID(data['NO_ID'].toString());
    selectData("");
  }
}
