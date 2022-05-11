import 'package:akunt/model/model_satuan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_periode.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PeriodeController with ChangeNotifier {
  //paginate
  bool proses = false;
  List data_periodeList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_periode m_periode = model_periode();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_periode() async {
    data_periodeList = await model_periode().data_periode_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_periodeList = await model_periode().cari_periode(cari);
    notifyListeners();
  }

  void modalData(String cari) async {
    data_periodeList = await model_periode().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_periodeList = await model_periode().cari_periode(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah periode
  TextEditingController periodeController = TextEditingController();
  TextEditingController yerController = TextEditingController();

  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_bank() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_periode(var data_periode) async {
    periodeController.text = data_periode['PERIOD'] ?? "";
    yerController.text = data_periode['YER'] ?? "";

    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_periode['KOTA'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_periode['KOTA'].toString();
    } else {
      satuan_barang = "";
    }
    notifyListeners();
  }

  void resetField() {
    periodeController.clear();
    yerController.clear();
  }

  Future<bool> daftar_periode() async {
    if (periodeController.text.isNotEmpty) {
      if (yerController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['PERIOD'] = periodeController.text;
        data_insert['YER'] = yerController.text;

        await model_periode().insert_data_periode(data_insert);
        Toast("Success !!", "Berhasil menambah periode !", true);
        ambil_periode();
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode periode !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama periode !", false);
      return false;
    }
  }

  Future<bool> edit_periode(var id) async {
    if (periodeController.text.isNotEmpty) {
      if (yerController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['PERIOD'] = periodeController.text;
        data_insert['YER'] = yerController.text;

        await model_periode().update_data_periode_by_id(data_insert);
        ambil_periode();
        Toast("Success !!", "Berhasil Mengedit Periode !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode periode !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama periode !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_periode().delete_periode_byID(data['NO_ID'].toString());
    selectData("");
  }
}
