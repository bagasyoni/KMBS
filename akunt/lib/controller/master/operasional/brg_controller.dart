import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/master/operasional/model_brg.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrgController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  ///paginate
  bool proses = false;
  List data_brgList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_brg m_brg = model_brg();
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

  Future<void> ambil_barang() async {
    data_brgList = await model_brg().data_brg_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_brgList = await model_brg().cari_barang(cari);
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
    data_brgList =
        await m_brg.data_brgpaginate(searchController.text, offset, limit);
    var count = await m_brg.countBrgPaginate(searchController.text);
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
    data_brgList = await model_brg().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_brgList = await model_brg().cari_barang(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah brg
  TextEditingController kd_brgController = TextEditingController();
  TextEditingController na_brgController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController acnoController = TextEditingController();
  TextEditingController acno_nmController = TextEditingController();
  TextEditingController produkController = TextEditingController();
  TextEditingController sizController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_barang() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_barang(var data_barang) async {
    kd_brgController.text = data_barang['KD_BRG'] ?? "";
    na_brgController.text = data_barang['NA_BRG'] ?? "";
    satuanController.text = data_barang['SATUAN'] ?? "";
    acnoController.text = data_barang['ACNO'] ?? "";
    acno_nmController.text = data_barang['ACNO_NM'] ?? "";
    produkController.text = data_barang['PRODUK'] ?? "";
    sizController.text = data_barang['SIZ'] ?? "";
    warnaController.text = data_barang['WARNA'] ?? "";
    jenisController.text = data_barang['JENIS'] ?? "";
    notesController.text = data_barang['NOTES'] ?? "";
    usrnmController.text = data_barang['USRNM'] ?? "";
    tg_smpController.text = data_barang['TG_SMP'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_barang['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_barang['SATUAN'].toString();
    } else {
      satuan_barang = "";
    }
    notifyListeners();
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
    kd_brgController.clear();
    na_brgController.clear();
    satuanController.clear();
    acnoController.clear();
    acno_nmController.clear();
    produkController.clear();
    sizController.clear();
    warnaController.clear();
    jenisController.clear();
    notesController.clear();
    usrnmController.clear();
    tg_smpController.clear();
  }

  Future<bool> daftar_brg() async {
    if (kd_brgController.text.isNotEmpty) {
      if (na_brgController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KD_BRG'] = kd_brgController.text;
        data_insert['NA_BRG'] = na_brgController.text;
        data_insert['SATUAN'] = satuanController.text;
        data_insert['ACNO'] = acnoController.text;
        data_insert['ACNO_NM'] = acno_nmController.text;
        data_insert['PRODUK'] = produkController.text;
        data_insert['SIZ'] = sizController.text;
        data_insert['WARNA'] = warnaController.text;
        data_insert['JENIS'] = jenisController.text;
        data_insert['NOTES'] = notesController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_brg().insert_data_brg(data_insert);
        Toast("Success !!", "Berhasil menambah barang !", true);
        ambil_barang();
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode barang !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama barang !", false);
      return false;
    }
  }

  Future<bool> edit_brg(var id) async {
    if (kd_brgController.text.isNotEmpty) {
      if (na_brgController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KD_BRG'] = kd_brgController.text;
        data_insert['NA_BRG'] = na_brgController.text;
        data_insert['SATUAN'] = satuanController.text;
        data_insert['ACNO'] = acnoController.text;
        data_insert['ACNO_NM'] = acno_nmController.text;
        data_insert['PRODUK'] = produkController.text;
        data_insert['SIZ'] = sizController.text;
        data_insert['WARNA'] = warnaController.text;
        data_insert['JENIS'] = jenisController.text;
        data_insert['NOTES'] = notesController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_brg().update_data_brg_by_id(data_insert);
        ambil_barang();
        Toast("Success !!", "Berhasil update barang !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode barang !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama barang !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_brg().delete_brg_byID(data['NO_ID'].toString());
    selectData("");
  }
}
