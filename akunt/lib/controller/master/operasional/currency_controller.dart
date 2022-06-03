import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/master/operasional/model_currency.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_currencyList = [];
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
    data_currencyList = await model_currency().data_modal_curr(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_currencyList = await model_currency().cari_currency(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah supplier
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController rate_byrController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("dd/MM/yyyy");

  Future<void> init_edit_currency(var data_currency) async {
    kodeController.text = data_currency['KODE'];
    namaController.text = data_currency['NAMA'];
    rateController.text = data_currency['Rate'].toString();
    rate_byrController.text = data_currency['Rate_BYR'].toString();
    chooseDate = DateTime.tryParse(data_currency['TGL']);
    ketController.text = data_currency['KET'];
    usrnmController.text = data_currency['USRNM'];
    tg_smpController.text = data_currency['TG_SMP'];
    notifyListeners();
  }

  void resetField() {
    kodeController.clear();
    namaController.clear();
    rateController.clear();
    rate_byrController.clear();
    tglController.clear();
    ketController.clear();
    usrnmController.clear();
    tg_smpController.clear();
    tglController.text = format_tanggal.format(chooseDate);
  }

  Future<bool> daftar_currency() async {
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KODE'] = kodeController.text;
        data_insert['NAMA'] = namaController.text;
        data_insert['RATE'] = rateController.text;
        data_insert['RATE_BYR'] = rate_byrController.text;
        data_insert['TGL'] = DateFormat("yyy-MM-dd").format(chooseDate);
        data_insert['KET'] = ketController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
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
    if (kodeController.text.isNotEmpty) {
      if (namaController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODE'] = kodeController.text;
        data_insert['NAMA'] = namaController.text;
        data_insert['RATE'] = rateController.text;
        data_insert['RATE_BYR'] = rate_byrController.text;
        data_insert['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        data_insert['KET'] = ketController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_currency().update_data_currency_by_id(data_insert);
        ambil_currency();
        Toast("Success !!", "Berhasil Mengedit currency !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode !", false);
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
