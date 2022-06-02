import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/master/operasional/model_hs.dart';
import 'package:akunt/view/base_widget/toast.dart';

class HsController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_hsList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_hs m_hs = model_hs();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;
  String perx = '';
  String tgl = '';

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_hs() async {
    data_hsList = await model_hs().data_hs_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_hsList = await model_hs().cari_hs(cari);
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
    data_hsList =
        await m_hs.data_hspaginate(searchController.text, offset, limit);
    var count = await m_hs.countHsPaginate(searchController.text);
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
    data_hsList = await model_hs().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_hsList = await model_hs().cari_hs(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah brg
  TextEditingController no_hsController = TextEditingController();
  TextEditingController uraianController = TextEditingController();
  TextEditingController kd_satuanController = TextEditingController();
  TextEditingController kd_brgController = TextEditingController();
  TextEditingController kdjenisController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();

  Future<void> init_edit_hs(var data_user) async {
    no_hsController.text = data_user['NO_HS'];
    uraianController.text = data_user['URAIAN'];
    kd_satuanController.text = data_user['KD_SATUAN'];
    kd_brgController.text = data_user['KD_BRG'];
    kdjenisController.text = data_user['kdjenis'];
    usrnmController.text = data_user['USRNM'];
    tg_smpController.text = data_user['TG_SMP'].toString();
  }

  void resetField() {
    no_hsController.clear();
    uraianController.clear();
    kd_satuanController.clear();
    kd_brgController.clear();
    kdjenisController.clear();
    usrnmController.clear();
    tg_smpController.clear();
  }

  Future<bool> daftar_hs() async {
    if (no_hsController.text.isNotEmpty) {
      if (uraianController.text.isNotEmpty) {
        BotToast.showLoading();
        if (no_hsController.text.isNotEmpty) {
          if (data_hsList.length > 0) {
            BotToast.showLoading();
            var data_ready =
                await m_hs.check_hs(no_hsController.text, "NO_HS", "hs");
            if (data_ready.length > 0) {
              Toast("Peringatan !", "No HS '${no_hsController.text}' sudah ada",
                  false);
              BotToast.closeAllLoading();
              return false;
            } else {
              Map data_insert = new Map();
              data_insert['NO_HS'] = no_hsController.text;
              data_insert['URAIAN'] = uraianController.text;
              data_insert['KD_SATUAN'] = kd_satuanController.text;
              data_insert['KD_BRG'] = kd_brgController.text;
              data_insert['KDJENIS'] = kdjenisController.text;
              data_insert['USRNM'] = LoginController.nama_staff;
              data_insert['TG_SMP'] = DateTime.now();
              await model_hs().insert_data_hs(data_insert);
              Toast("Success !!", "Berhasil menambah data hs !", true);
              ambil_hs();
              BotToast.closeAllLoading();
              return true;
            }
          } else {
            Toast("Peringatan !", "Silahkan isi password !", false);
            return false;
          }
        } else {
          Toast("Peringatan !", "Silahkan isi nomor hs !", false);
          return false;
        }
      }
    }
  }

  Future<bool> edit_hs(var id) async {
    if (no_hsController.text.isNotEmpty) {
      if (uraianController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['NO_HS'] = no_hsController.text;
        data_insert['URAIAN'] = uraianController.text;
        data_insert['KD_SATUAN'] = kd_satuanController.text;
        data_insert['KD_BRG'] = kd_brgController.text;
        data_insert['KDJENIS'] = kdjenisController.text;
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_hs().update_data_hs_by_id(data_insert);
        ambil_hs();
        Toast("Success !!", "Berhasil update hs !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi uraian !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nomor hs !", false);
      return false;
    }
  }

  Future<bool> hapus_hs(var data) async {
    await model_hs().delete_hs_byID(data['ID_HS'].toString());
    selectData("");
  }
}
