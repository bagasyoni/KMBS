import 'package:bot_toast/bot_toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/model_gudang.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';

class GudangController with ChangeNotifier {
  ///oaginate
  bool proses = false;
  List data_gudangList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_gudang m_gudang = model_gudang();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProsess(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_gudang() async {
    data_gudangList = await model_gudang().data_gudangcari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_gudangList = await model_gudang().data_gudangcari(cari);
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
    data_gudangList = await m_gudang.data_gudangpaginate(
        searchController.text, offset, limit);
    var count = await m_gudang.countGudangPaginate(searchController.text);
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

  Future<void> search(var cari) async {
    data_gudangList = await model_gudang().cari_gudang(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah brg
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_gudang() async {
    satuan_barang = "";
    await data_satuan_barang();
  }

  Future<void> init_edit_gudang(var data_gudang) async {
    kodeController.text = data_gudang['KODE'] ?? "";
    namaController.text = data_gudang['NAMA'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_gudang['SATUAN'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_gudang['SATUAN'].toString();
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

  Future<bool> daftar_gudang() async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        // if (satuan_barang != "") {
        BotToast.showLoading();
        List data_ready =
            await model_gudang().get_data_gudang(kodeController.text);
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
          await model_gudang().insert_data_gudang(data_insert);
          Toast('Success', 'Berhasil Menambah Gudang', true);
          ambil_gudang();
          BotToast.closeAllLoading();
          return true;
        }
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

  Future<bool> edit_gudang(var id) async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        // if (satuan_barang != "") {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODE'] = kodeController.value.text;
        data_insert['NAMA'] = namaController.value.text;
        await model_gudang().update_data_gudang_by_id(data_insert);
        ambil_gudang();
        Toast('Success', 'Berhasil Mengedit Gudang', true);
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
    await model_gudang().delete_gudang_byID(data['NO_ID'].toString());
    selectData("");
  }
}
