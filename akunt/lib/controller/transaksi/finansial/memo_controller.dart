import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/transaksi/finansial/model_memo.dart';
import 'package:akunt/model/master/finansial/data_account.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_controller.dart';

class MemoController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_memo m_memo = model_memo();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_memo_list = [];
  static List home_memo_list = [];
  bool isEnable_button = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String perx = '';
  String rangeCount = '';
  String tanggal_awal = "";
  String tanggal_akhir = "";
  double jumlah = 0;
  double jumlah1 = 0;
  double debet = 0;
  double kredit = 0;
  double debetrp = 0;
  double kreditrp = 0;
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
    data_memo_list =
        await m_memo.data_memopaginate(searchController.text, offset, limit);
    home_memo_list =
        await m_memo.data_memopaginate(searchController.text, offset, limit);
    var count = await m_memo.countMemoPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_memo_list = await model_memo().data_modal(cari);
    home_memo_list = await model_memo().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_memo_list = await m_memo.select_memo(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    home_memo_list = await m_memo.select_memo(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    notifyListeners();
  }

  void selectData(String cari) async {
    data_memo_list = await model_memo().cari_memo(cari);
    home_memo_list = await model_memo().cari_memo(cari);
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
  TextEditingController ketController = TextEditingController();
  TextEditingController perController = TextEditingController();
  TextEditingController debetController = TextEditingController();
  TextEditingController kreditController = TextEditingController();
  TextEditingController debet1Controller = TextEditingController();
  TextEditingController kredit1Controller = TextEditingController();
  TextEditingController usrinController = TextEditingController();
  TextEditingController tg_inController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  String tanggal;
  List<DataAccount> data_account_keranjang = List<DataAccount>();
  double sumJumlah = 0;
  double sumJumlahRp = 0;
  double sumDebet = 0;
  double sumKredit = 0;
  double sumDebetRp = 0;
  double sumKreditRp = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataAccount> accountList = List<DataAccount>();

  Future<void> initData_addMemo() async {
    data_account_keranjang = new List<DataAccount>();
    no_buktiController.clear();
    tanggalController.clear();
    typeController.clear();
    bacnoController.clear();
    bnamaController.clear();
    currController.clear();
    currnmController.clear();
    rateController.clear();
    ketController.clear();
    perController.clear();
    debetController.clear();
    kreditController.clear();
    debet1Controller.clear();
    kredit1Controller.clear();
    usrinController.clear();
    tg_inController.clear();
    flagController.clear();
    tanggalController.text = format_tanggal.format(chooseDate);
    sumJumlah = 0;
    sumDebet = 0;
    sumKredit = 0;
    sumDebetRp = 0;
    sumKreditRp = 0;
    sumJumlahRp = 0;
    await baca_periodePrefs();
    await m_memo
        .get_no_bukti(
            'MM${format_no_bukti.format(DateTime.now())}', 'NO_BUKTI', 'memo')
        .then((value) {
      if (value != null) {
        no_buktiController.text =
            "MM${format_no_bukti.format(DateTime.now())}-${value[0]['NOMOR']}";
      }
    });
    await model_memo().cari_account("").then((value) {
      if (value != null) {
        accountList.clear();
        for (int i = 0; i < value.length; i++) {
          accountList.add(DataAccount.fromJson(value[i]));
        }
      }
    });
  }

  Future<void> initData_editMemo(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.parse(data_edit['TGL']);
    tanggalController.text = format_tanggal.format(chooseDate);
    typeController.text = data_edit['TYPE'];
    currController.text = data_edit['CURR'];
    currnmController.text = data_edit['CURRNM'];
    rateController.text = data_edit['RATE'].toString();
    ketController.text = data_edit['KET'];
    debetController.text = data_edit['DEBET'].toString();
    kreditController.text = data_edit['KREDIT'].toString();
    debet1Controller.text = data_edit['DEBET1'].toString();
    kredit1Controller.text = data_edit['KREDIT1'].toString();
    perController.text = data_edit['PER'];
    usrinController.text = data_edit['USRIN'];
    tg_inController.text = data_edit['TG_IN'];
    flagController.text = data_edit['FLAG'];
    List data_lama = await m_memo.select_memo_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "memod");
    data_account_keranjang = new List<DataAccount>();

    for (int i = 0; i < data_lama.length; i++) {
      DataAccount mAccount = DataAccount(
        noid: data_lama[i]['NO_ID'],
        acno: data_lama[i]['ACNO'],
        nacno: data_lama[i]['NACNO'],
        acnob: data_lama[i]['ACNOB'],
        nacnob: data_lama[i]['NACNOB'],
        reff: data_lama[i]['URAIAN'],
        debet: double.parse(data_lama[i]['DEBET'].toString()) ?? 0.00,
        debet1: double.parse(data_lama[i]['DEBET1'].toString()) ?? 0.00,
        kredit: double.parse(data_lama[i]['KREDIT'].toString()) ?? 0.00,
        kredit1: double.parse(data_lama[i]['KREDIT1'].toString()) ?? 0.00,
        jumlah1: double.parse(data_lama[i]['JUMLAH1'].toString()) ?? 0.00,
        jumlah: double.parse(data_lama[i]['JUMLAH'].toString()) ?? 0.00,
      );
      data_account_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_memo().cari_account("").then((value) {
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
    sumJumlah += mAccount.jumlah ?? 0.00;
    sumJumlahRp += mAccount.jumlah1 ?? 0.00;
    sumDebet += mAccount.debet ?? 0.00;
    sumDebetRp += mAccount.debet1 ?? 0.00;
    sumKredit += mAccount.kredit ?? 0.00;
    sumKreditRp += mAccount.kredit1 ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumJumlah = 0;
    sumJumlahRp = 0;
    sumDebet = 0;
    sumDebetRp = 0;
    sumKredit = 0;
    sumKreditRp = 0;
    for (int i = 0; i < data_account_keranjang.length; i++) {
      sumJumlah += data_account_keranjang[i].jumlah ?? 0.00;
      sumDebet += data_account_keranjang[i].debet ?? 0.00;
      sumKredit += data_account_keranjang[i].kredit ?? 0.00;
      sumDebetRp += data_account_keranjang[i].debet1 ?? 0.00;
      sumKreditRp += data_account_keranjang[i].kredit1 ?? 0.00;
      sumJumlahRp += data_account_keranjang[i].jumlah1 ?? 0.00;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveMemo() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_memo.check_no_bukti(
            no_buktiController.text, "NO_BUKTI", "memo");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['TYPE'] = "M";
          obj['CURR'] = currController.text;
          obj['CURRNM'] = currnmController.text;
          obj['RATE'] = rateController.text;
          obj['KET'] = ketController.text;
          obj['PER'] = perx;
          obj['DEBET'] = sumDebet ?? 0.00;
          obj['DEBET1'] = sumDebetRp ?? 0.00;
          obj['KREDIT'] = sumKredit ?? 0.00;
          obj['KREDIT1'] = sumKreditRp ?? 0.00;
          // obj['JUMLAH1'] = sumJumlahRp;
          // obj['JUMLAH'] = sumJumlah;
          obj['USRIN'] = LoginController.nama_staff;
          obj['TG_IN'] = DateTime.now();
          obj['FLAG'] = "M";
          obj['tabeld'] = await baca_tabeld();
          await m_memo.insert_memo(obj);
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

  Future<bool> editMemo() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_account_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['TYPE'] = "M";
        obj['CURR'] = currController.text;
        obj['CURRNM'] = currnmController.text;
        obj['RATE'] = rateController.text;
        obj['KET'] = ketController.text;
        obj['PER'] = perx;
        obj['DEBET'] = sumDebet ?? 0.00;
        obj['DEBET1'] = sumDebetRp ?? 0.00;
        obj['KREDIT'] = sumKredit ?? 0.00;
        obj['KREDIT1'] = sumKreditRp ?? 0.00;
        // obj['JUMLAH1'] = sumJumlah;
        // obj['JUMLAH'] = sumJumlahRp;
        obj['USRIN'] = LoginController.nama_staff;
        obj['TG_IN'] = DateTime.now();
        obj['FLAG'] = "M";
        obj['tabeld'] = await baca_tabeld();
        await m_memo.update_memo(obj);
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

  Future<bool> deleteMemo(String no_bukti) async {
    try {
      var delete = await m_memo.delete_memo(no_bukti);
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
      double debet = data_account_keranjang[i].debet;
      double debet1 = data_account_keranjang[i].debet1;
      double kredit = data_account_keranjang[i].kredit;
      double kredit1 = data_account_keranjang[i].kredit1;
      double jumlah = data_account_keranjang[i].jumlah;
      double jumlah1 = data_account_keranjang[i].jumlah1;
      Map obj = new Map();
      obj['ACNO'] = data_account_keranjang[i].acno;
      obj['NACNO'] = data_account_keranjang[i].nacno;
      obj['ACNOB'] = data_account_keranjang[i].acnob;
      obj['NACNOB'] = data_account_keranjang[i].nacnob;
      obj['URAIAN'] = data_account_keranjang[i].reff;
      obj['DEBET'] = debet ?? 0.00;
      obj['DEBET1'] = debet1 ?? 0.00;
      obj['KREDIT'] = kredit ?? 0.00;
      obj['KREDIT1'] = kredit1 ?? 0.00;
      obj['JUMLAH'] = jumlah ?? 0.00;
      obj['JUMLAH1'] = jumlah1 ?? 0.00;
      accountList.add(obj);
    }
    return accountList;
  }
}
