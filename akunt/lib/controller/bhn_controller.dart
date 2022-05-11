import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/model_bhn.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';

class BhnController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_bhnList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_bhn m_bhn = model_bhn();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProsess(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_bahan() async {
    data_bhnList = await model_bhn().data_bhncari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_bhnList = await model_bhn().data_bhncari(cari);
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
    data_bhnList =
        await m_bhn.data_bhnpaginate(searchController.text, offset, limit);
    var count = await m_bhn.countBhnPaginate(searchController.text);
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
    data_bhnList = await model_bhn().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_bhnList = await model_bhn().cari_bahan(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah bhn
  TextEditingController kdbhnController = TextEditingController();
  TextEditingController nabhnController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");

  void resetField() {
    kdbhnController.clear();
    nabhnController.clear();
    satuanController.clear();
    hargaController.clear();
  }

  Future<bool> tambah_bhn() async {
    if (kdbhnController.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      data_insert['NO_ID'] = null;
      data_insert['KD_BHN'] = kdbhnController.text;
      data_insert['NA_BHN'] = nabhnController.text;
      data_insert['SATUAN'] = satuanController.text;
      data_insert['HARGA'] = hargaController.text;
      await model_bhn().insert_data_bhn(data_insert);
      Toast("Success !!", "Berhasil menambah bahan !!", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan lengkapi semua data !", false);
      return false;
    }
  }

  Future<bool> edit_bhn(var id) async {
    if (kdbhnController.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      // chooseDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(id['tanggal']);
      data_insert['NO_ID'] = id;
      data_insert['KD_BHN'] = kdbhnController.text;
      data_insert['NA_BHN'] = nabhnController.text;
      data_insert['SATUAN'] = satuanController.text;
      data_insert['HARGA'] = hargaController.text;
      await model_bhn().update_data_bhn_by_id(data_insert);
      Toast("Success !!", "Berhasil mengedit bahan !", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan lengkapi semua data !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_bhn().delete_bhn_byID(data['NO_ID'].toString());
    selectData("");
  }
}
