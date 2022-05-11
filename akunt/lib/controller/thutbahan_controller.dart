import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_thutbahan.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThutbahanController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  bool proses = false;
  List data_thutbahan_list = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_thutbahan m_thutbahan = model_thutbahan();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;
  String perx = '';
  double total = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_thutbahan() async {
    data_thutbahan_list = await model_thutbahan().data_thutbahan_tampil('');
    proses = false;
    total = 0;
    for (int i = 0; i < data_thutbahan_list.length; i++) {
      total += double.parse(data_thutbahan_list[i]['TOTAL'].toString());
    }
    notifyListeners();
  }

  void selectData(String cari) async {
    data_thutbahan_list = await model_thutbahan().cari_thutbahan(cari);
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
    data_thutbahan_list = await m_thutbahan.data_thutbahan_paginate(
        searchController.text, offset, limit);
    var count =
        await m_thutbahan.count_thutbahan_Paginate(searchController.text);
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

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  void modalData(String cari) async {
    data_thutbahan_list = await model_thutbahan().data_modal_thutbahan(cari);
    await baca_periodePrefs();
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_thutbahan_list = await model_thutbahan().data_thutbahan_tampil(cari);
    proses = false;
    await baca_periodePrefs();
    notifyListeners();
  }

  //variable tambah hutang bahan
  TextEditingController nobuktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController nobeliController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
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
    await baca_periodePrefs();
  }

  Future<void> init_edit_thutbahan(var data_hutbahan) async {
    nobuktiController.text = data_hutbahan['NO_BUKTI'] ?? "";
    tglController.text = data_hutbahan['TGL'] ?? "";
    nobeliController.text = data_hutbahan['NO_BELI'] ?? "";
    kodesController.text = data_hutbahan['KODES'] ?? "";
    namasController.text = data_hutbahan['NAMAS'] ?? "";
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
    totalController.clear();
    notesController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    await m_thutbahan.get_no_bukti('THUT', 'NO_BUKTI', 'beli').then((value) {
      if (value != null) {
        nobuktiController.text =
            "THUT${format_no_bukti.format(DateTime.now())}BH-${value[0]['NOMOR']}";
      }
    });
  }

  Future<bool> daftar_thutbahan() async {
    if (nobuktiController.text.isNotEmpty) {
      if (namasController.text.isNotEmpty) {
        BotToast.showLoading();
        var data_ready = await m_thutbahan.check_no_bukti(
            nobuktiController.text, "NO_BUKTI", "beli");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${nobuktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map data_insert = new Map();
          data_insert['NO_ID'] = null;
          data_insert['NO_BUKTI'] = nobuktiController.text;
          data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          data_insert['NO_BELI'] = nobeliController.text;
          data_insert['KODES'] = kodesController.text;
          data_insert['NAMAS'] = namasController.text;
          data_insert['TOTAL'] = totalController.text;
          data_insert['NOTES'] = notesController.text;
          data_insert['PER'] = perx;
          await model_thutbahan().insert_data_thutbahan(data_insert);
          Toast(
              "Success !!", "Berhasil menambah transaksi hutang bahan !", true);
          ambil_thutbahan();
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi kode bahan !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama bahan !", false);
      return false;
    }
  }

  Future<bool> edit_thutbahan(var id) async {
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
        data_insert['TOTAL'] = totalController.text;
        data_insert['NOTES'] = notesController.text;
        data_insert['PER'] = perx;
        await model_thutbahan().update_data_thutbahan_by_id(data_insert);
        ambil_thutbahan();
        Toast("Success !!", "Berhasil Mengedit Transaksi Hutang Bahan !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_thutbahan()
        .delete_thutbahan_byID(data['NO_ID'].toString(), data['NO_BUKTI']);
    selectData("");
  }
}
