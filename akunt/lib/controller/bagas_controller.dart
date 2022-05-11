import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_bagas.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BagasController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_bagasList = [];
  List data_modalbankList = [];
  List data_modalkasList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_bagas m_bagas = model_bagas();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_bagas() async {
    data_bagasList = await model_bagas().data_bagascari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_bagasList = await model_bagas().cari_bagas(cari);
    notifyListeners();
  }

  // void selectDataModalKas(String cari) async {
  //   data_bagasList = await model_bagas().data_modal_kas(cari);
  //   notifyListeners();
  // }

  // void selectDataModalBank(String cari) async {
  //   data_modalbankList = await model_bagas().data_modal_bank(cari);
  //   notifyListeners();
  // }

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
    data_bagasList =
        await m_bagas.data_bagaspaginate(searchController.text, offset, limit);
    var count = await m_bagas.countBagasPaginate(searchController.text);
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

  // void modalDataKas(String cari) async {
  //   data_modalkasList = await model_bagas().data_modal_kas(cari);
  //   notifyListeners();
  // }

  // void modalDataBank(String cari) async {
  //   data_modalbankList = await model_bagas().data_modal_bank(cari);
  //   notifyListeners();
  // }

  Future<void> search(var cari) async {
    data_bagasList = await model_bagas().cari_bagas(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah supplier
  TextEditingController kd_bgsController = TextEditingController();
  TextEditingController na_bgsController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_bagas() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_bagas(var data_bagas) async {
    kd_bgsController.text = data_bagas['KD_BGS'] ?? "";
    na_bgsController.text = data_bagas['NA_BGS'] ?? "";
    satuanController.text = data_bagas['SATUAN'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_bagas['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_bagas['SATUAN'].toString();
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
    kd_bgsController.clear();
    na_bgsController.clear();
    satuanController.clear();
  }

  Future<bool> daftar_bagas() async {
    if (kd_bgsController.text.isNotEmpty) {
      if (na_bgsController.text.isNotEmpty) {
        BotToast.showLoading();
        List data_ready =
            await model_bagas().data_bagascari(kd_bgsController.text);
        // if (data_ready.length > 0) {
        //   Toast("Peringatan !", "Acno '${kd_bgsController.text}' sudah ada !",
        //       false);
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KD_BGS'] = kd_bgsController.text;
        data_insert['NA_BGS'] = na_bgsController.text;
        data_insert['SATUAN'] = satuanController.text;
        await model_bagas().insert_data_bagas(data_insert);
        Toast("Success !!", "Berhasil menambah data !", true);
        ambil_bagas();
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

  Future<bool> edit_bagas(var id) async {
    if (kd_bgsController.text.isNotEmpty) {
      if (na_bgsController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KD_BGS'] = kd_bgsController.text;
        data_insert['NA_BGS'] = na_bgsController.text;
        data_insert['SATUAN'] = satuanController.text;
        await model_bagas().update_data_bagas_by_id(data_insert);
        ambil_bagas();
        Toast("Success !!", "Berhasil Mengedit data !", true);
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
    await model_bagas().delete_bagas_byID(data['NO_ID'].toString());
    selectData("");
  }
}
