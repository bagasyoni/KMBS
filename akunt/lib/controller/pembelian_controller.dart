// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';
// import 'package:akunt/model/model_pembelian.dart';
// import 'package:akunt/view/base_widget/toast.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class BeliController with ChangeNotifier {
//   model_beli m_beli = model_beli();
//   bool proses = false;
//   List beliList = [];

//   void setProsesss(bool proses) {
//     this.proses = proses;
//   }

//   void ambil_beli(String cari) async {
//     beliList = await model_beli().data_beli(cari);
//     proses = false;
//     notifyListeners();
//   }

//   Future<void> search(var cari) async {
//     beliList = await model_beli().search_beli(cari);
//     proses = false;
//     notifyListeners();
//   }

//   final format_no_bukti = DateFormat("yyMM", "id_ID"); //2201
//   TextEditingController nobukti_Controller = new TextEditingController();
//   TextEditingController tanggal_Controller = new TextEditingController();
//   TextEditingController nopo_Controller = new TextEditingController();
//   TextEditingController kodes_Controller = new TextEditingController();
//   TextEditingController namas_Controller = new TextEditingController();
//   TextEditingController kdbrg_Controller = new TextEditingController();
//   TextEditingController nabrg_Controller = new TextEditingController();
//   TextEditingController kg_Controller = new TextEditingController();
//   TextEditingController harga_Controller = new TextEditingController();
//   TextEditingController lain_Controller = new TextEditingController();
//   TextEditingController total_Controller = new TextEditingController();
//   TextEditingController notes_Controller = new TextEditingController();
//   TextEditingController rprate_Controller = new TextEditingController();
//   TextEditingController rpharga_Controller = new TextEditingController();
//   TextEditingController rpharga_Controller = new TextEditingController();
//   TextEditingController rptotal_Controller = new TextEditingController();
//   DateTime chooseDate = DateTime.now();
//   final format_tanggal = new DateFormat("d-M-y");
//   int no_urut = 0;

//   void resetField() async {
//     List noUrut = await model_po().noUrutPo("PO", "po", "NO_PO");
//     if (noUrut.length > 0) {
//       var obj_data = noUrut[0];
//       no_urut = int.tryParse(obj_data['NOMOR'].toString());
//     } else {
//       no_urut = 0;
//     }
//     nopo_Controller.text = "PO${format_no_bukti.format(DateTime.now())}-" +
//         (no_urut + 1).toString().padLeft(4, "0");
//     tanggal_Controller.text = format_tanggal.format(chooseDate);
//     jtempo_Controller.text = format_tanggal.format(chooseDate);
//     kodes_Controller.clear();
//     namas_Controller.clear();
//     kdbrg_Controller.clear();
//     nabrg_Controller.clear();
//     kg_Controller.text = "0";
//     harga_Controller.text = "0";
//     total_Controller.text = "0";
//     notes_Controller.clear();
//     rprate_Controller.text = "0";
//     rpharga_Controller.text = "0";
//     rptotal_Controller.text = "0";
//   }

//   Future<bool> insert_po() async {
//     if (nopo_Controller.text.isNotEmpty) {
//       if (kodes_Controller.text.isNotEmpty) {
//         if (kdbrg_Controller.text.isNotEmpty) {
//           BotToast.showLoading();
//           Map data_insert = new Map();
//           data_insert['NO_PO'] = nopo_Controller.value.text;
//           data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
//           data_insert['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDate);
//           data_insert['KODES'] = kodes_Controller.value.text;
//           data_insert['NAMAS'] = namas_Controller.value.text;
//           data_insert['KD_BRG'] = kdbrg_Controller.value.text;
//           data_insert['NA_BRG'] = nabrg_Controller.value.text;
//           data_insert['KG'] = kg_Controller.value.text;
//           data_insert['HARGA'] = harga_Controller.value.text;
//           data_insert['TOTAL'] = total_Controller.value.text;
//           data_insert['NOTES'] = notes_Controller.value.text;
//           data_insert['RPRATE'] = rprate_Controller.value.text;
//           data_insert['RPHARGA'] = rpharga_Controller.value.text;
//           data_insert['RPTOTAL'] = rptotal_Controller.value.text;
//           await model_po().insert_po(data_insert);
//           Toast('Success', 'Berhasil Menambah PO', true);
//           BotToast.closeAllLoading();
//           return true;
//         } else {
//           Toast("Peringatan !", "Silahkan isi No PO !", false);
//           return false;
//         }
//       } else {
//         Toast("Peringatan !", "Silahkan isi Kode Supplier", false);
//         return false;
//       }
//     } else {
//       Toast("Peringatan", "Silahkan isi Kode Barang", false);
//     }
//   }

//   Future<bool> update_po(var id) async {
//     if (nopo_Controller.text.isNotEmpty) {
//       BotToast.showLoading();
//       Map data_insert = new Map();
//       data_insert['NO_ID'] = id;
//       data_insert['NO_PO'] = nopo_Controller.value.text;
//       data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
//       data_insert['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDate);
//       data_insert['KODES'] = kodes_Controller.value.text;
//       data_insert['NAMAS'] = namas_Controller.value.text;
//       data_insert['KD_BRG'] = kdbrg_Controller.value.text;
//       data_insert['NA_BRG'] = nabrg_Controller.value.text;
//       data_insert['KG'] = kg_Controller.value.text;
//       data_insert['HARGA'] = harga_Controller.value.text;
//       data_insert['TOTAL'] = total_Controller.value.text;
//       data_insert['NOTES'] = notes_Controller.value.text;
//       data_insert['RPRATE'] = rprate_Controller.value.text;
//       data_insert['RPHARGA'] = rpharga_Controller.value.text;
//       data_insert['RPTOTAL'] = rptotal_Controller.value.text;
//       await model_po().update_po_by_id(data_insert);
//       ambil_po("");
//       Toast("Success !!", "Berhasil Update Po !", true);
//       BotToast.closeAllLoading();
//       return true;
//     } else {
//       Toast("Peringatan !", "Silahkan isi No PO !", false);
//       return false;
//     }
//   }

//   Future<bool> hapus_akun(var data) async {
//     await model_po().delete_po(data['NO_ID'].toString());
//     ambil_po("");
//   }

//   void hitungTotal() {
//     double total = 0;
//     double qty = double.parse(kg_Controller.value.text);
//     double harga = double.parse(harga_Controller.value.text);
//     total = qty * harga;
//     total_Controller.text = total.toString();
//     notifyListeners();
//   }
// }
