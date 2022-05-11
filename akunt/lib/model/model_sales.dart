import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';

class model_sales {
  static String table = 'sup';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<List> data_sales(String cari) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        // await konek.query("select * from $table where KODES like '%$cari%' ;");
        await konek.query(
            "select distinct KODES, NAMAS from po where KODES like '%$cari%' order by KODES ;");
    await konek.close();
    return results2.toList();
  }

  Future<List> get_data_sales(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query("select * from $table where id = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<List> insert_data_sales(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query(
        'insert into ' +
            table +
            ' (id,nama,alamat,no_tlp,password,keterangan) values (?, ?, ?, ?, ?, ?)',
        [
          data_insert['id'],
          data_insert['nama'],
          data_insert['alamat'],
          data_insert['no_tlp'],
          data_insert['password'],
          data_insert['keterangan'],
        ]);
    await konek.close();
    return results2.toList();
  }

  Future<List> update_data_sales_by_id(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query("update $table set "
        "nama ='${data_insert['nama']}',"
        " alamat = '${data_insert['alamat']}',"
        " no_tlp = '${data_insert['no_tlp']}',"
        " password = '${data_insert['password']}',"
        " keterangan = '${data_insert['keterangan']}'"
        " where id = '${data_insert['id']}'");
    await konek.close();
    return results2.toList();
  }

  Future<List> delete_sales_byID(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query("delete from $table where id = '$id';");
    await konek.close();
    return results2.toList();
  }
}
