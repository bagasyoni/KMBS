import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:akunt/model/model_mesin.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MesinController with ChangeNotifier {
  ///paginate
  bool proses = false;
  List data_mesinList = [];
  TextEditingController c_page = new TextEditingController();
  TextEditingController searchController = TextEditingController();
  model_mesin m_mesin = model_mesin();
  List<DropdownMenuItem<int>> dropdownLimit;
  int totalNotaTerima = 0;
  int offset = 0;
  int limit = 50;
  double pageCount = 1;
  int page_index = 0;

  void setProses(bool proses) {
    this.proses = proses;
  }

  Future<void> ambil_mesin() async {
    data_mesinList = await model_mesin().data_mesincari('');
    proses = false;
    notifyListeners();
  }

  void selectData(String cari) async {
    data_mesinList = await model_mesin().cari_mesin(cari);
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
    data_mesinList =
        await m_mesin.data_mesinpaginate(searchController.text, offset, limit);
    var count = await m_mesin.countMesinPaginate(searchController.text);
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
    data_mesinList = await model_mesin().data_modal(cari);
    notifyListeners();
  }

  Future<void> search(var cari) async {
    data_mesinList = await model_mesin().cari_mesin(cari);
    proses = false;
    notifyListeners();
  }
}
