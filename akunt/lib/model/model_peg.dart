// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class model_peg {
  static String table = 'peg';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_pegcari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilpeg"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_peg() async {
    final response = await http.post(
      Uri.parse("${baseUrl}/noto_rest-api/Master/indekPeg"),
      body: {"tabel": "peg"},
    );
    var results2 = json.decode(response.body);
    print(results2);
    return results2.toList();
  }

  Future<List> get_data_peg(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("SELECT * FROM $table WHERE NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_peg(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahpeg"), body: {
      "KD_PEG": data_insert['KD_PEG'],
      "NA_PEG": data_insert['NA_PEG'],
      "GAJI": data_insert['GAJI']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_peg_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahpeg"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_PEG": data_insert['KD_PEG'],
      "NA_PEG": data_insert['NA_PEG'],
      "GAJI": data_insert['GAJI']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_peg_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapuspeg"),
      body: {"NO_ID": id},
    );
  }
}
