import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_currency.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_currencyList = [];
  List data_modalbankList = [];
  List data_modalkasList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_currency m_currency = model_currency();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_currency() async {
    data_currencyList = await model_currency().data_currencycari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_currencyList = await model_currency().data_modal_curr(cari);
    notifyListeners();
  }

  void selectDataModalBank(String cari) async {
    data_modalbankList = await model_currency().data_modal_bank(cari);
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
    data_currencyList = await m_currency.data_currpaginate(
        searchController.text, offset, limit);
    var count = await m_currency.countCurrPaginate(searchController.text);
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

  void modalDataCurr(String cari) async {
    data_modalkasList = await model_currency().data_modal_curr(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_currencyList = await model_currency().cari_currency(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah supplier
  TextEditingController bacnoController = TextEditingController();
  TextEditingController bnamaController = TextEditingController();
  TextEditingController nama_kelController = TextEditingController();
  TextEditingController nm_grupController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_currency() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_currency(var data_currency) async {
    bacnoController.text = data_currency['ACNO'] ?? "";
    bnamaController.text = data_currency['NAMA'] ?? "";
    nama_kelController.text = data_currency['NAMA_KEL'] ?? "";
    nm_grupController.text = data_currency['NM_GRUP'] ?? "";
    // bool cek_satuan = await model_satuan()
    //     .cek_data_satuan(data_currency['SATUAN'].toString().toLowerCase());
    // if (cek_satuan == true) {
    //   satuan_barang = data_currency['SATUAN'].toString();
    // } else {
    //   satuan_barang = "";
    // }
    notifyListeners();
  }

  void resetField() {
    bacnoController.clear();
    bnamaController.clear();
    nama_kelController.clear();
    nm_grupController.clear();
  }

  Future<bool> daftar_currency() async {
    if (bacnoController.text.isNotEmpty) {
      if (bnamaController.text.isNotEmpty) {
        BotToast.showLoading();
        List data_ready =
            await model_currency().data_currencycari(bacnoController.text);
        // if (data_ready.length > 0) {
        //   Toast("Peringatan !", "Acno '${bacnoController.text}' sudah ada !",
        //       false);
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['ACNO'] = bacnoController.text;
        data_insert['NAMA'] = bnamaController.text;
        data_insert['NAMA_KEL'] = nama_kelController.text;
        data_insert['NM_GRUP'] = nm_grupController.text;
        await model_currency().insert_data_currency(data_insert);
        Toast("Success !!", "Berhasil menambah currency !", true);
        ambil_currency();
        BotToast.closeAllLoading();
        return true;
        // }
      } else {
        Toast("Peringatan !", "Silahkan isi acno !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama !", false);
      return false;
    }
  }

  Future<bool> edit_currency(var id) async {
    if (bacnoController.text.isNotEmpty) {
      if (bnamaController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['ACNO'] = bacnoController.text;
        data_insert['NAMA'] = bnamaController.text;
        data_insert['NAMA_KEL'] = nama_kelController.text;
        data_insert['NM_GRUP'] = nm_grupController.text;
        await model_currency().update_data_currency_by_id(data_insert);
        ambil_currency();
        Toast("Success !!", "Berhasil Mengedit currency !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi acno !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_currency().delete_currency_byID(data['NO_ID'].toString());
    selectData("");
  }
}
