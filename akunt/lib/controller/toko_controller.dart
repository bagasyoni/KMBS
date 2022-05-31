import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_toko.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TokoController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_tokoList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_toko m_toko = model_toko();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_toko() async {
    data_tokoList = await model_toko().data_tokocari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_tokoList = await model_toko().data_modal_toko(cari);
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
    data_tokoList = await m_toko.data_tokopaginate(
        searchController.text, offset, limit);
    var count = await m_toko.countTokoPaginate(searchController.text);
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

  void modalDataToko(String cari) async {
    data_tokoList = await model_toko().data_modal_toko(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_tokoList = await model_toko().cari_toko(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah toko
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController telponController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("dd/MM/yyyy");

  Future<void> init_edit_toko(var data_currency) async {
    kodeController.text = data_currency['KODE'];
    namaController.text = data_currency['NAMA'];
    alamatController.text = data_currency['ALAMAT'];
    kotaController.text = data_currency['KOTA'];
    telponController.text = data_currency['TELPON'];
    usrnmController.text = data_currency['USRNM'];
    tg_smpController.text = data_currency['TG_SMP'];
    notifyListeners();
  }

  void resetField() {
    kodeController.clear();
    namaController.clear();
    alamatController.clear();
    kotaController.clear();
    telponController.clear();
    usrnmController.clear();
    tg_smpController.clear();
  }

  Future<bool> daftar_toko() async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KODE'] = kodeController.text;
        data_insert['NAMA'] = namaController.text;
        data_insert['ALAMAT'] = alamatController.text;
        data_insert['KOTA'] = kotaController.text;
        data_insert['TELPON'] = telponController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_toko().insert_data_toko(data_insert);
        Toast("Success !!", "Berhasil menambah toko !", true);
        ambil_toko();
        BotToast.closeAllLoading();
        return true;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi kode !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama !", false);
      return false;
    }
  }

  Future<bool> edit_toko(var id) async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODE'] = kodeController.text;
        data_insert['NAMA'] = namaController.text;
        data_insert['ALAMAT'] = alamatController.text;
        data_insert['KOTA'] = kotaController.text;
        data_insert['TELPON'] = telponController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_toko().update_data_toko_by_id(data_insert);
        ambil_toko();
        Toast("Success !!", "Berhasil Mengedit Toko !", true);
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
    await model_toko().delete_toko_byID(data['NO_ID'].toString());
    selectData("");
  }
}
