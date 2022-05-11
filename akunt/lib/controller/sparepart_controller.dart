import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_sparepart.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SparepartController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_sparepartList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_sparepart m_sparepart = model_sparepart();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_sparepart() async {
    data_sparepartList = await model_sparepart().data_sparepartcari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_sparepartList = await model_sparepart().cari_sparepart(cari);
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
    data_sparepartList = await m_sparepart.data_sparepartpaginate(
        searchController.text, offset, limit);
    var count = await m_sparepart.countSparepartPaginate(searchController.text);
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
    data_sparepartList = await model_sparepart().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_sparepartList = await model_sparepart().cari_sparepart(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah
  TextEditingController kdbhnController = TextEditingController();
  TextEditingController nabhnController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_sparepart() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_sparepart(var data_sparepart) async {
    kdbhnController.text = data_sparepart['KD_BHN'] ?? "";
    nabhnController.text = data_sparepart['NA_BHN'] ?? "";
    satuanController.text = data_sparepart['SATUAN'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_sparepart['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_sparepart['SATUAN'].toString();
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

  void resetField() {
    kdbhnController.clear();
    nabhnController.clear();
    satuanController.clear();
  }

  Future<bool> daftar_sparepart() async {
    if (kdbhnController.text.isNotEmpty) {
      if (nabhnController.text.isNotEmpty) {
        BotToast.showLoading();
        List data_ready =
            await model_sparepart().data_sparepartcari(kdbhnController.text);
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "Kode barang '${kdbhnController.text}' sudah ada !", false);
          Map data_insert = new Map();
          data_insert['NO_ID'] = null;
          data_insert['KD_BHN'] = kdbhnController.text;
          data_insert['NA_BHN'] = nabhnController.text;
          data_insert['SATUAN'] = satuanController.text;
          await model_sparepart().insert_data_sparepart(data_insert);
          Toast("Success !!", "Berhasil menambah sparepart !", true);
          ambil_sparepart();
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi kode sparepart !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama sparepart !", false);
      return false;
    }
  }

  Future<bool> edit_sparepart(var id) async {
    if (kdbhnController.text.isNotEmpty) {
      if (nabhnController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KD_BHN'] = kdbhnController.text;
        data_insert['NA_BHN'] = nabhnController.text;
        data_insert['SATUAN'] = satuanController.text;
        await model_sparepart().update_data_sparepart_by_id(data_insert);
        ambil_sparepart();
        Toast("Success !!", "Berhasil Mengedit Sparepart !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode sparepart !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama sparepart !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_sparepart().delete_sparepart_byID(data['NO_ID'].toString());
    selectData("");
  }
}
