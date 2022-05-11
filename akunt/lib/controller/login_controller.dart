import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/model_staff.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  bool mode_login = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  TextEditingController usernameLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  static String nama_staff = "";
  static String akun_staff = "";
  String email_staff = "";
  int role_staff;

  void initData() async {
    mode_login = true;
    prefs = await _prefs;
    if (!prefs.containsKey("host")) {
      prefs.setString("host", "localhost");
    } else {
      hostController.text = prefs.getString("host");
    }
    if (!prefs.containsKey("port")) {
      prefs.setInt("port", 3306);
    } else {
      portController.text = prefs.getInt("port").toString();
    }
    if (!prefs.containsKey("user")) {
      prefs.setString("user", "root");
    } else {
      userController.text = prefs.getString("user");
    }
    if (!prefs.containsKey("password")) {
      prefs.setString("password", "");
    } else {
      passwordController.text = prefs.getString("password");
    }
    if (!prefs.containsKey("db")) {
      prefs.setString("db", "");
    } else {
      dbNameController.text = prefs.getString("db");
    }
    usernameLogin.clear();
    passwordLogin.clear();
  }

  Future<bool> getLogin() async {
    try {
      if (usernameLogin.text.isNotEmpty) {
        if (passwordLogin.text.isNotEmpty) {
          BotToast.showLoading();
          List data_user = await model_staff()
              .select_data_login(usernameLogin.text, passwordLogin.text);
          if (data_user.length > 0) {
            var obj_data = data_user[0];
            nama_staff = obj_data['USERNAME'].toString();
            akun_staff = obj_data['CREATE_BY'].toString();
            role_staff = int.tryParse(obj_data['ROLE'].toString());
            email_staff = obj_data['NA_DEV'].toString();
            BotToast.closeAllLoading();
            return true;
          } else {
            Toast(
                "Login Gagal !", "Username atau password tidak sesuai", false);
            BotToast.closeAllLoading();
            return false;
          }
        } else {
          Toast("Peringatan", "Silahkan isi password Anda !", false);
          BotToast.closeAllLoading();
          return false;
        }
      } else {
        Toast("Peringatan", "Silahkan isi username Anda !", false);
        BotToast.closeAllLoading();
        return false;
      }
    } catch (e) {
      // Toast("Peringatan", "Silahkan Perikasa Konfigurasi Database anda", false);
      Toast("Peringatan", e.toString(), false);
      BotToast.closeAllLoading();
      return false;
    }
  }

  //variable setting connection
  TextEditingController hostController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController dbNameController = TextEditingController();

  Future<void> simpan_setting(BuildContext context) async {
    try {
      prefs.setString("host", hostController.text);
      prefs.setString("user", userController.text);
      prefs.setString("password", passwordController.text);
      prefs.setInt("port", int.tryParse(portController.text) ?? 0);
      prefs.setString("db", dbNameController.text);
      var koneksi = await koneksi_mysql().koneksi();
      if (koneksi != null) {
        Toast("Connection Success !!", "", true);
        Navigator.pop(context);
      } else {
        Toast("Connection Failed !!", "Silahkan cek ulang konfigurasi anda !",
            false);
      }
    } catch (e) {
      Toast("Connection Failed !!", e.toString(), false);
    }
  }
}
