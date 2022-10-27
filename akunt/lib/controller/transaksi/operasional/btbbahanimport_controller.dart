import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/transaksi/operasional/model_btbbahanimport.dart';
import 'package:akunt/model/transaksi/operasional/model_pobahanimport.dart';
import 'package:akunt/model/transaksi/operasional/data_podbahanimport.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_controller.dart';

class BtbBahanImportController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  ModelBtbBahanImport mBtbBahanImport = ModelBtbBahanImport();
  TextEditingController searchController = TextEditingController();
  DateRangePickerController filterTanggalController =
      new DateRangePickerController();
  List dataBtbBahanImportList = [];
  static List homeBtbBahanImportList = [];
  bool isEnableButton = true;
  String selectedDate = '';
  String dateCount = '';
  String range = 'Pilih tanggal';
  String perx = '';
  String rangeCount = '';
  String tanggalAwal = "";
  String tanggalAkhir = "";
  double total = 0;
  double qty = 0;
  double disc = 0;
  double disc1 = 0;
  double ppn = 0;
  double ppn1 = 0;
  double pph = 0;
  double pph1 = 0;
  int indexTerpilih;
  TextEditingController cPage = new TextEditingController();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int pageIndex = 0;

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
      pageIndex = 0;
    }
    dataBtbBahanImportList = await mBtbBahanImport.dataBtbBahanImportPaginate(
        searchController.text, offset, limit);
    homeBtbBahanImportList = await mBtbBahanImport.dataBtbBahanImportPaginate(
        searchController.text, offset, limit);
    var count = await mBtbBahanImport
        .countBtbBahanImportPaginate(searchController.text);
    totalNotaTerima = int.tryParse(count[0]['COUNT(*)'].toString()) ?? 0;
    pageCount = totalNotaTerima / limit;
    notifyListeners();
  }

  void modalData(String cari) async {
    dataBtbBahanImportList = await ModelBtbBahanImport().dataModal(cari);
    homeBtbBahanImportList = await ModelBtbBahanImport().dataModal(cari);
    notifyListeners();
  }

  Future<void> bacaPeriodePrefs() async {
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  Future<void> selectDataTanggal() async {
    dataBtbBahanImportList = await mBtbBahanImport.selectBtbBahanImport(
        searchController.text, tanggalAwal, tanggalAkhir, perx);
    homeBtbBahanImportList = await mBtbBahanImport.selectBtbBahanImport(
        searchController.text, tanggalAwal, tanggalAkhir, perx);
    total = 0;
    qty = 0;
    for (int i = 0; i < dataBtbBahanImportList.length; i++) {
      total += double.parse(dataBtbBahanImportList[i]['TOTAL'].toString());
      qty += double.parse(dataBtbBahanImportList[i]['TOTAL_QTY'].toString());
    }
    notifyListeners();
  }

  void selectData(String cari) async {
    dataBtbBahanImportList =
        await ModelBtbBahanImport().cariBtbBahanImport(cari);
    homeBtbBahanImportList =
        await ModelBtbBahanImport().cariBtbBahanImport(cari);
    await bacaPeriodePrefs();
    notifyListeners();
  }

  void initData() {
    cPage.text = '1';
    limitPaging();
    selectDataPaginate(true);
    indexTerpilih = null;
    tanggalAwal =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    tanggalAkhir =
        DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now()).toString();
    range =
        DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString() +
            ' - ' +
            DateFormat('dd/MM/yyyy', "id_ID").format(DateTime.now()).toString();
    bacaPeriodePrefs();
    selectDataTanggal();
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
          tanggalAwal = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.startDate)
              .toString();
          tanggalAkhir = DateFormat('yyyy-MM-dd', "id_ID")
              .format(args.value.endDate)
              .toString();
          isEnableButton = true;
        } else {
          isEnableButton = false;
        }
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
        isEnableButton = false;
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
        isEnableButton = false;
      } else {
        rangeCount = args.value.length.toString();
        isEnableButton = false;
      }
      notifyListeners();
    }
  }

  //add btb bahan
  TextEditingController noBuktiController = TextEditingController();
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
  TextEditingController totalQtyController = TextEditingController();
  TextEditingController sisaQtyController = TextEditingController();
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
  TextEditingController tgInController = TextEditingController();
  TextEditingController flagController = TextEditingController();
  TextEditingController perController = TextEditingController();
  TextEditingController typController = TextEditingController();
  TextEditingController golController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController rateksController = TextEditingController();
  TextEditingController acno1Controller = TextEditingController();
  TextEditingController acno1NmController = TextEditingController();
  TextEditingController tgSmpController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  final formatTanggal = new DateFormat("dd/MM/yyyy");
  final formatJtempo = new DateFormat("dd/MM/yyyy");
  final formatCreatedAt = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID");
  final formatCreatedAt2 = DateFormat("yyyy-MM", "id_ID");
  final formatNoBukti = DateFormat("MMyyyy", "id_ID");
  DateTime chooseDate = DateTime.now();
  DateTime chooseDateJT = DateTime.now();
  String tanggal;
  String tanggalJT;
  List<DataPodBahanImport> dataPodBahanImportKeranjang =
      List<DataPodBahanImport>();
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
  int noUrut = 0;
  List<DataPodBahanImport> podBhnImportList = List<DataPodBahanImport>();

  Future<void> initDataAddBtbBahanImport() async {
    dataPodBahanImportKeranjang = new List<DataPodBahanImport>();
    noBuktiController.clear();
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
    totalQtyController.clear();
    sisaQtyController.clear();
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
    tgInController.clear();
    flagController.clear();
    perController.clear();
    typController.clear();
    golController.clear();
    brandController.clear();
    rateksController.clear();
    acno1Controller.clear();
    acno1NmController.clear();
    tglController.text = formatTanggal.format(chooseDate);
    jtempoController.text = formatJtempo.format(chooseDateJT);
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
    await bacaPeriodePrefs();
    await mBtbBahanImport
        .getNoBukti('BL/BHN/I', 'NO_BUKTI', 'beli')
        .then((value) {
      if (value != null) {
        noBuktiController.text =
            "BL/BHN/I/${formatNoBukti.format(DateTime.now())}/${value[0]['NOMOR']}";
      }
    });
    await model_pobahanimport().cari_po_bahan_import("").then((value) {
      if (value != null) {
        podBhnImportList.clear();
        for (int i = 0; i < value.length; i++) {
          podBhnImportList.add(DataPodBahanImport.fromJson(value[i]));
        }
      }
      notifyListeners();
    });
  }

  ///HEADER///
  Future<void> initDataEditBtbBahanImport(var dataEdit) async {
    noBuktiController.text = dataEdit['NO_BUKTI'];
    chooseDate = DateTime.tryParse(dataEdit['TGL']);
    chooseDateJT = DateTime.tryParse(dataEdit['JTEMPO']);
    currController.text = dataEdit['CURR'];
    currnmController.text = dataEdit['CURRNM'];
    rateController.text = dataEdit['RATE'].toString();
    kodesController.text = dataEdit['KODES'];
    namasController.text = dataEdit['NAMAS'];
    alamatController.text = dataEdit['ALAMAT'];
    kotaController.text = dataEdit['KOTA'];
    notesController.text = dataEdit['NOTES'];
    totalQtyController.text = dataEdit['TOTAL_QTY'].toString();
    sisaQtyController.text = dataEdit['SISA_QTY'].toString();
    total1Controller.text = dataEdit['TOTAL1'].toString();
    discController.text = dataEdit['DISC'].toString();
    ppnController.text = dataEdit['PPN'].toString();
    nett1Controller.text = dataEdit['NETT1'].toString();
    disc1Controller.text = dataEdit['DISC1'].toString();
    ppn1Controller.text = dataEdit['PPN1'].toString();
    pph1Controller.text = dataEdit['PPH1'].toString();
    pphController.text = dataEdit['PPH'].toString();
    totalController.text = dataEdit['TOTAL'].toString();
    rpdiscController.text = dataEdit['RPDISC'].toString();
    rpppnController.text = dataEdit['RPPPN'].toString();
    nettController.text = dataEdit['NETT'].toString();
    sisaController.text = dataEdit['SISA'].toString();
    rpdisc1Controller.text = dataEdit['RPDISC1'].toString();
    rpppn1Controller.text = dataEdit['RPPPN1'].toString();
    rppph1Controller.text = dataEdit['RPPPH1'].toString();
    rppphController.text = dataEdit['RPPPH'].toString();
    usrnmController.text = dataEdit['USRNM'];
    tgSmpController.text = dataEdit['TG_SMP'];
    flagController.text = dataEdit['FLAG'];
    perController.text = dataEdit['PER'];
    typController.text = dataEdit['TYP'];
    golController.text = dataEdit['GOL'];
    brandController.text = dataEdit['BRAND'];
    rateksController.text = dataEdit['RATEKS'].toString();
    acno1Controller.text = dataEdit['ACNO1'];
    acno1NmController.text = dataEdit['ACNO1_NM'];
    tglController.text = formatTanggal.format(chooseDate);
    jtempoController.text = formatJtempo.format(chooseDateJT);
    List dataLama = await mBtbBahanImport.selectBtbBahanImportDetail(
        dataEdit['NO_BUKTI'], "NO_BUKTI", "belid");
    dataPodBahanImportKeranjang = new List<DataPodBahanImport>();

    for (int i = 0; i < dataLama.length; i++) {
      DataPodBahanImport mAccount = DataPodBahanImport(
        noid: dataLama[i]['NO_ID'],
        nobukti: dataLama[i]['NO_PO'],
        kdbhn: dataLama[i]['SATUAN'],
        nabhn: dataLama[i]['KET'],
        qty: double.parse(dataLama[i]['QTY'].toString()),
        qtybl: double.parse(dataLama[i]['QTYBL'].toString()),
        harga1: double.parse(dataLama[i]['HARGA1'].toString()),
        total1: double.parse(dataLama[i]['TOTAL1'].toString()),
        notes: dataLama[i]['NOTES'],
        harga: double.parse(dataLama[i]['HARGA'].toString()),
        total: double.parse(dataLama[i]['TOTAL'].toString()),
      );
      dataPodBahanImportKeranjang.add(mAccount);
    }
    hitungSubTotal();
    await model_pobahanimport().cari_po_bahan_import("").then((value) {
      if (value != null) {
        podBhnImportList.clear();
        for (int i = 0; i < value.length; i++) {
          podBhnImportList.add(DataPodBahanImport.fromJson(value[i]));
        }
      }
    });
  }

  void addKeranjang(DataPodBahanImport mAccount) {
    dataPodBahanImportKeranjang.add(mAccount);
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
    for (int i = 0; i < dataPodBahanImportKeranjang.length; i++) {
      sumQty += dataPodBahanImportKeranjang[i].qty;
      sumTotal += (dataPodBahanImportKeranjang[i].harga *
          dataPodBahanImportKeranjang[i].qty);
      sumTotal1 += (dataPodBahanImportKeranjang[i].harga *
              dataPodBahanImportKeranjang[i].qty) *
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
  Future<bool> saveBtbBahanImport() async {
    hitungSubTotal();
    String periodeTgl = DateFormat("MM/yyyy").format(chooseDate);
    if (int.parse(DateFormat("yyyyMMdd").format(chooseDateJT)) >
        int.parse(DateFormat("yyyyMMdd").format(chooseDate))) {
      if (periodeTgl == perx) {
        if (noBuktiController.text.isNotEmpty) {
          if (dataPodBahanImportKeranjang.isNotEmpty) {
            BotToast.showLoading();
            var dataReady = await mBtbBahanImport.checkNoBukti(
                noBuktiController.text, "NO_BUKTI", "po");
            if (dataReady.isNotEmpty) {
              Toast("Peringatan !",
                  "No bukti '${noBuktiController.text}' sudah ada", false);
              BotToast.closeAllLoading();
              return false;
            } else {
              Map obj = new Map();
              obj['NO_BUKTI'] = noBuktiController.text;
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
              obj['ACNO1_NM'] = acno1NmController.text;
              obj['tabeld'] = await bacaTabeld();
              await mBtbBahanImport.insertBtbBahanImport(obj);
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

  Future<bool> editBtbBahanImport() async {
    hitungSubTotal();
    String periodeTgl = DateFormat("MM/yyyy").format(chooseDate);
    if (int.parse(DateFormat("yyyyMMdd").format(chooseDateJT)) >
        int.parse(DateFormat("yyyyMMdd").format(chooseDate))) {
      if (periodeTgl == perx) {
        if (noBuktiController.text.isNotEmpty) {
          if (dataPodBahanImportKeranjang.isNotEmpty) {
            BotToast.showLoading();
            Map obj = new Map();
            obj['NO_BUKTI'] = noBuktiController.text;
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
            obj['ACNO1_NM'] = acno1NmController.text;
            obj['tabeld'] = await bacaTabeld();
            await mBtbBahanImport.updateBtbBahanImport(obj);
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

  Future<bool> deleteBtbBahanImport(String no_bukti) async {
    try {
      var delete = await mBtbBahanImport.deleteBtbBahanImport(no_bukti);
      await selectDataTanggal();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// data detail
  Future<List> bacaTabeld() async {
    List podBhnImportList = [];
    for (int i = 0; i < dataPodBahanImportKeranjang.length; i++) {
      double qty = dataPodBahanImportKeranjang[i].qty;
      double harga = dataPodBahanImportKeranjang[i].harga;
      double rate = double.parse(rateController.text);
      double subTotal = harga * qty;
      double subTotal1 = (harga * qty) * rate;
      Map obj = new Map();
      obj['NO_PO'] = dataPodBahanImportKeranjang[i].nobukti;
      obj['KD_BHN'] = dataPodBahanImportKeranjang[i].kdbhn;
      obj['NA_BHN'] = dataPodBahanImportKeranjang[i].nabhn;
      obj['QTY'] = dataPodBahanImportKeranjang[i].qty;
      obj['QTYBL'] = dataPodBahanImportKeranjang[i].qtybl;
      obj['HARGA1'] = dataPodBahanImportKeranjang[i].harga1;
      obj['TOTAL1'] = dataPodBahanImportKeranjang[i].total1;
      obj['NOTES'] = dataPodBahanImportKeranjang[i].notes;
      obj['HARGA'] = dataPodBahanImportKeranjang[i].harga;
      obj['TOTAL'] = dataPodBahanImportKeranjang[i].total;
      podBhnImportList.add(obj);
    }
    return podBhnImportList;
  }
}
