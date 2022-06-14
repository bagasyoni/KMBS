import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/master/finansial/model_account.dart';
import 'package:akunt/model/master/finansial/data_account.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/transaksi/finansial/model_kasmasuk.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_controller.dart';

class KasmController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_kasm m_kasm = model_kasm();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_kasm_list = [];
  static List home_kasm_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  double total = 0;
  double qty = 0;
  double disc = 0;
  double disc1 = 0;
  double ppn = 0;
  double ppn1 = 0;
  double pph = 0;
  double pph1 = 0;
  int index_terpilih;
  TextEditingController c_page = new TextEditingController();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

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

  ///paginate
  Future<void> selectDataPaginate(bool reload) async {
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    data_kasm_list =
        await m_kasm.data_kasmpaginate(searchController.text, offset, limit);
    home_kasm_list =
        await m_kasm.data_kasmpaginate(searchController.text, offset, limit);
    var count = await m_kasm.countKasmPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_kasm_list = await model_kasm().data_modal(cari);
    home_kasm_list = await model_kasm().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_kasm_list = await m_kasm.select_kasm(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    home_kasm_list = await m_kasm.select_kasm(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    notifyListeners();
  }

  void selectData(String cari) async {
    data_kasm_list = await model_kasm().cari_kasm(cari);
    home_kasm_list = await model_kasm().cari_kasm(cari);
    await baca_periodePrefs();
    notifyListeners();
  }

  void initData() {
    c_page.text = '1';
    limitPaging();
    selectDataPaginate(true);
    index_terpilih = null;
    tanggal_awal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggal_akhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString();
    baca_periodePrefs();
    select_data();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value != null) {
      if (args.value is PickerDateRange) {
        if (args.value.startDate != null) {
          range = DateFormat('dd/MM/yyyy', "id_ID")
                  .format(args.value.startDate)
                  .toString() +
              ' - ' +
              DateFormat('dd/MM/yyyy', "id_ID")
                  .format(args.value.endDate ?? args.value.startDate)
                  .toString();
        }
        if (args.value.startDate != null && args.value.endDate != null) {
          tanggal_awal = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.startDate)
              .toString();
          tanggal_akhir = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.endDate)
              .toString();
          isEnable_button = true;
        } else {
          isEnable_button = false;
        }
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
        isEnable_button = false;
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
        isEnable_button = false;
      } else {
        rangeCount = args.value.length.toString();
        isEnable_button = false;
      }
      notifyListeners();
    }
  }

  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController bacnoController = TextEditingController();
  TextEditingController bnamaController = TextEditingController();
  TextEditingController currController = TextEditingController();
  TextEditingController currnmController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController perController = TextEditingController();
  TextEditingController jumlah1Controller = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController usrinController = TextEditingController();
  TextEditingController tg_inController = TextEditingController();
  TextEditingController umController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataAccount> data_account_keranjang = List<DataAccount>();
  double sumQty = 0;
  double sumTotal = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataAccount> accountList = List<DataAccount>();

  Future<void> initData_addKasm() async {
    data_account_keranjang = new List<DataAccount>();
    no_buktiController.clear();
    tanggalController.clear();
    typeController.clear();
    bacnoController.clear();
    bnamaController.clear();
    currController.clear();
    currnmController.clear();
    rateController.clear();
    kodeController.clear();
    namaController.clear();
    ketController.clear();
    perController.clear();
    jumlah1Controller.clear();
    jumlahController.clear();
    usrinController.clear();
    tg_inController.clear();
    umController.clear();
    flagController.clear();
    tanggalController.text = format_tanggal.format(chooseDate);
    sumQty = 0;
    sumTotal = 0;
    await baca_periodePrefs();
    await m_kasm.get_no_bukti('KM', 'NO_BUKTI', 'kas').then((value) {
      if (value != null) {
        no_buktiController.text =
            "KM${format_no_bukti.format(DateTime.now())}/${value[0]['NOMOR']}";
      }
    });
    await model_account().cari_account("").then((value) {
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
  }

  Future<void> initData_editKasm(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tanggalController.text = format_tanggal.format(chooseDate);
    typeController.text = data_edit['TYPE'];
    bacnoController.text = data_edit['BACNO'];
    bnamaController.text = data_edit['BNAMA'];
    currController.text = data_edit['CURR'];
    currnmController.text = data_edit['CURRNM'];
    rateController.text = data_edit['RATE'];
    kodeController.text = data_edit['KODE'];
    namaController.text = data_edit['NAMA'];
    ketController.text = data_edit['KET'];
    perController.text = data_edit['PER'];
    jumlah1Controller.text = data_edit['JUMLAH1'];
    jumlahController.text = data_edit['JUMLAH'];
    usrinController.text = data_edit['USRIN'];
    tg_inController.text = data_edit['TG_IN'];
    umController.text = data_edit['UM'];
    flagController.text = data_edit['FLAG'];
    List data_lama = await m_kasm.select_kasm_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "kasd");
    data_account_keranjang = new List<DataAccount>();

    for (int i = 0; i < data_lama.length; i++) {
      DataAccount mAccount = DataAccount(
        noid: data_lama[i]['NO_ID'],
        acno: data_lama[i]['ACNO'],
        nacno: data_lama[i]['NACNO'],
        no_faktur: data_lama[i]['NO_FAKTUR'],
        reff: data_lama[i]['URAIAN'],
        jumlahinv: double.parse(data_lama[i]['JUMLAHINV'].toString()) ?? 0.00,
        jumlah: double.parse(data_lama[i]['JUMLAH'].toString()) ?? 0.00,
        jumlah1: double.parse(data_lama[i]['JUMLAH1'].toString()) ?? 0.00,
        um: double.parse(data_lama[i]['UM'].toString()) ?? 0.00,
        currd: double.parse(data_lama[i]['CURRD'].toString()) ?? 0.00,
        rated: double.parse(data_lama[i]['RATED'].toString()) ?? 0.00,
        noinv: data_lama[i]['NOINV'],
      );
      data_account_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_account().data_accountcari("").then((value) {
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataAccount mAccount) {
    data_account_keranjang.add(mAccount);
    sumQty += 1;
    sumTotal += mAccount.jumlah ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    for (int i = 0; i < data_account_keranjang.length; i++) {
      sumTotal += data_account_keranjang[i].jumlah ?? 0.00;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveKasm() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_kasm.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "kas");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['TYPE'] = "BKM";
          obj['BACNO'] = bacnoController.text;
          obj['BNAMA'] = bnamaController.text;
          obj['CURR'] = currController.text;
          obj['CURRNM'] = currnmController.text;
          obj['RATE'] = rateController.text;
          obj['KODE'] = kodeController.text;
          obj['NAMA'] = namaController.text;
          obj['KET'] = ketController.text;
          obj['PER'] = perx;
          obj['JUMLAH1'] = "0.00";
          obj['JUMLAH'] = "0.00";
          obj['USRIN'] = LoginController.nama_staff;
          obj['TG_IN'] = DateTime.now();
          obj['UM'] = "0.00";
          obj['FLAG'] = "K";
          obj['tabeld'] = await baca_tabeld();
          await m_kasm.insert_kasm(obj);
          BotToast.closeAllLoading();
          return true;
        }
      } else {
        Toast("Peringatan !", "Belum ada detil Transaksi yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> editKasm() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['TYPE'] = "BKM";
          obj['BACNO'] = bacnoController.text;
          obj['BNAMA'] = bnamaController.text;
          obj['CURR'] = currController.text;
          obj['CURRNM'] = currnmController.text;
          obj['RATE'] = rateController.text;
          obj['KODE'] = kodeController.text;
          obj['NAMA'] = namaController.text;
          obj['KET'] = ketController.text;
          obj['PER'] = perx;
          obj['JUMLAH1'] = "0.00";
          obj['JUMLAH'] = "0.00";
          obj['USRIN'] = LoginController.nama_staff;
          obj['TG_IN'] = DateTime.now();
          obj['UM'] = "0.00";
          obj['FLAG'] = "K";
          obj['tabeld'] = await baca_tabeld();
        await m_kasm.update_kasm(obj);
        BotToast.closeAllLoading();
        Toast("Success !", "Berhasil mengedit data", true);
        return true;
      } else {
        Toast("Peringatan !", "Belum ada detil Transaksi yang di input", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "No. bukti wajib di isi !", false);
      return false;
    }
  }

  Future<bool> deleteKasm(String no_bukti) async {
    try {
      var delete = await m_kasm.delete_kasm(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List accountList = [];
    for (int i = 0; i < data_account_keranjang.length; i++) {
      double jumlahinv = data_account_keranjang[i].jumlah;
      double jumlah = data_account_keranjang[i].jumlah;
      double jumlah1 = data_account_keranjang[i].jumlah;
      double um = data_account_keranjang[i].jumlah;
      double currd = data_account_keranjang[i].jumlah;
      double rated = data_account_keranjang[i].jumlah;
      Map obj = new Map();
      obj['ACNO'] = data_account_keranjang[i].acno;
      obj['NACNO'] = data_account_keranjang[i].nacno;
      obj['NO_FAKTUR'] = data_account_keranjang[i].reff;
      obj['URAIAN'] = data_account_keranjang[i].reff;
      obj['JUMLAHINV'] = jumlahinv ?? 0.00;
      obj['JUMLAH'] = jumlah ?? 0.00;
      obj['JUMLAH1'] = jumlah1 ?? 0.00;
      obj['UM'] = um ?? 0.00;
      obj['CURRD'] = currd ?? 0.00;
      obj['RATED'] = rated ?? 0.00;
      accountList.add(obj);
    }
    return accountList;
  }
}
