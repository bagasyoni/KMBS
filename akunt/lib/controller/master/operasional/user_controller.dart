import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/master/operasional/model_user.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_userList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_user m_user = model_user();
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

  Future<void> ambil_user() async {
    data_userList = await model_user().data_user_tampil('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_userList = await model_user().cari_user(cari);
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
    data_userList =
        await m_user.data_userpaginate(searchController.text, offset, limit);
    var count = await m_user.countUserPaginate(searchController.text);
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
    data_userList = await model_user().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_userList = await model_user().cari_user(cari);
    proses = false;
    notifyListeners();
  }

  //variable tambah brg
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController usrinController = TextEditingController();
  TextEditingController tg_inController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController tg_smpController = TextEditingController();
  TextEditingController aksesController = TextEditingController();

  Future<void> init_edit_user(var data_user) async {
    usernameController.text = data_user['Username'] ?? "";
    passwordController.text = data_user[''] ?? "";
    statusController.text = data_user['status'] ?? "";
    notesController.text = data_user['notes'] ?? "";
    usrinController.text = data_user['usrin'] ?? "";
    tg_inController.text = data_user['tg_in'].toString();
    usrnmController.text = data_user['usrnm'] ?? "";
    tg_smpController.text = data_user['tg_smp'].toString();
    aksesController.text = data_user['akses'] ?? "";
  }

  void resetField() {
    usernameController.clear();
    passwordController.clear();
    statusController.clear();
    notesController.clear();
    usrinController.clear();
    tg_inController.clear();
    usrnmController.clear();
    tg_smpController.clear();
    aksesController.clear();
  }

  Future<bool> daftar_user() async {
    if (usernameController.text.isNotEmpty) {
      if (passwordController.text.isNotEmpty) {
        BotToast.showLoading();
        if (usernameController.text.isNotEmpty) {
          if (data_userList.length > 0) {
            BotToast.showLoading();
            var data_ready = await m_user.check_username(
                usernameController.text, "Username", "users");
            if (data_ready.length > 0) {
              Toast("Peringatan !",
                  "Username '${usernameController.text}' sudah ada", false);
              BotToast.closeAllLoading();
              return false;
            } else {
              Map data_insert = new Map();
              data_insert['USERNAME'] = usernameController.text;
              data_insert['PASSWORD'] =
                  md5.convert(utf8.encode(passwordController.text)).toString();
              data_insert['STATUS'] = statusController.text;
              data_insert['NOTES'] = notesController.text;
              data_insert['USRIN'] = LoginController.nama_staff;
              data_insert['TG_IN'] = DateTime.now();
              data_insert['USRNM'] = LoginController.nama_staff;
              data_insert['TG_SMP'] = DateTime.now();
              await model_user().insert_data_user(data_insert);
              Toast("Success !!", "Berhasil menambah user !", true);
              ambil_user();
              BotToast.closeAllLoading();
              return true;
            }
          } else {
            Toast("Peringatan !", "Silahkan isi password !", false);
            return false;
          }
        } else {
          Toast("Peringatan !", "Silahkan isi username !", false);
          return false;
        }
      }
    }
  }

  Future<bool> edit_user(var id) async {
    if (usernameController.text.isNotEmpty) {
      if (passwordController.text.isNotEmpty) {
        BotToast.showLoading();
        Map data_insert = new Map();
        data_insert['USERNAME'] = usernameController.text;
        data_insert['PASSWORD'] =
            md5.convert(utf8.encode(passwordController.text)).toString();
        data_insert['STATUS'] = statusController.text;
        data_insert['NOTES'] = notesController.text;
        data_insert['USRIN'] = LoginController.nama_staff;
        data_insert['TG_IN'] = DateTime.now();
        data_insert['USRNM'] = LoginController.nama_staff;
        data_insert['TG_SMP'] = DateTime.now();
        await model_user().update_data_user_by_id(data_insert);
        ambil_user();
        Toast("Success !!", "Berhasil update user !", true);
        BotToast.closeAllLoading();
        return true;
      } else {
        Toast("Peringatan !", "Silahkan isi password !", false);
        return false;
      }
    } else {
      Toast("Peringatan !", "Silahkan isi nama username !", false);
      return false;
    }
  }

  Future<bool> hapus_user(var data) async {
    await model_user().delete_user_byID(data['NO_ID'].toString());
    selectData("");
  }
}
