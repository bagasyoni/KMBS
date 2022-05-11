import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../constants.dart';

class model_stok {
  static String table = 'stok';
  // koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_stok(String cari) async {
    ///////API NODE
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_koreksi_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> serach_stok(String stok) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek
    //     .query("select * from $table where no_bukti like '%$stok%' ;");
    // await konek.close();
    // return results2.toList();

    ///////API NODE
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_koreksi_stok"),
      body: {"cari": stok},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> noUrutKoreksiStok(
      String jenis, String paramtabel, String paramkolom) async {
    // var konek = await m_koneksi.koneksi();
    // var result = await konek
    //     .query("SELECT NO_BUKTI FROM $table where TGL like '$date%';");
    // await konek.close();
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": jenis, "tabel": paramtabel, "kolom": paramkolom},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_stok(Map data_insert) async {
    //////API NODE
    final response = await http
        .post(Uri.parse("${baseUrl}:3000/tambah_koreksi_stok"), body: {
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "NOTES": data_insert['NOTES'],
      "HARGA": data_insert['HARGA'].toString(),
      "TOTAL": data_insert['TOTAL'].toString()
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> get_data_stok(String nobukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 =
    //     await konek.query("select * from $table where no_bukti = '$nobukti';");
    // await konek.close();
    // return results2.toList();
  }

  Future<List> select_stok(
      String cari, String start_date, String end_date) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek.query(
    //     "select * from $table where TGL between '$start_date' and '$end_date' and (NO_BUKTI like '%$cari%');");
    // await konek.close();
    // return results2.toList();
  }

  Future<bool> update_stok_by_id(Map data_insert) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek.query("update $table set "
    //     "no_bukti ='${data_insert['no_bukti']}',"
    //     " tanggal = '${data_insert['tanggal']}',"
    //     " kd_brg = '${data_insert['kd_brg']}',"
    //     " na_brg = '${data_insert['na_brg']}',"
    //     " ket = '${data_insert['ket']}', "
    //     " qty = '${data_insert['qty']}' "
    //     " where no_id = '${data_insert['id']}'");
    // await konek.close();
    // return results2.toList();
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_koreksi_stok"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "NOTES": data_insert['NOTES'],
      "HARGA": data_insert['HARGA'].toString(),
      "TOTAL": data_insert['TOTAL'].toString()
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_stok(String NO_BUKTI) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 =
    //     await konek.query("delete from $table where no_bukti = '$no_bukti';");
    // await konek.close();
    // return results2.toList();

    ///////API PHP
    // final response = await http.post(
    //   Uri.parse(
    //       "https://edompetiaragatzuonline.com/flutterjualbeli/stok.php/hapus"),
    //   body: {"NO_BUKTI": NO_BUKTI},
    // );
    // var results2 = json.decode(response.body);
    // return results2.toList();

    ///////API NODE
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_koreksi_stok"),
      body: {"nobukti": NO_BUKTI},
    );
  }
}
