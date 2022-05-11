import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_gudang {
  static String table = 'gdg';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> cari_gudang(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carigud"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_gudangcari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilgud"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///paginate
  Future countGudangPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countgudpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_gudangpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/gudpaginate"),
      body: {
        "cari": cari,
        "offset": paramoffset.toString(),
        "limit": paramlimit.toString()
      },
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  // ///tidak dipakai ??
  // Future<List> data_gudang() async {
  //   final response = await http.post(
  //     Uri.parse("${baseUrl}/noto_rest-api/Master/indexBrg"),
  //   );
  //   var results2 = json.decode(response.body);
  //   return results2.toList();
  // }

  Future<List> get_data_gudang(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_gudang(Map data_insert) async {
    final response = await http.post(Uri.parse("${baseUrl}:3000/tambahgud"),
        body: {"KODE": data_insert['KODE'], "NAMA": data_insert['NAMA']});
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_gudang_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahgud"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_gudang_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusgud"),
      body: {"NO_ID": id},
    );
  }
}
