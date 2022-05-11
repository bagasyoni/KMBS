import 'package:akunt/constants.dart';
import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class model_staff {
  static String table = 'users';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_staff() async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query('select * from ' + table);
    await konek.close();
    return results2.toList();
  }

  Future<List> get_data_staff(String username) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where username = '$username';");
    await konek.close();
    return results2.toList();
  }

  Future<List> select_data_login(String username, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/login"),
      body: {"username": username, "password": password},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_data_staff(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query(
        'insert into ' +
            table +
            ' (id,nama,alamat,no_tlp,username,password,keterangan,role) values (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data_insert['id'],
          data_insert['nama'],
          data_insert['alamat'],
          data_insert['no_tlp'],
          data_insert['username'],
          data_insert['password'],
          data_insert['keterangan'],
          data_insert['role'],
        ]);
    await konek.close();
    return results2.toList();
  }

  Future<List> update_data_staff_by_id(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query("update $table set "
        "nama ='${data_insert['nama']}',"
        " alamat = '${data_insert['alamat']}',"
        " no_tlp = '${data_insert['no_tlp']}',"
        " username = '${data_insert['username']}',"
        " password = '${data_insert['password']}',"
        " keterangan = '${data_insert['keterangan']}',"
        " role = '${data_insert['role']}'"
        " where id = '${data_insert['id']}'");
    await konek.close();
    return results2.toList();
  }

  Future<List> delete_staff_byUsername(String username) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("delete from $table where username = '$username';");
    await konek.close();
    return results2.toList();
  }
}
