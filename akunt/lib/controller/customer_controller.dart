import 'package:akunt/model/model_satuan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:akunt/model/model_customer.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CustomerController with ChangeNotifier {
  //paginate
  bool proses = false;
  List data_customerList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_customer m_customer = model_customer();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_customer() async {
    data_customerList = await model_customer().data_customer_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_customerList = await model_customer().cari_customer(cari);
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
    data_customerList = await m_customer.data_customerpaginate(
        searchController.text, offset, limit);
    var count = await m_customer.countCustomerPaginate(searchController.text);
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
    data_customerList = await model_customer().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_customerList = await model_customer().cari_customer(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah customer
  TextEditingController kodecController = TextEditingController();
  TextEditingController namacController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController telpon1Controller = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController bank_namaController = TextEditingController();
  TextEditingController bank_rekController = TextEditingController();
  TextEditingController bank_cabController = TextEditingController();
  TextEditingController bank_kotaController = TextEditingController();
  TextEditingController pkpController = TextEditingController();
  TextEditingController npwpController = TextEditingController();
  TextEditingController barangController = TextEditingController();
  TextEditingController diskonController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController aktController = TextEditingController();
  DateTime chooseDate = DateTime.now();
  final format_tanggal = new DateFormat("d-M-y");
  String satuan_barang = "";
  List<DropdownMenuItem<String>> dropdownList_satuan_barang;

  Future<void> init_add_customer() async {
    satuan_barang = "";
    // await data_satuan_barang();
  }

  Future<void> init_edit_customer(var data_customer) async {
    kodecController.text = data_customer['KODEC'] ?? "";
    namacController.text = data_customer['NAMAC'] ?? "";
    alamatController.text = data_customer['ALAMAT'] ?? "";
    kotaController.text = data_customer['KOTA'] ?? "";
    telpon1Controller.text = data_customer['TELPON1'] ?? "";
    hpController.text = data_customer['HP'] ?? "";
    faxController.text = data_customer['FAX'] ?? "";
    kontakController.text = data_customer['KONTAK'] ?? "";
    emailController.text = data_customer['EMAIL'] ?? "";
    bankController.text = data_customer['BANK'] ?? "";
    bank_namaController.text = data_customer['BANK_NAMA'] ?? "";
    bank_rekController.text = data_customer['BANK_REK'] ?? "";
    bank_cabController.text = data_customer['BANK_CAB'] ?? "";
    bank_kotaController.text = data_customer['BANK_KOTA'] ?? "";
    pkpController.text = data_customer['PKP'] ?? "";
    npwpController.text = data_customer['NPWP'] ?? "";
    barangController.text = data_customer['BARANG'] ?? "";
    diskonController.text = data_customer['DISKON'] ?? "";
    hargaController.text = data_customer['HARGA'] ?? "";
    aktController.text = data_customer['AKT'] ?? "";
    bool cek_satuan = await model_satuan()
        .cek_data_satuan(data_customer['KOTA'].toString().toLowerCase());
    if (cek_satuan == true) {
      satuan_barang = data_customer['KOTA'].toString();
    } else {
      satuan_barang = "";
    }
    notifyListeners();
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
    kodecController.clear();
    namacController.clear();
    alamatController.clear();
    kotaController.clear();
    telpon1Controller.clear();
    hpController.clear();
    faxController.clear();
    kontakController.clear();
    emailController.clear();
    bankController.clear();
    bank_namaController.clear();
    bank_rekController.clear();
    bank_cabController.clear();
    bank_kotaController.clear();
    pkpController.clear();
    npwpController.clear();
    barangController.clear();
    diskonController.clear();
    hargaController.clear();
    aktController.clear();
  }

  Future<bool> daftar_customer() async {
    if (kodecController.text.isNotEmpty) {
      if (namacController.text.isNotEmpty) {
        if (bankController.text.isNotEmpty) {
          BotToast.showLoading();
          Map data_insert = new Map();
          data_insert['NO_ID'] = null;
          data_insert['KODEC'] = kodecController.text;
          data_insert['NAMAC'] = namacController.text;
          data_insert['ALAMAT'] = alamatController.text;
          data_insert['KOTA'] = kotaController.text;
          data_insert['TELPON1'] = telpon1Controller.text;
          data_insert['HP'] = hpController.text;
          data_insert['FAX'] = faxController.text;
          data_insert['KONTAK'] = kontakController.text;
          data_insert['EMAIL'] = emailController.text;
          data_insert['BANK'] = bankController.text;
          data_insert['BANK_NAMA'] = bank_namaController.text;
          data_insert['BANK_REK'] = bank_rekController.text;
          data_insert['BANK_CAB'] = bank_cabController.text;
          data_insert['BANK_KOTA'] = bank_kotaController.text;
          data_insert['PKP'] = pkpController.text;
          data_insert['NPWP'] = npwpController.text;
          data_insert['BARANG'] = barangController.text;
          data_insert['DISKON'] = diskonController.text;
          data_insert['HARGA'] = hargaController.text;
          data_insert['AKT'] = aktController.text;
          await model_customer().insert_data_customer(data_insert);
          Toast("Success !!", "Berhasil menambah customer !", true);
          ambil_customer();
          BotToast.closeAllLoading();
          return true;
        } else {
          Toast("Peringatan !", "Silahkan isi Kode Bank !", false);
          return false;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi Nama Bank !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi Kode Customer !", false);
      return false;
    }
  }

  Future<bool> edit_customer(var id) async {
    if (kodecController.text.isNotEmpty) {
      if (namacController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_ID'] = id;
        data_insert['KODEC'] = kodecController.text;
        data_insert['NAMAC'] = namacController.text;
        data_insert['ALAMAT'] = alamatController.text;
        data_insert['KOTA'] = kotaController.text;
        data_insert['TELPON1'] = telpon1Controller.text;
        data_insert['HP'] = hpController.text;
        data_insert['FAX'] = faxController.text;
        data_insert['KONTAK'] = kontakController.text;
        data_insert['EMAIL'] = emailController.text;
        data_insert['BANK'] = bankController.text;
        data_insert['BANK_NAMA'] = bank_namaController.text;
        data_insert['BANK_REK'] = bank_rekController.text;
        data_insert['BANK_CAB'] = bank_cabController.text;
        data_insert['BANK_KOTA'] = bank_kotaController.text;
        data_insert['PKP'] = pkpController.text;
        data_insert['NPWP'] = npwpController.text;
        data_insert['BARANG'] = barangController.text;
        data_insert['DISKON'] = diskonController.text;
        data_insert['HARGA'] = hargaController.text;
        data_insert['AKT'] = aktController.text;
        await model_customer().update_data_customer_by_id(data_insert);
        ambil_customer();
        Toast("Success !!", "Berhasil Mengedit Customer !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi kode customer !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama customer !", false);
      return false;
    }
  }

  Future<bool> hapus_akun(var data) async {
    await model_customer().delete_customer_byID(data['NO_ID'].toString());
    selectData("");
  }
}
