import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/transaksi/finansial/model_girokeluar.dart';
import 'package:akunt/model/transaksi/operasional/data_hutang.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_controller.dart';

class GirokController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_girok m_girok = model_girok();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_girok_list = [];
  static List home_girok_list = [];
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
    data_girok_list =
        await m_girok.data_girokpaginate(searchController.text, offset, limit);
    home_girok_list =
        await m_girok.data_girokpaginate(searchController.text, offset, limit);
    var count = await m_girok.countGirokPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_girok_list = await model_girok().data_modal(cari);
    home_girok_list = await model_girok().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_girok_list = await m_girok.select_girok(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    home_girok_list = await m_girok.select_girok(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    notifyListeners();
  }

  void selectData(String cari) async {
    data_girok_list = await model_girok().cari_girok(cari);
    home_girok_list = await model_girok().cari_girok(cari);
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
  TextEditingController bgController = TextEditingController();
  TextEditingController jtempoController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_tanggal_JT = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("yyMM", "id_ID");
  DateTime chooseDate = DateTime.now();
  DateTime chooseDateJT = DateTime.now();
  String tanggal;
  List<DataHutang> data_hutang_keranjang = List<DataHutang>();
  double sumJumlah = 0;
  double sumJumlahrp = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataHutang> hutangList = List<DataHutang>();

  Future<void> initData_addGirok() async {
    data_hutang_keranjang = new List<DataHutang>();
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
    bgController.clear();
    jtempoController.clear();
    flagController.clear();
    tanggalController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_tanggal_JT.format(chooseDate);
    sumJumlah = 0;
    sumJumlahrp = 0;
    await baca_periodePrefs();
    await m_girok
        .get_no_bukti(
            'GK${format_no_bukti.format(DateTime.now())}', 'NO_BUKTI', 'giro')
        .then((value) {
      if (value != null) {
        no_buktiController.text =
            "GK${format_no_bukti.format(DateTime.now())}-${value[0]['NOMOR']}";
      }
    });
    await model_girok().cari_hutang("").then((value) {
      if (value != null) {
        hutangList.clear();
        for (int i = 0; i < value.length; i++) {
          hutangList.add(DataHutang.fromJson(value[i]));
        }
      }
    });
  }

  Future<void> initData_editGirok(var data_edit) async {
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
    bgController.text = data_edit['BG'];
    flagController.text = data_edit['FLAG'];
    List data_lama = await m_girok.select_girok_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "girod");
    data_hutang_keranjang = new List<DataHutang>();

    for (int i = 0; i < data_lama.length; i++) {
      DataHutang mAccount = DataHutang(
        noid: data_lama[i]['NO_ID'],
        no_bukti: data_lama[i]['NO_BUKTI'],
        acno: data_lama[i]['ACNO'],
        nacno: data_lama[i]['NACNO'],
        uraian: data_lama[i]['URAIAN'],
        jumlah: double.parse(data_lama[i]['JUMLAH'].toString()) ?? 0.00,
        jumlahrp: double.parse(data_lama[i]['JUMLAHRP'].toString()) ?? 0.00,
        um: double.parse(data_lama[i]['UM'].toString()) ?? 0.00,
        curr: data_lama[i]['CURR'],
        rate: double.parse(data_lama[i]['RATE'].toString()) ?? 0.00,
        noinv: data_lama[i]['NOINV'],
        jumlahinv: double.parse(data_lama[i]['JUMLAHINV'].toString()) ?? 0.00,
      );
      data_hutang_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_girok().cari_girok("").then((value) {
      if (value != null) {
        hutangList.clear();
        for (int i = 0; i < value.length; i++) {
          hutangList.add(DataHutang.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataHutang mAccount) {
    data_hutang_keranjang.add(mAccount);
    sumJumlah += mAccount.jumlah ?? 0.00;
    sumJumlahrp += mAccount.jumlahrp ?? 0.00;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumJumlah = 0;
    sumJumlahrp = 0;
    for (int i = 0; i < data_hutang_keranjang.length; i++) {
      sumJumlah += data_hutang_keranjang[i].jumlah ?? 0.00;
      sumJumlahrp += data_hutang_keranjang[i].jumlahrp ?? 0.00;
    }
    notifyListeners();
  }

  /// data header
  Future<bool> saveGirok() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_hutang_keranjang.length > 0) {
        BotToast.showLoading();
        var data_ready = await m_girok.get_no_bukti(
            no_buktiController.text, "NO_BUKTI", "giro");
        if (data_ready.length > 0) {
          Toast("Peringatan !",
              "No bukti '${no_buktiController.text}' sudah ada", false);
          BotToast.closeAllLoading();
          return false;
        } else {
          Map obj = new Map();
          obj['NO_BUKTI'] = no_buktiController.text;
          obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
          obj['TYPE'] = "BGK";
          obj['BACNO'] = bacnoController.text;
          obj['BNAMA'] = bnamaController.text;
          obj['CURR'] = currController.text;
          obj['CURRNM'] = currnmController.text;
          obj['RATE'] = rateController.text;
          obj['KODE'] = kodeController.text;
          obj['NAMA'] = namaController.text;
          obj['KET'] = ketController.text;
          obj['PER'] = perx;
          obj['JUMLAH1'] = sumJumlahrp;
          obj['JUMLAH'] = sumJumlah;
          obj['USRIN'] = LoginController.nama_staff;
          obj['TG_IN'] = DateTime.now();
          obj['UM'] = umController.text;
          obj['BG'] = bgController.text;
          obj['FLAG'] = "G";
          obj['tabeld'] = await baca_tabeld();
          await m_girok.insert_girok(obj);
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

  Future<bool> editGirok() async {
    hitungSubTotal();
    if (no_buktiController.text.isNotEmpty) {
      if (data_hutang_keranjang.length > 0) {
        BotToast.showLoading();
        Map obj = new Map();
        obj['NO_BUKTI'] = no_buktiController.text;
        obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
        obj['TYPE'] = "BGK";
        obj['BACNO'] = bacnoController.text;
        obj['BNAMA'] = bnamaController.text;
        obj['CURR'] = currController.text;
        obj['CURRNM'] = currnmController.text;
        obj['RATE'] = rateController.text;
        obj['KODE'] = kodeController.text;
        obj['NAMA'] = namaController.text;
        obj['KET'] = ketController.text;
        obj['PER'] = perx;
        obj['JUMLAH1'] = sumJumlahrp;
        obj['JUMLAH'] = sumJumlah;
        obj['USRIN'] = LoginController.nama_staff;
        obj['TG_IN'] = DateTime.now();
        obj['UM'] = umController.text;
        obj['BG'] = bgController.text;
        obj['FLAG'] = "G";
        obj['tabeld'] = await baca_tabeld();
        await m_girok.update_girok(obj);
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

  Future<bool> deleteGirok(String no_bukti) async {
    try {
      var delete = await m_girok.delete_girok(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List piutangList = [];
    for (int i = 0; i < data_hutang_keranjang.length; i++) {
      double jumlah = data_hutang_keranjang[i].jumlah;
      double jumlahrp = data_hutang_keranjang[i].jumlahrp;
      double um = data_hutang_keranjang[i].um;
      double rate = data_hutang_keranjang[i].rate;
      double jumlahinv = data_hutang_keranjang[i].jumlahinv;
      Map obj = new Map();
      obj['NO_BUKTI'] = data_hutang_keranjang[i].no_bukti;
      obj['ACNO'] = data_hutang_keranjang[i].acno;
      obj['NACNO'] = data_hutang_keranjang[i].nacno;
      obj['URAIAN'] = data_hutang_keranjang[i].uraian;
      obj['JUMLAH'] = jumlah ?? 0.00;
      obj['JUMLAHRP'] = jumlahrp ?? 0.00;
      obj['UM'] = um ?? 0.00;
      obj['CURR'] = data_hutang_keranjang[i].curr;
      obj['RATE'] = rate ?? 0.00;
      obj['NOINV'] = data_hutang_keranjang[i].noinv;
      obj['JUMLAHINV'] = jumlahinv ?? 0.00;
      piutangList.add(obj);
    }
    return hutangList;
  }
}
