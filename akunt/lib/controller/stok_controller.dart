import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/model_stok.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StokController with ChangeNotifier {
  model_stok m_stok = model_stok();
  bool proses = false;
  List stokList = [];

  void setProsess(bool proses) {
    this.proses = proses;
  }

  //proses account
  void ambil_stok(String cari) async {
    stokList = await model_stok().data_stok(cari);
    proses = false;
    notifyListeners();
  }

  Future<void> search(var cari) async {
    stokList = await model_stok().serach_stok(cari);
    proses = false;
    notifyListeners();
  }

  // //variable tambah koreksi stok
  final format_no_bukti = DateFormat("yyMM", "id_ID"); //2201
  TextEditingController nobukti_Controller = new TextEditingController();
  TextEditingController tanggal_Controller = new TextEditingController();
  TextEditingController kdbrg_Controller = new TextEditingController();
  TextEditingController nabrg_Controller = new TextEditingController();
  TextEditingController kg_Controller = new TextEditingController();
  TextEditingController notes_Controller = new TextEditingController();
  TextEditingController harga_Controller = new TextEditingController();
  TextEditingController total_Controller = new TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  int no_urut = 0;
  // final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  // final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  // final format_no_bukti = DateFormat("yyMM", "id_ID");

  void resetField() async {
    List noUrut = await model_stok().noUrutKoreksiStok("KS", "stock", "NO_BUKTI");
    if (noUrut.length > 0) {
      var obj_data = noUrut[0];
      no_urut = int.tryParse(obj_data['NOMOR'].toString());
    } else {
      no_urut = 0;
    }
    nobukti_Controller.text = "KS${format_no_bukti.format(DateTime.now())}-" +
        (no_urut + 1).toString().padLeft(4, "0");
    tanggal_Controller.text = format_tanggal.format(chooseDate);
    kdbrg_Controller.clear();
    nabrg_Controller.clear();
    kg_Controller.text = "0";
    notes_Controller.clear();
    harga_Controller.text = "0";
    total_Controller.text = "0";
  }

  Future<bool> insert_stok() async {
    if (nobukti_Controller.text.isNotEmpty) {
      if (tanggal_Controller.text.isNotEmpty) {
        if (kdbrg_Controller.text.isNotEmpty) {
          BotToast.showLoading();
          // List data_ready =
          //     await model_stok().get_data_stok(nobukti_Controller.text);
          // if (data_ready.length > 0) {
          //   Toast("Peringatan !",
          //       "Nomer '${nobukti_Controller.text}' sudah ada !", false);
          //   BotToast.closeAllLoading();
          //   return false;
          // } else {
          Map data_insert = new Map();
          data_insert['NO_BUKTI'] = nobukti_Controller.value.text;
          data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          data_insert['KD_BRG'] = kdbrg_Controller.value.text;
          data_insert['NA_BRG'] = nabrg_Controller.value.text;
          data_insert['KG'] = kg_Controller.value.text;
          data_insert['NOTES'] = notes_Controller.value.text;
          data_insert['HARGA'] = harga_Controller.value.text;
          data_insert['TOTAL'] = total_Controller.value.text;
          // print(data_insert);
          await model_stok().insert_stok(data_insert);
          Toast('Success', 'Berhasil Menambah stok', true);
          BotToast.closeAllLoading();
          return true;
        } else {
          Toast("Peringatan !", "Silahkan isi nama account !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi kode account !", false);
        return false;
      }
    }
  }

  Future<bool> update_stok(var id) async {
    if (kdbrg_Controller.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      data_insert['NO_ID'] = id;
      data_insert['NO_BUKTI'] = nobukti_Controller.value.text;
      data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
      data_insert['KD_BRG'] = kdbrg_Controller.value.text;
      data_insert['NA_BRG'] = nabrg_Controller.value.text;
      data_insert['KG'] = kg_Controller.value.text;
      data_insert['NOTES'] = notes_Controller.value.text;
      data_insert['HARGA'] = harga_Controller.value.text;
      data_insert['TOTAL'] = total_Controller.value.text;
      await model_stok().update_stok_by_id(data_insert);
      ambil_stok("");
      Toast("Success !!", "Berhasil Update Koreksi Stok !", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan isi kode barang !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_stok().delete_stok(data['NO_BUKTI'].toString());
    ambil_stok("");
  }

  void hitungTotal() {
    double total = 0;
    double qty = double.parse(kg_Controller.value.text);
    double harga = double.parse(harga_Controller.value.text);
    total = qty * harga;
    total_Controller.text = total.toString();
    notifyListeners();
  }
}
