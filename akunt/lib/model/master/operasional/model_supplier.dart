import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_supplier {
  String baseUrl = base_url;

  Future<List> cari_supplier(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carisup"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_supplier_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilsup"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_suppaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/suppaginate"),
      body: {
        "cari": cari,
        "offset": paramoffset.toString(),
        "limit": paramlimit.toString()
      },
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///paginate
  Future countSupPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countsuppaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_sup_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_supplier(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahsup"), body: {
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "FAX": data_insert['FAX'],
      "HP": data_insert['HP'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "NPWP": data_insert['NPWP'],
      "KET": data_insert['KET'],
      "BLACNOA": data_insert['BLACNOA'],
      "BLACNOB": data_insert['BLACNOB'],
      "BANK": data_insert['BANK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "LIM": data_insert['LIM'].toString(),
      "HARI": data_insert['HARI'].toString(),
      "TYP": data_insert['TYP'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_supplier_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahsup"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "FAX": data_insert['FAX'],
      "HP": data_insert['HP'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "NPWP": data_insert['NPWP'],
      "KET": data_insert['KET'],
      "BLACNOA": data_insert['BLACNOA'],
      "BLACNOB": data_insert['BLACNOB'],
      "BANK": data_insert['BANK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "LIM": data_insert['LIM'].toString(),
      "HARI": data_insert['HARI'].toString(),
      "TYP": data_insert['TYP'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_supplier_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapussup"),
      body: {"NO_ID": id},
    );
  }
}
