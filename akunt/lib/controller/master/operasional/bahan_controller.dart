import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/master/operasional/model_bahan.dart';
// import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BahanController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  ///paginate
  bool proses = false;
  List data_bahanList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_bahan m_bahan = model_bahan();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;
  String perx = '';
  String tgl = '';

  Future<void> baca_periodePrefs() async {
    tgl = DateTime.now().toString();
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_bahan() async {
    data_bahanList = await model_bahan().data_bahan_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_bahanList = await model_bahan().cari_bahan(cari);
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
    data_bahanList =
        await m_bahan.data_bahanpaginate(searchController.text, offset, limit);
    var count = await m_bahan.countbahanPaginate(searchController.text);
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
    data_bahanList = await model_bahan().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_bahanList = await model_bahan().cari_bahan(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah supplier
  TextEditingController kd_bhnController = TextEditingController();
  TextEditingController na_bhnController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController acnoController = TextEditingController();
  TextEditingController acno_nmController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_edit_bahan(var data_bahan) async {
    kd_bhnController.text = data_bahan['KD_BHN'] ?? "";
    na_bhnController.text = data_bahan['NA_BHN'] ?? "";
    satuanController.text = data_bahan['SATUAN'] ?? "";
    acnoController.text = data_bahan['ACNO'] ?? "";
    acno_nmController.text = data_bahan['ACNO_NM'] ?? "";
    usrnmController.text = data_bahan['USRNM'] ?? "";
    tg_smpController.text = data_bahan['TG_SMP'] ?? "";
    // bool cek_satuan = await model_satuan()
    //     .cek_data_satuan(data_bahan['SATUAN'].toString().toLowerCase());
    // if (cek_satuan == true) {
    //   satuan_barang = data_bahan['SATUAN'].toString();
    // } else {
    //   satuan_barang = "";
    // }
    // notifyListeners();
  }

  // Future<void> data_satuan_barang() async {
  //   dropdownList_satuan_barang = [];
  //   dropdownList_satuan_barang
  //       .add(new DropdownMenuItem(value: "", child: new Text("Pilih Satuan")));
  //   List satuanList = await model_satuan().data_satuan("");
  //   for (int i = 0; i < satuanList.length; i++) {
  //     dropdownList_satuan_barang.add(new DropdownMenuItem(
  //         value: satuanList[i]['nama_satuan'].toString().toLowerCase(),
  //         child: new Text(satuanList[i]['nama_satuan'])));
  //   }
  //   dropdownList_satuan_barang.add(new DropdownMenuItem(
  //       value: "Tambah Baru ?", child: new Text("Tambah Baru ?")));
  //   satuan_barang = dropdownList_satuan_barang[0].value;
  // }

  void resetField() {
    kd_bhnController.clear();
    na_bhnController.clear();
    satuanController.clear();
    acnoController.clear();
    acno_nmController.clear();
    usrnmController.clear();
    tg_smpController.clear();
  }

  Future<bool> daftar_bahan() async {
    if (kd_bhnController.text.isNotEmpty) {
      if (na_bhnController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KD_BHN'] = kd_bhnController.text;
        data_insert['NA_BHN'] = na_bhnController.text;
        data_insert['SATUAN'] = satuanController.text;
        data_insert['ACNO'] = acnoController.text;
        data_insert['ACNO_NM'] = acno_nmController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_bahan().insert_data_bahan(data_insert);
        Toast("Success !!", "Berhasil menambah bahan !", true);
        ambil_bahan();
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode bahan !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama bahan !", false);
      return false;
    }
  }

  Future<bool> edit_bahan(var id) async {
    if (kd_bhnController.text.isNotEmpty) {
      if (na_bhnController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KD_BHN'] = kd_bhnController.text;
        data_insert['NA_BHN'] = na_bhnController.text;
        data_insert['SATUAN'] = satuanController.text;
        data_insert['ACNO'] = acnoController.text;
        data_insert['ACNO_NM'] = acno_nmController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_bahan().update_data_bahan_by_id(data_insert);
        ambil_bahan();
        Toast("Success !!", "Berhasil Mengedit Bahan !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode bahan !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama bahan !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_bahan().delete_bahan_byID(data['NO_ID'].toString());
    selectData("");
  }
}
