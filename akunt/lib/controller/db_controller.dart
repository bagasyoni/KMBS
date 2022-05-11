import 'package:flutter/cupertino.dart';
import 'package:akunt/mysql/model_create_db.dart';

class db_controller extends ChangeNotifier {
  //proses create database
  Future<void> create_tabel() async {
    await model_create_db().buat_tabel_jual_beli();
    notifyListeners();
  }
}
