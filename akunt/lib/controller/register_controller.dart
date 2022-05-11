import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/model_staff.dart';
import 'package:akunt/view/base_widget/toast.dart';

class RegisterController with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  String jenis_jabatan = "";
  List<DropdownMenuItem<String>> dropdownList_jabatan;

  void initData() async {
    dropdownList_jabatan = [];
    dropdownList_jabatan
        .add(new DropdownMenuItem(value: "1", child: new Text("Manajer")));
    dropdownList_jabatan
        .add(new DropdownMenuItem(value: "2", child: new Text("Staff PBL")));
    dropdownList_jabatan
        .add(new DropdownMenuItem(value: "3", child: new Text("Staff PJL")));
    jenis_jabatan = dropdownList_jabatan[0].value;
  }

  void resetField() {
    usernameController.clear();
    namaController.clear();
    passwordController.clear();
    hpController.clear();
  }

  Future<bool> daftar_akun() async {
    try {
      if (usernameController.text.isNotEmpty) {
        if (passwordController.text.isNotEmpty) {
          if (namaController.text.isNotEmpty) {
            BotToast.showLoading();
            List data_ready =
                await model_staff().get_data_staff(usernameController.text);
            if (data_ready.length > 0) {
              Toast(
                  "Peringatan !",
                  "Username ${usernameController.text} sudah terdaftar !",
                  false);
              BotToast.closeAllLoading();
              return false;
            } else {
              Map data_insert = new Map();
              data_insert['id'] = null;
              data_insert['nama'] = namaController.text;
              data_insert['alamat'] = "";
              data_insert['no_tlp'] = hpController.text;
              data_insert['username'] = usernameController.text;
              data_insert['password'] = passwordController.text;
              data_insert['keterangan'] = 0;
              data_insert['role'] = jenis_jabatan;
              await model_staff().insert_data_staff(data_insert);
              Toast("Success !!", "Berhasil mendaftarkan akun !", true);
              BotToast.closeAllLoading();
              return true;
            }
          } else {
            Toast("Peringatan !", "Silahkan isi nama anda !", false);
            BotToast.closeAllLoading();
            return false;
          }
        } else {
          Toast("Peringatan !", "Silahkan isi password !", false);
          BotToast.closeAllLoading();
          return false;
        }
      } else {
        Toast("Peringatan !", "Silahkan isi Username !", false);
        BotToast.closeAllLoading();
        return false;
      }
    } catch (e) {
      print(e);
      Toast("Peringatan", "Silahkan Perikasa Konfigurasi Database anda", false);
      BotToast.closeAllLoading();
      return false;
    }
  }
}
