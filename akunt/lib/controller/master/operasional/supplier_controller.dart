import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/master/operasional/model_supplier.dart';
// import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierController with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  ///paginate
  bool proses = false;
  List data_supplierList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_supplier m_supplier = model_supplier();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;
  String perx = '';
  String tgl = '';

  Future<void> baca_periodePrefs() async {
    tgl = DateTime.now().toString();
    prefs = await _prefs;
    perx = prefs.getString("periode") ??
        DateFormat('MM/yyyy', "id_ID").format(DateTime.now()).toString();
  }

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_supplier() async {
    data_supplierList = await model_supplier().data_supplier_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_supplierList = await model_supplier().cari_supplier(cari);
    notifyListeners();
  }

  ///paginate
  Future<void> initData() async {
    c_page.text = '1';
    limitPaging();
    await selectDataPaginate(true);
  }

  ///paginate
  Future<void> selectDataPaginate(bool reload) async {
    if (reload) {
      offset = 0;
      page_index = 0;
    }
    data_supplierList =
        await m_supplier.data_suppaginate(searchController.text, offset, limit);
    var count = await m_supplier.countSupPaginate(searchController.text);
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

  void modalData(String cari) async {
    data_supplierList = await model_supplier().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_supplierList = await model_supplier().cari_supplier(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah supplier
  TextEditingController kodesController = TextEditingController();
  TextEditingController namasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController telpon1Controller = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController npwpController = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController blacnoaController = TextEditingController();
  TextEditingController blacnobController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController bank_cabController = TextEditingController();
  TextEditingController bank_kotaController = TextEditingController();
  TextEditingController bank_namaController = TextEditingController();
  TextEditingController bank_rekController = TextEditingController();
  TextEditingController limController = TextEditingController();
  TextEditingController hariController = TextEditingController();
  TextEditingController typController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_supplier() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_supplier(var data_supplier) async {
    kodesController.text = data_supplier['KODES'] ?? "";
    namasController.text = data_supplier['NAMAS'] ?? "";
    alamatController.text = data_supplier['ALAMAT'] ?? "";
    kotaController.text = data_supplier['KOTA'] ?? "";
    telpon1Controller.text = data_supplier['TELPON1'] ?? "";
    faxController.text = data_supplier['FAX'] ?? "";
    hpController.text = data_supplier['HP'] ?? "";
    kontakController.text = data_supplier['KONTAK'] ?? "";
    emailController.text = data_supplier['EMAIL'] ?? "";
    npwpController.text = data_supplier['NPWP'] ?? "";
    ketController.text = data_supplier['KET'] ?? "";
    blacnoaController.text = data_supplier['BLACNOA'] ?? "";
    blacnobController.text = data_supplier['BLACNOB'] ?? "";
    bankController.text = data_supplier['BANK'] ?? "";
    bank_cabController.text = data_supplier['BANK_CAB'] ?? "";
    bank_kotaController.text = data_supplier['BANK_KOTA'] ?? "";
    bank_namaController.text = data_supplier['BANK_NAMA'] ?? "";
    bank_rekController.text = data_supplier['BANK_REK'] ?? "";
    limController.text = data_supplier['LIM'].toString();
    hariController.text = data_supplier['HARI'].toString();
    typController.text = data_supplier['TYP'] ?? "";
    usrnmController.text = data_supplier['USRNM'] ?? "";
    tg_smpController.text = data_supplier['TG_SMP'] ?? "";

    // bool cek_satuan = await model_satuan()
    //     .cek_data_satuan(data_supplier['SATUAN'].toString().toLowerCase());
    // if (cek_satuan == true) {
    //   satuan_barang = data_supplier['SATUAN'].toString();
    // } else {
    //   satuan_barang = "";
    // }
    // notifyListeners();
  }

  // Future<void> data_satuan_barang() async {
  //   dropdownList_satuan_barang = [];
  //   dropdownList_satuan_barang
  //       .add(new DropdownMenuItem(value: "", child: new Text("Pilih Satuan")));
  //   List satuanList = await model_satuan().data_satuan("");
  //   for (int i = 0; i < satuanList.length; i++) {
  //     dropdownList_satuan_barang.add(new DropdownMenuItem(
  //         value: satuanList[i]['nama_satuan'].toString().toLowerCase(),
  //         child: new Text(satuanList[i]['nama_satuan'])));
  //   }
  //   dropdownList_satuan_barang.add(new DropdownMenuItem(
  //       value: "Tambah Baru ?", child: new Text("Tambah Baru ?")));
  //   satuan_barang = dropdownList_satuan_barang[0].value;
  // }

  void resetField() {
    kodesController.clear();
    namasController.clear();
    alamatController.clear();
    kotaController.clear();
    telpon1Controller.clear();
    faxController.clear();
    hpController.clear();
    kontakController.clear();
    emailController.clear();
    npwpController.clear();
    ketController.clear();
    blacnoaController.clear();
    blacnobController.clear();
    bankController.clear();
    bank_cabController.clear();
    bank_kotaController.clear();
    bank_namaController.clear();
    bank_rekController.clear();
    limController.clear();
    hariController.clear();
    typController.clear();
    usrnmController.clear();
    tg_smpController.clear();
  }

  Future<bool> daftar_supplier() async {
    if (kodesController.text.isNotEmpty) {
      if (namasController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = null;
        data_insert['KODES'] = kodesController.text;
        data_insert['NAMAS'] = namasController.text;
        data_insert['ALAMAT'] = alamatController.text;
        data_insert['KOTA'] = kotaController.text;
        data_insert['TELPON1'] = telpon1Controller.text;
        data_insert['FAX'] = faxController.text;
        data_insert['HP'] = hpController.text;
        data_insert['KONTAK'] = kontakController.text;
        data_insert['EMAIL'] = emailController.text;
        data_insert['NPWP'] = npwpController.text;
        data_insert['KET'] = ketController.text;
        data_insert['BLACNOA'] = blacnoaController.text;
        data_insert['BLACNOB'] = blacnobController.text;
        data_insert['BANK'] = bankController.text;
        data_insert['BANK_CAB'] = bank_cabController.text;
        data_insert['BANK_KOTA'] = bank_kotaController.text;
        data_insert['BANK_NAMA'] = bank_namaController.text;
        data_insert['BANK_REK'] = bank_rekController.text;
        data_insert['LIM'] = limController.text;
        data_insert['HARI'] = hariController.text;
        data_insert['TYP'] = typController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_supplier().insert_data_supplier(data_insert);
        Toast("Success !!", "Berhasil menambah supplier !", true);
        ambil_supplier();
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode supplier !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama supplier !", false);
      return false;
    }
  }

  Future<bool> edit_supplier(var id) async {
    if (kodesController.text.isNotEmpty) {
      if (namasController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODES'] = kodesController.text;
        data_insert['NAMAS'] = namasController.text;
        data_insert['ALAMAT'] = alamatController.text;
        data_insert['KOTA'] = kotaController.text;
        data_insert['TELPON1'] = telpon1Controller.text;
        data_insert['FAX'] = faxController.text;
        data_insert['HP'] = hpController.text;
        data_insert['KONTAK'] = kontakController.text;
        data_insert['EMAIL'] = emailController.text;
        data_insert['NPWP'] = npwpController.text;
        data_insert['KET'] = ketController.text;
        data_insert['BLACNOA'] = blacnoaController.text;
        data_insert['BLACNOB'] = blacnobController.text;
        data_insert['BANK'] = bankController.text;
        data_insert['BANK_CAB'] = bank_cabController.text;
        data_insert['BANK_KOTA'] = bank_kotaController.text;
        data_insert['BANK_NAMA'] = bank_namaController.text;
        data_insert['BANK_REK'] = bank_rekController.text;
        data_insert['LIM'] = limController.text;
        data_insert['HARI'] = hariController.text;
        data_insert['TYP'] = typController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        print(data_insert);
        await model_supplier().update_data_supplier_by_id(data_insert);
        ambil_supplier();
        Toast("Success !!", "Berhasil Mengedit Supplier !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode supplier !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama supplier !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_supplier().delete_supplier_byID(data['NO_ID'].toString());
    selectData("");
  }
}
