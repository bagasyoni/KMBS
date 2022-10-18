import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/transaksi/operasional/model_pobahanimport.dart';
import 'package:akunt/model/transaksi/operasional/data_pobahanimport.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/transaksi/operasional/model_btbbahanimport.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_controller.dart';

class BtbbahanimportController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  model_btbbahanimport m_btbbahanimport = model_btbbahanimport();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filter_tanggalController =
      new DateRangePickerController();
  List data_btbbahanimport_list = [];
  static List home_btbbahanimport_list = [];
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
    data_btbbahanimport_list = await m_btbbahanimport
        .data_btbbahanimportpaginate(searchController.text, offset, limit);
    home_btbbahanimport_list = await m_btbbahanimport
        .data_btbbahanimportpaginate(searchController.text, offset, limit);
    var count = await m_btbbahanimport
        .countBtbbahanimportPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    data_btbbahanimport_list = await model_btbbahanimport().data_modal(cari);
    home_btbbahanimport_list = await model_btbbahanimport().data_modal(cari);
    notifyListeners();
  }

  Future<void> baca_periodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> select_data() async {
    data_btbbahanimport_list = await m_btbbahanimport.select_btb_bahan_import(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    home_btbbahanimport_list = await m_btbbahanimport.select_btb_bahan_import(
        searchController.text, tanggal_awal, tanggal_akhir, perx);
    total = 0;
    qty = 0;
    for (int i = 0; i < data_btbbahanimport_list.length; i++) {
      total += double.parse(data_btbbahanimport_list[i]['TOTAL'].toString());
      qty += double.parse(data_btbbahanimport_list[i]['TOTAL_QTY'].toString());
    }
    notifyListeners();
  }

  void selectData(String cari) async {
    data_btbbahanimport_list =
        await model_btbbahanimport().cari_btb_bahan_import(cari);
    home_btbbahanimport_list =
        await model_btbbahanimport().cari_btb_bahan_import(cari);
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

  //add btb bahan
  TextEditingController no_buktiController = TextEditingController();
  TextEditingController tglController = TextEditingController();
  TextEditingController jtempoController = TextEditingController();
  TextEditingController currController = TextEditingController();
  TextEditingController currnmController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController total_qtyController = TextEditingController();
  TextEditingController sisa_qtyController = TextEditingController();
  TextEditingController total1Controller = TextEditingController();
  TextEditingController discController = TextEditingController();
  TextEditingController ppnController = TextEditingController();
  TextEditingController nett1Controller = TextEditingController();
  TextEditingController disc1Controller = TextEditingController();
  TextEditingController ppn1Controller = TextEditingController();
  TextEditingController pph1Controller = TextEditingController();
  TextEditingController pphController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController rpdiscController = TextEditingController();
  TextEditingController rpppnController = TextEditingController();
  TextEditingController nettController = TextEditingController();
  TextEditingController sisaController = TextEditingController();
  TextEditingController rpdisc1Controller = TextEditingController();
  TextEditingController rpppn1Controller = TextEditingController();
  TextEditingController rppph1Controller = TextEditingController();
  TextEditingController rppphController = TextEditingController();
  TextEditingController usrinController = TextEditingController();
  TextEditingController tg_inController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  TextEditingController perController = TextEditingController();
  TextEditingController typController = TextEditingController();
  TextEditingController golController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController rateksController = TextEditingController();
  TextEditingController acno1Controller = TextEditingController();
  TextEditingController acno1_nmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  final format_tanggal = new DateFormat("dd/MM/yyyy");
  final format_jtempo = new DateFormat("dd/MM/yyyy");
  final format_created_at = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final format_created_at2 = DateFormat("yyyy-MM", "id_ID");
  final format_no_bukti = DateFormat("MMyyyy", "id_ID");
  DateTime chooseDate = DateTime.now();
  DateTime chooseDateJT = DateTime.now();
  String tanggal;
  String tanggalJT;
  List<DataPobahanimport> data_pobahanimport_keranjang =
      List<DataPobahanimport>();
  static double rate = 0;
  double sumQty = 0;
  double sumTotal = 0;
  double sumTotal1 = 0;
  double sumDisc = 0;
  double sumDisc1 = 0;
  double sumPPN = 0;
  double sumPPN1 = 0;
  double sumPPH = 0;
  double sumPPH1 = 0;
  double sumNett = 0;
  double sumNett1 = 0;
  String uraian, reff;
  int no_urut = 0;
  List<DataPobahanimport> pobhnimportList = List<DataPobahanimport>();

  Future<void> initData_addBtbbahanimport() async {
    data_pobahanimport_keranjang = new List<DataPobahanimport>();
    no_buktiController.clear();
    tglController.clear();
    jtempoController.clear();
    currController.clear();
    currnmController.clear();
    rateController.clear();
    kodesController.clear();
    namasController.clear();
    alamatController.clear();
    kotaController.clear();
    notesController.clear();
    total_qtyController.clear();
    sisa_qtyController.clear();
    total1Controller.clear();
    discController.clear();
    ppnController.clear();
    nett1Controller.clear();
    disc1Controller.clear();
    ppn1Controller.clear();
    pph1Controller.clear();
    pphController.clear();
    totalController.clear();
    rpdiscController.clear();
    rpppnController.clear();
    nettController.clear();
    sisaController.clear();
    rpdisc1Controller.clear();
    rpppn1Controller.clear();
    rppph1Controller.clear();
    rppphController.clear();
    usrinController.clear();
    tg_inController.clear();
    flagController.clear();
    perController.clear();
    typController.clear();
    golController.clear();
    brandController.clear();
    rateksController.clear();
    acno1Controller.clear();
    acno1_nmController.clear();
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_jtempo.format(chooseDateJT);
    sumQty = 0;
    sumTotal = 0;
    sumTotal1 = 0;
    sumDisc = 0;
    sumDisc1 = 0;
    sumPPN = 0;
    sumPPN1 = 0;
    sumPPH = 0;
    sumPPH1 = 0;
    sumNett = 0;
    sumNett1 = 0;
    String rate = rateController.text;
    await baca_periodePrefs();
    await model_pobahanimport().cari_po_bahan_import("").then((value) {
      if (value != null) {
        pobhnimportList.clear();
        for (int i = 0; i < value.length; i++) {
          pobhnimportList.add(DataPobahanimport.fromJson(value[i]));
        }
      }
    });
  }

  ///HEADER///
  Future<void> initData_editBtbbahanimport(var data_edit) async {
    no_buktiController.text = data_edit['NO_BUKTI'];
    chooseDate = DateTime.tryParse(data_edit['TGL']);
    chooseDateJT = DateTime.tryParse(data_edit['JTEMPO']);
    currController.text = data_edit['CURR'];
    currnmController.text = data_edit['CURRNM'];
    rateController.text = data_edit['RATE'].toString();
    kodesController.text = data_edit['KODES'];
    namasController.text = data_edit['NAMAS'];
    alamatController.text = data_edit['ALAMAT'];
    kotaController.text = data_edit['KOTA'];
    notesController.text = data_edit['NOTES'];
    total_qtyController.text = data_edit['TOTAL_QTY'].toString();
    sisa_qtyController.text = data_edit['SISA_QTY'].toString();
    total1Controller.text = data_edit['TOTAL1'].toString();
    discController.text = data_edit['DISC'].toString();
    ppnController.text = data_edit['PPN'].toString();
    nett1Controller.text = data_edit['NETT1'].toString();
    disc1Controller.text = data_edit['DISC1'].toString();
    ppn1Controller.text = data_edit['PPN1'].toString();
    pph1Controller.text = data_edit['PPH1'].toString();
    pphController.text = data_edit['PPH'].toString();
    totalController.text = data_edit['TOTAL'].toString();
    rpdiscController.text = data_edit['RPDISC'].toString();
    rpppnController.text = data_edit['RPPPN'].toString();
    nettController.text = data_edit['NETT'].toString();
    sisaController.text = data_edit['SISA'].toString();
    rpdisc1Controller.text = data_edit['RPDISC1'].toString();
    rpppn1Controller.text = data_edit['RPPPN1'].toString();
    rppph1Controller.text = data_edit['RPPPH1'].toString();
    rppphController.text = data_edit['RPPPH'].toString();
    usrnmController.text = data_edit['USRNM'];
    tg_smpController.text = data_edit['TG_SMP'];
    flagController.text = data_edit['FLAG'];
    perController.text = data_edit['PER'];
    typController.text = data_edit['TYP'];
    golController.text = data_edit['GOL'];
    brandController.text = data_edit['BRAND'];
    rateksController.text = data_edit['RATEKS'].toString();
    acno1Controller.text = data_edit['ACNO1'];
    acno1_nmController.text = data_edit['ACNO1_NM'];
    tglController.text = format_tanggal.format(chooseDate);
    jtempoController.text = format_jtempo.format(chooseDateJT);
    List data_lama = await m_btbbahanimport.select_btb_bahan_import_detail(
        data_edit['NO_BUKTI'], "NO_BUKTI", "belid");
    data_pobahanimport_keranjang = new List<DataPobahanimport>();

    for (int i = 0; i < data_lama.length; i++) {
      DataPobahanimport mAccount = DataPobahanimport(
        noid: data_lama[i]['NO_ID'],
        no_bukti: data_lama[i]['NO_PO'],
        qtypo: data_lama[i]['NA_BHN'],
        kd_bhn: data_lama[i]['SATUAN'],
        na_bhn: data_lama[i]['KET'],
        satuan: data_lama[i]['SATUAN'],
        qty: double.parse(data_lama[i]['QTY'].toString()),
        satuanbl: data_lama[i]['SATUANBL'],
        qtybl: double.parse(data_lama[i]['QTYBL'].toString()),
        harga1: double.parse(data_lama[i]['HARGA1'].toString()),
        total1: double.parse(data_lama[i]['TOTAL1'].toString()),
        ket: data_lama[i]['KET'],
        harga: double.parse(data_lama[i]['HARGA'].toString()),
        total: double.parse(data_lama[i]['TOTAL'].toString()),
        blt: double.parse(data_lama[i]['BLT'].toString()),
        disc: double.parse(data_lama[i]['DISC'].toString()),
        rpdisc: double.parse(data_lama[i]['RPDISC'].toString()),
        typ: data_lama[i]['TYP'],
        gol: data_lama[i]['GOL'],
        htg: double.parse(data_lama[i]['HTG'].toString()),
        siz: data_lama[i]['SIZ'],
        kd: data_lama[i]['KD'],
        kodecab: data_lama[i]['KODECAB'],
        warna: data_lama[i]['WARNA'],
        produk: data_lama[i]['PRODUK'],
        grp: data_lama[i]['GRP'],
        acno: data_lama[i]['ACNO'],
        acno_nm: data_lama[i]['ACNO_NM'],
      );
      data_pobahanimport_keranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_pobahanimport().cari_po_bahan_import("").then((value) {
      if (value != null) {
        pobhnimportList.clear();
        for (int i = 0; i < value.length; i++) {
          pobhnimportList.add(DataPobahanimport.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataPobahanimport mAccount) {
    data_pobahanimport_keranjang.add(mAccount);
    sumQty += mAccount.qty;
    sumTotal += mAccount.total;
    sumTotal1 += mAccount.total1;
    notifyListeners();
  }

  void hitungSubTotal() {
    sumQty = 0;
    sumTotal = 0;
    sumTotal1 = 0;
    sumDisc = 0;
    sumDisc1 = 0;
    sumPPN = 0;
    sumPPN1 = 0;
    sumPPH = 0;
    sumPPH1 = 0;
    sumNett = 0;
    sumNett1 = 0;
    rate = double.parse(rateController.text);
    for (int i = 0; i < data_pobahanimport_keranjang.length; i++) {
      sumQty += data_pobahanimport_keranjang[i].qty;
      sumTotal += (data_pobahanimport_keranjang[i].harga *
          data_pobahanimport_keranjang[i].qty);
      sumTotal1 += (data_pobahanimport_keranjang[i].harga *
              data_pobahanimport_keranjang[i].qty) *
          rate;
    }
    sumDisc = sumTotal * disc / 100;
    sumDisc1 = sumTotal1 * disc1 / 100;
    sumPPN = (sumTotal - sumDisc) * 11 / 100;
    sumPPN1 = (sumTotal1 - sumDisc1) * 11 / 100;
    sumPPH = sumTotal * pph / 100;
    sumPPH1 = sumTotal1 * pph1 / 100;
    sumNett = sumTotal - sumDisc + sumPPN - sumPPH;
    sumNett1 = sumTotal1 - sumDisc1 + sumPPN1 - sumPPH1;
    notifyListeners();
  }

  /// data header
  Future<bool> saveBtbbahanlokal() async {
    hitungSubTotal();
    String periodeTgl = DateFormat("MM/yyyy").format(chooseDate);
    if (int.parse(DateFormat("yyyyMMdd").format(chooseDateJT)) >
        int.parse(DateFormat("yyyyMMdd").format(chooseDate))) {
      if (periodeTgl == perx) {
        if (no_buktiController.text.isNotEmpty) {
          if (data_pobahanimport_keranjang.length > 0) {
            BotToast.showLoading();
            var data_ready = await m_btbbahanimport.check_no_bukti(
                no_buktiController.text, "NO_BUKTI", "po");
            if (data_ready.length > 0) {
              Toast("Peringatan !",
                  "No bukti '${no_buktiController.text}' sudah ada", false);
              BotToast.closeAllLoading();
              return false;
            } else {
              Map obj = new Map();
              obj['NO_BUKTI'] = no_buktiController.text;
              obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
              obj['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDateJT);
              obj['CURR'] = currController.text;
              obj['CURRNM'] = currnmController.text;
              obj['RATE'] = rateController.text;
              obj['KODES'] = kodesController.text;
              obj['NAMAS'] = namasController.text;
              obj['ALAMAT'] = alamatController.text;
              obj['KOTA'] = kotaController.text;
              obj['NOTES'] = notesController.text;
              obj['TOTAL_QTY'] = sumQty;
              obj['SISA_QTY'] = 0;
              obj['TOTAL1'] = sumTotal1;
              obj['DISC'] = discController.text;
              obj['PPN'] = 11.00;
              obj['NETT1'] = sumNett1;
              obj['DISC1'] = disc1Controller.text;
              obj['PPN1'] = 11.00;
              obj['PPH1'] = pph1Controller.text;
              obj['PPH'] = pphController.text;
              obj['TOTAL'] = sumTotal;
              obj['RPDISC'] = sumDisc;
              obj['RPPPN'] = sumPPN;
              obj['NETT'] = sumNett;
              obj['SISA'] = 0;
              obj['RPDISC1'] = sumDisc1;
              obj['RPPPN1'] = sumPPN1;
              obj['RPPPH1'] = sumPPH1;
              obj['RPPPH'] = sumPPH;
              obj['USRIN'] = LoginController.nama_staff;
              obj['TG_IN'] = DateTime.now();
              obj['FLAG'] = "BL";
              obj['PER'] = perx;
              obj['TYP'] = "I";
              obj['GOL'] = "A";
              obj['BRAND'] = brandController.text;
              obj['rateks'] = rateksController.text;
              obj['ACNO1'] = acno1Controller.text;
              obj['ACNO1_NM'] = acno1_nmController.text;
              obj['tabeld'] = await baca_tabeld();
              await m_btbbahanimport.insert_btb_bahan_import(obj);
              BotToast.closeAllLoading();
              return true;
            }
          } else {
            Toast("Peringatan !", "Belum ada detil Transaksi yang di input",
                false);
            return false;
          }
        } else {
          Toast("Peringatan !", "No. bukti wajib di isi !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Tanggal tidak sesuai Periode!", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Jatuh Tempo Salah!", false);
      return false;
    }
  }

  Future<bool> editBtbbahanimport() async {
    hitungSubTotal();
    String periodeTgl = DateFormat("MM/yyyy").format(chooseDate);
    if (int.parse(DateFormat("yyyyMMdd").format(chooseDateJT)) >
        int.parse(DateFormat("yyyyMMdd").format(chooseDate))) {
      if (periodeTgl == perx) {
        if (no_buktiController.text.isNotEmpty) {
          if (data_pobahanimport_keranjang.length > 0) {
            BotToast.showLoading();
            Map obj = new Map();
            obj['NO_BUKTI'] = no_buktiController.text;
            obj['TGL'] = DateFormat("yyyy-MM-dd").format(chooseDate);
            obj['JTEMPO'] = DateFormat("yyyy-MM-dd").format(chooseDateJT);
            obj['CURR'] = currController.text;
            obj['CURRNM'] = currnmController.text;
            obj['RATE'] = rateController.text;
            obj['KODES'] = kodesController.text;
            obj['NAMAS'] = namasController.text;
            obj['ALAMAT'] = alamatController.text;
            obj['KOTA'] = kotaController.text;
            obj['NOTES'] = notesController.text;
            obj['TOTAL_QTY'] = sumQty;
            obj['SISA_QTY'] = 0;
            obj['TOTAL1'] = sumTotal1;
            obj['DISC'] = discController.text;
            obj['PPN'] = 11.00;
            obj['NETT1'] = sumNett1;
            obj['DISC1'] = disc1Controller.text;
            obj['PPN1'] = 11.00;
            obj['PPH1'] = pph1Controller.text;
            obj['PPH'] = pphController.text;
            obj['TOTAL'] = sumTotal;
            obj['RPDISC'] = sumDisc;
            obj['RPPPN'] = sumPPN;
            obj['NETT'] = sumNett;
            obj['SISA'] = 0;
            obj['RPDISC1'] = sumDisc1;
            obj['RPPPN1'] = sumPPN1;
            obj['RPPPH1'] = sumPPH1;
            obj['RPPPH'] = sumPPH;
            obj['USRNM'] = LoginController.nama_staff;
            obj['TG_SMP'] = DateTime.now();
            obj['FLAG'] = "BL";
            obj['PER'] = perx;
            obj['TYP'] = "I";
            obj['GOL'] = "A";
            obj['BRAND'] = brandController.text;
            obj['rateks'] = rateksController.text;
            obj['ACNO1'] = acno1Controller.text;
            obj['ACNO1_NM'] = acno1_nmController.text;
            obj['tabeld'] = await baca_tabeld();
            await m_btbbahanimport.update_btb_bahan_import(obj);
            BotToast.closeAllLoading();
            Toast("Success !", "Berhasil mengedit data", true);
            return true;
          } else {
            Toast("Peringatan !", "Belum ada detil Transaksi yang di input",
                false);
            return false;
          }
        } else {
          Toast("Peringatan !", "No. bukti wajib di isi !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Tanggal tidak sesuai periode !", false);
      }
    } else {
      Toast("Peringatan ?", "Jatuh Tempo Salah !", false);
    }
  }

  Future<bool> deleteBtbbahanimport(String no_bukti) async {
    try {
      var delete = await m_btbbahanimport.delete_btb_bahan_import(no_bukti);
      await select_data();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> baca_tabeld() async {
    List pobhnimportList = [];
    for (int i = 0; i < data_pobahanimport_keranjang.length; i++) {
      double qty = data_pobahanimport_keranjang[i].qty;
      double harga = data_pobahanimport_keranjang[i].harga;
      double rate = double.parse(rateController.text);
      double subTotal = harga * qty;
      double subTotal1 = (harga * qty) * rate;
      Map obj = new Map();
      obj['NO_PO'] = data_pobahanimport_keranjang[i].kd_bhn;
      obj['QTYPO'] = data_pobahanimport_keranjang[i].na_bhn;
      obj['KD_BHN'] = data_pobahanimport_keranjang[i].satuan;
      obj['NA_BHN'] = data_pobahanimport_keranjang[i].ket;
      obj['SATUAN'] = data_pobahanimport_keranjang[i].harga;
      obj['QTY'] = data_pobahanimport_keranjang[i].qty;
      obj['SATUANBL'] = data_pobahanimport_keranjang[i].satuanbl;
      obj['QTYBL'] = data_pobahanimport_keranjang[i].qtybl;
      obj['HARGA1'] = data_pobahanimport_keranjang[i].harga1;
      obj['TOTAL1'] = data_pobahanimport_keranjang[i].total1;
      obj['KET'] = data_pobahanimport_keranjang[i].ket;
      obj['HARGA'] = data_pobahanimport_keranjang[i].harga;
      obj['TOTAL'] = data_pobahanimport_keranjang[i].total;
      obj['BLT'] = data_pobahanimport_keranjang[i].blt;
      obj['DISC'] = data_pobahanimport_keranjang[i].disc;
      obj['RPDISC'] = data_pobahanimport_keranjang[i].rpdisc;
      obj['TYP'] = data_pobahanimport_keranjang[i].typ;
      obj['GOL'] = data_pobahanimport_keranjang[i].gol;
      obj['HTG'] = data_pobahanimport_keranjang[i].htg;
      obj['SIZ'] = data_pobahanimport_keranjang[i].siz;
      obj['KD'] = data_pobahanimport_keranjang[i].kd;
      obj['KODECAB'] = data_pobahanimport_keranjang[i].kodecab;
      obj['WARNA'] = data_pobahanimport_keranjang[i].warna;
      obj['PRODUK'] = data_pobahanimport_keranjang[i].produk;
      obj['GRP'] = data_pobahanimport_keranjang[i].grp;
      obj['ACNO'] = data_pobahanimport_keranjang[i].acno;
      obj['ACNO_NM'] = data_pobahanimport_keranjang[i].acno_nm;
      pobhnimportList.add(obj);
    }
    return pobhnimportList;
  }
}
