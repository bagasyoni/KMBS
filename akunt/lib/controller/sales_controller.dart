import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_sales.dart';
import 'package:akunt/view/base_widget/toast.dart';

class SalesController with ChangeNotifier {
  List data_salesList = new List();

  void selectData(String cari) async {
    data_salesList = await model_sales().data_sales(cari);
    notifyListeners();
  }

  //variable tambah sales
  TextEditingController keteranganController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  void resetField() {
    namaController.clear();
    keteranganController.clear();
    hpController.clear();
    alamatController.clear();
  }

  Future<bool> daftar_sales() async {
    if (namaController.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      data_insert['id'] = null;
      data_insert['nama'] = namaController.text;
      data_insert['alamat'] = alamatController.text;
      data_insert['no_tlp'] = hpController.text;
      data_insert['password'] = "";
      data_insert['keterangan'] = keteranganController.text;
      await model_sales().insert_data_sales(data_insert);
      Toast("Success !!", "Berhasil menambah sales !", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan isi nama sales !", false);
      return false;
    }
  }

  Future<bool> edit_sales(var id) async {
    if (namaController.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      data_insert['id'] = id;
      data_insert['nama'] = namaController.text;
      data_insert['alamat'] = alamatController.text;
      data_insert['no_tlp'] = hpController.text;
      data_insert['password'] = "";
      data_insert['keterangan'] = keteranganController.text;
      await model_sales().update_data_sales_by_id(data_insert);
      Toast("Success !!", "Berhasil mengedit sales !", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan isi nama sales !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_sales().delete_sales_byID(data['id'].toString());
    selectData("");
  }
}
