import 'package:akunt/controller/login_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/master/operasional/model_brand.dart';
import 'package:akunt/view/base_widget/toast.dart';

class BrandController with ChangeNotifier {
  bool proses = false;
  List data_brandList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_brand m_brand = model_brand();
  List<DropdownMenuItem<int>> dropdownLimit;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  String perx = '';
  String tgl = '';

  void modalData(String cari) async {
    data_brandList = await model_brand().modal_brand(cari);
    notifyListeners();
  }
}
