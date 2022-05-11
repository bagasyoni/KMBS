import 'package:bot_toast/bot_toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/model_emkl.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';

class EmklController with ChangeNotifier {
  bool proses = false;
  List data_emklList = [];
  model_emkl m_emkl = model_emkl();
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  List poList = [];
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_emkl() async {
    data_emklList = await model_emkl().data_emklcari('');
    proses = false;
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
    data_emklList =
        await m_emkl.data_emklpaginate(searchController.text, offset, limit);
    var count = await m_emkl.countEmklPaginate(searchController.text);
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

  void selectData(String cari) async {
    data_emklList = await model_emkl().data_emklcari(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_emklList = await model_emkl().cari_emkl(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah emkl
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_emkl() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_emkl(var data_emkl) async {
    kodeController.text = data_emkl['KODE'] ?? "";
    namaController.text = data_emkl['NAMA'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_emkl['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_emkl['SATUAN'].toString();
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
    kodeController.clear();
    namaController.clear();
  }

  Future<bool> daftar_emkl() async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        // if (satuan_barang != "") {
        BotToast.showLoading();
        List data_ready = await model_emkl().get_data_emkl(kodeController.text);
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "Kode Gudang '${kodeController.text}' sudah ada !", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map data_insert = new Map();
          data_insert['NO_ID'] = null;
          data_insert['KODE'] = kodeController.value.text;
          data_insert['NAMA'] = namaController.value.text;
          await model_emkl().insert_data_emkl(data_insert);
          Toast('Success', 'Berhasil Menambah Emkl', true);
          ambil_emkl();
          BotToast.closeAllLoading();
          return true;
        }
        // } else {
        //   Toast("Peringatan !", "Silahkan isi satuan barang !", false);
        //   return false;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi nama emkl !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi kode emkl !", false);
      return false;
    }
  }

  Future<bool> edit_emkl(var id) async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        // if (satuan_barang != "") {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODE'] = kodeController.value.text;
        data_insert['NAMA'] = namaController.value.text;
        await model_emkl().update_data_emkl_by_id(data_insert);
        ambil_emkl();
        Toast('Success', 'Berhasil Mengedit Emkl', true);
        BotToast.closeAllLoading();
        return true;
        // } else {
        //   Toast("Peringatan !", "Silahkan isi satuan barang !", false);
        //   return false;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi nama gudang !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi kode gudang !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_emkl().delete_emkl_byID(data['NO_ID'].toString());
    selectData("");
  }
}
