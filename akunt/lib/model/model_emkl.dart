import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_emkl {
  static String table = 'mkl';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> cari_emkl(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cariemkl"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_emklcari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilemkl"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

    /// paginate
  Future<List> data_emklpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/emklpaginate"),
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
  Future countEmklPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countemklpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  // ///tidak dipakai ??
  // Future<List> data_emkl() async {
  //   final response = await http.post(
  //     Uri.parse("${baseUrl}/noto_rest-api/Master/indexBrg"),
  //   );
  //   var results2 = json.decode(response.body);
  //   return results2.toList();
  // }

  Future<List> get_data_emkl(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_emkl(Map data_insert) async {
    final response = await http.post(Uri.parse("${baseUrl}:3000/tambahemkl"),
        body: {"KODE": data_insert['KODE'], "NAMA": data_insert['NAMA']});
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_emkl_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahemkl"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_emkl_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusemkl"),
      body: {"NO_ID": id},
    );
  }
}
