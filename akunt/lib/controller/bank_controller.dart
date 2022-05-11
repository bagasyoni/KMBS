import 'package:akunt/model/model_satuan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_bank.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class BankController with ChangeNotifier {
  //paginate
  bool proses = false;
  List data_bankList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_bank m_bank = model_bank();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_bank() async {
    data_bankList = await model_bank().data_bank_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_bankList = await model_bank().cari_bank(cari);
    notifyListeners();
  }

  void modalData(String cari) async {
    data_bankList = await model_bank().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_bankList = await model_bank().cari_bank(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah bank
  TextEditingController kdbankController = TextEditingController();
  TextEditingController nabankController = TextEditingController();

  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_bank() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_bank(var data_bank) async {
    kdbankController.text = data_bank['KD_BANK'] ?? "";
    nabankController.text = data_bank['NA_BANK'] ?? "";

    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_bank['KOTA'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_bank['KOTA'].toString();
    } else {
      satuan_barang = "";
    }
    notifyListeners();
  }

  void resetField() {
    kdbankController.clear();
    nabankController.clear();
  }

  Future<bool> daftar_bank() async {
    if (kdbankController.text.isNotEmpty) {
      if (nabankController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KD_BANK'] = kdbankController.text;
        data_insert['NA_BANK'] = nabankController.text;

        await model_bank().insert_data_bank(data_insert);
        Toast("Success !!", "Berhasil menambah bank !", true);
        ambil_bank();
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode bank !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama bank !", false);
      return false;
    }
  }

  Future<bool> edit_bank(var id) async {
    if (kdbankController.text.isNotEmpty) {
      if (nabankController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KD_BANK'] = kdbankController.text;
        data_insert['NA_BANK'] = nabankController.text;

        await model_bank().update_data_bank_by_id(data_insert);
        ambil_bank();
        Toast("Success !!", "Berhasil Mengedit Bank !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode bank !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama bank !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_bank().delete_bank_byID(data['NO_ID'].toString());
    selectData("");
  }
}
