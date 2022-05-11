import 'package:akunt/view/printing/printer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_customer {
  static String table = 'cust';
  String baseUrl = base_url;

  Future<List> cari_customer(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caricus"),
      body: {"cari": key_cari},
    );
    var result2 = json.decode(response.body);
    return result2['data'].toList();
  }

  Future<List> data_customer_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilcus"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_customerpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cuspaginate"),
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
  Future countCustomerPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countcuspaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caricus"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_customer(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahcus"), body: {
      "KODEC": data_insert['KODEC'],
      "NAMAC": data_insert['NAMAC'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "HP": data_insert['HP'],
      "FAX": data_insert['FAX'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "BANK": data_insert['BANK'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "PKP": data_insert['PKP'],
      "NPWP": data_insert['NPWP'],
      "BARANG": data_insert['BARANG'],
      "DISKON": data_insert['DISKON'],
      "HARGA": data_insert['HARGA'],
      "AKT": data_insert['AKT']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_customer_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahcus"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODEC": data_insert['KODEC'],
      "NAMAC": data_insert['NAMAC'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "HP": data_insert['HP'],
      "FAX": data_insert['FAX'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "BANK": data_insert['BANK'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "PKP": data_insert['PKP'],
      "NPWP": data_insert['NPWP'],
      "BARANG": data_insert['BARANG'],
      "DISKON": data_insert['DISKON'],
      "HARGA": data_insert['HARGA'],
      "AKT": data_insert['AKT']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_customer_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapuscus"),
      body: {"NO_ID": id},
    );
  }
}
