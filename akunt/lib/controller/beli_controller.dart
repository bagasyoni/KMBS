import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/model_beli.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

class BeliController with ChangeNotifier {
  model_beli m_beli = model_beli();
  bool proses = false;
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  List beliList = [];
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProsesss(bool proses) {
    this.proses = proses;
  }

  void ambil_beli(String cari) async {
    beliList = await model_beli().data_beli(cari);
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
    beliList =
        await m_beli.data_belipaginate(searchController.text, offset, limit);
    var count = await m_beli.countBeliPaginate(searchController.text);
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
    beliList = await model_beli().search_beli(cari);
    proses = false;
    notifyListeners();
  }

// NO_BUKTI, TGL, NO_PO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, LAIN, TOTAL, NOTES, RPRATE, RPHARGA, RPLAIN, RPTOTAL, AJU, BL, EMKL, JCONT, HARGAT, ACNOA, NACNOA, GOL
  final format_no_bukti = DateFormat("yyMM", "id_ID"); //2201
  TextEditingController nobukti_Controller = new TextEditingController();
  TextEditingController tanggal_Controller = new TextEditingController();
  TextEditingController nopo_Controller = new TextEditingController();
  TextEditingController kodes_Controller = new TextEditingController();
  TextEditingController namas_Controller = new TextEditingController();
  TextEditingController kdbrg_Controller = new TextEditingController();
  TextEditingController nabrg_Controller = new TextEditingController();
  TextEditingController kg_Controller = new TextEditingController();
  TextEditingController harga_Controller = new TextEditingController();
  TextEditingController lain_Controller = new TextEditingController();
  TextEditingController total_Controller = new TextEditingController();
  TextEditingController notes_Controller = new TextEditingController();
  TextEditingController rprate_Controller = new TextEditingController();
  TextEditingController rpharga_Controller = new TextEditingController();
  TextEditingController rplain_Controller = new TextEditingController();
  TextEditingController rptotal_Controller = new TextEditingController();
  TextEditingController aju_Controller = new TextEditingController();
  TextEditingController bl_Controller = new TextEditingController();
  TextEditingController emkl_Controller = new TextEditingController();
  TextEditingController jcont_Controller = new TextEditingController();
  TextEditingController hargat_Controller = new TextEditingController();
  TextEditingController acnoa_Controller = new TextEditingController();
  TextEditingController nacnoa_Controller = new TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  int no_urut = 0;

  void resetField() async {
    List noUrut = await model_beli().noUrutBeli("BL", "beli", "NO_BUKTI");
    if (noUrut.length > 0) {
      var obj_data = noUrut[0];
      no_urut = int.tryParse(obj_data['NOMOR'].toString());
    } else {
      no_urut = 0;
    }
    nobukti_Controller.text = "BL${format_no_bukti.format(DateTime.now())}-" +
        (no_urut + 1).toString().padLeft(4, "0");
    tanggal_Controller.text = format_tanggal.format(chooseDate);
    nopo_Controller.text = format_tanggal.format(chooseDate);
    kodes_Controller.clear();
    namas_Controller.clear();
    kdbrg_Controller.clear();
    nabrg_Controller.clear();
    kg_Controller.text = "0";
    harga_Controller.text = "0";
    lain_Controller.clear();
    total_Controller.text = "0";
    notes_Controller.clear();
    rprate_Controller.text = "0";
    rpharga_Controller.text = "0";
    rplain_Controller.text = "0";
    rptotal_Controller.text = "0";
    aju_Controller.clear();
    bl_Controller.clear();
    emkl_Controller.clear();
    jcont_Controller.text = "0";
    hargat_Controller.text = "0";
    acnoa_Controller.clear();
    nacnoa_Controller.clear();
  }

  Future<bool> insert_beli() async {
    if (nobukti_Controller.text.isNotEmpty) {
      if (nopo_Controller.text.isNotEmpty) {
        if (emkl_Controller.text.isNotEmpty) {
          BotToast.showLoading();
          Map data_insert = new Map();
          data_insert['NO_BUKTI'] = nobukti_Controller.value.text;
          data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          data_insert['NO_PO'] = nopo_Controller.value.text;
          data_insert['KODES'] = kodes_Controller.value.text;
          data_insert['NAMAS'] = namas_Controller.value.text;
          data_insert['KD_BRG'] = kdbrg_Controller.value.text;
          data_insert['NA_BRG'] = nabrg_Controller.value.text;
          data_insert['KG'] = kg_Controller.value.text;
          data_insert['HARGA'] = harga_Controller.value.text;
          data_insert['LAIN'] = lain_Controller.value.text;
          data_insert['TOTAL'] = total_Controller.value.text;
          data_insert['NOTES'] = notes_Controller.value.text;
          data_insert['RPRATE'] = rprate_Controller.value.text;
          data_insert['RPHARGA'] = rpharga_Controller.value.text;
          data_insert['RPLAIN'] = rplain_Controller.value.text;
          data_insert['RPTOTAL'] = rptotal_Controller.value.text;
          data_insert['AJU'] = aju_Controller.value.text;
          data_insert['BL'] = bl_Controller.value.text;
          data_insert['EMKL'] = emkl_Controller.value.text;
          data_insert['JCONT'] = jcont_Controller.value.text;
          data_insert['HARGAT'] = hargat_Controller.value.text;
          data_insert['ACNOA'] = acnoa_Controller.value.text;
          data_insert['NACNOA'] = nacnoa_Controller.value.text;
          await model_beli().insert_beli(data_insert);
          Toast('Success', 'Berhasil Menambah Pembelian', true);
          BotToast.closeAllLoading();
          return true;
        } else {
          Toast("Peringatan !", "Silahkan isi EMKL !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi No PO", false);
        return false;
      }
    } else {
      Toast("Peringatan", "Silahkan isi No Bukti", false);
    }
  }

  Future<bool> update_beli(var id) async {
    if (nobukti_Controller.text.isNotEmpty) {
      BotToast.showLoading();
      Map data_insert = new Map();
      data_insert['NO_ID'] = id;
      data_insert['NO_BUKTI'] = nobukti_Controller.value.text;
      data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
      data_insert['NO_PO'] = nopo_Controller.value.text;
      data_insert['KODES'] = kodes_Controller.value.text;
      data_insert['NAMAS'] = namas_Controller.value.text;
      data_insert['KD_BRG'] = kdbrg_Controller.value.text;
      data_insert['NA_BRG'] = nabrg_Controller.value.text;
      data_insert['KG'] = kg_Controller.value.text;
      data_insert['HARGA'] = harga_Controller.value.text;
      data_insert['LAIN'] = lain_Controller.value.text;
      data_insert['TOTAL'] = total_Controller.value.text;
      data_insert['NOTES'] = notes_Controller.value.text;
      data_insert['RPRATE'] = rprate_Controller.value.text;
      data_insert['RPHARGA'] = rpharga_Controller.value.text;
      data_insert['RPLAIN'] = rplain_Controller.value.text;
      data_insert['RPTOTAL'] = rptotal_Controller.value.text;
      data_insert['AJU'] = aju_Controller.value.text;
      data_insert['BL'] = bl_Controller.value.text;
      data_insert['EMKL'] = emkl_Controller.value.text;
      data_insert['JCONT'] = jcont_Controller.value.text;
      data_insert['HARGAT'] = hargat_Controller.value.text;
      data_insert['ACNOA'] = acnoa_Controller.value.text;
      data_insert['NACNOA'] = nacnoa_Controller.value.text;
      await model_beli().update_beli_by_id(data_insert);
      ambil_beli("");
      Toast("Success !!", "Berhasil Update Transaksi Pembelian !", true);
      BotToast.closeAllLoading();
      return true;
    } else {
      Toast("Peringatan !", "Silahkan isi No Bukti !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_beli().delete_beli(data['NO_ID'].toString());
    ambil_beli("");
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
