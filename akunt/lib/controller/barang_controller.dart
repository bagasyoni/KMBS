import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/data_barang.dart';
import 'package:akunt/model/model_barang.dart';
import 'package:akunt/view/base_widget/toast.dart';

class BarangController with ChangeNotifier {
  bool proses = false;
  List barangList = [];

  void setProsess(bool proses) {
    this.proses = proses;
  }

  //proses barang
  Future<void> ambil_barang() async {
    barangList = await model_barang().data_barang();
    proses = false;
    notifyListeners();
  }

  Future<void> search(var cari) async {
    barangList = await model_barang().serach_barang(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah barang
  TextEditingController kd_brg_controller = new TextEditingController();
  TextEditingController na_brg_controller = new TextEditingController();
  TextEditingController satuan_controller = new TextEditingController();
  TextEditingController stok_controller = new TextEditingController();
  TextEditingController harga_beli_controller = new TextEditingController();
  TextEditingController harga_jual_controller = new TextEditingController();

  void resetField() {
    kd_brg_controller.clear();
    na_brg_controller.clear();
    satuan_controller.clear();
    stok_controller.clear();
    harga_beli_controller.clear();
    harga_jual_controller.clear();
  }

  Future<bool> insert_barang() async {
    if (kd_brg_controller.text.isNotEmpty) {
      if (na_brg_controller.text.isNotEmpty) {
        if (satuan_controller.text.isNotEmpty) {
          BotToast.showLoading();
          List data_ready =
              await model_barang().get_data_barang(kd_brg_controller.text);
          if (data_ready.length > 0) {
            Toast("Peringatan !",
                "Kode barang '${kd_brg_controller.text}' sudah ada !", false);
            BotToast.closeAllLoading();
            return false;
          } else {
            Map data_insert = new Map();
            data_insert['kd_brg'] = kd_brg_controller.value.text;
            data_insert['na_brg'] = na_brg_controller.value.text;
            data_insert['harga_beli'] =
                double.tryParse(harga_beli_controller.value.text) ?? 0;
            data_insert['harga_jual'] =
                double.tryParse(harga_jual_controller.value.text) ?? 0;
            data_insert['satuan'] = satuan_controller.value.text;
            data_insert['stok'] =
                double.tryParse(stok_controller.value.text) ?? 0;
            await model_barang().insert_data_barang(data_insert);
            Toast('Success', 'Berhasil Menambah Barang', true);
            ambil_barang();
            BotToast.closeAllLoading();
            return true;
          }
        }
      }
    }
  }

  Future<bool> update_barang(var id) async {
    if (kd_brg_controller.text.isNotEmpty) {
      if (na_brg_controller.text.isNotEmpty) {
        if (satuan_controller.text.isNotEmpty) {
          BotToast.showLoading();
          Map data_insert = new Map();
          data_insert['id'] = id;
          data_insert['kd_brg'] = kd_brg_controller.value.text;
          data_insert['na_brg'] = na_brg_controller.value.text;
          data_insert['harga_beli'] =
              double.tryParse(harga_beli_controller.value.text) ?? 0;
          data_insert['harga_jual'] =
              double.tryParse(harga_jual_controller.value.text) ?? 0;
          data_insert['satuan'] = satuan_controller.value.text;
          data_insert['stok'] =
              double.tryParse(stok_controller.value.text) ?? 0;
          await model_barang().update_barang_by_id(data_insert);
          ambil_barang();
          Toast('Success', 'Berhasil Mengedit Barang', true);
          BotToast.closeAllLoading();
          return true;
        } else {
          Toast("Peringatan !", "Silahkan isi nama barang !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi kode barang !", false);
        return false;
      }
    }
  }

  Future<bool> hapus_barang(var data) async {
    await model_barang().delete_barang_byKode(data['kd_brg']);
    ambil_barang();
  }
}
