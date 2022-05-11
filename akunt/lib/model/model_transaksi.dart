// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unused_local_variable, missing_return, avoid_print, avoid_function_literals_in_foreach_calls

import '../mysql/koneksi_mysql.dart';

class ModelTransaksi {
  static String table = 'order_pembelian';
  static String table_detail = 'detail_barang_order_pembelian';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<List> delete_trans(String tabel, String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results1 =
        await konek.query("delete from ${tabel} where no_bukti = '$no_bukti';");
    var results2 = await konek
        .query("delete from ${tabel}d where no_bukti = '$no_bukti';");
    await konek.close();
    return results2.toList();
  }

  Future<List> insert_data(
      String tabel, Map data_insert, List data_insertd) async {
    dynamic a, b, x, z = '';
    var y = <String>[];
    var q = 0;
    data_insert.forEach((k, v) {
      if (q == 0) {
        x = k;
        z = '?';
      } else {
        x = x + ',' + k;
        z = z + ',?';
      }
      y.add(v);
      q++;
    });
    Map field = data_insertd[0];
    q = 0;
    field.forEach((k, v) {
      if (q == 0) {
        a = k;
        b = '?';
      } else {
        a = a + ',' + k;
        b = b + ',?';
      }
      q++;
    });
    var s = <dynamic>[];
    dynamic d = [];
    data_insertd.forEach((v) {
      v.forEach((k, v) {
        s.add(v);
      });
      d.add(s);
    });

    try {
      // print(data_insert['barang']);
      var konek = await m_koneksi.koneksi();
      var results1 = await konek.query(
          'insert into ' + tabel + ' (' + x + ') values (' + z + ')', y);
      List data_barang = data_insert['barang'];
      await konek.queryMulti(
          'insert into ${tabel}d (' + a + ') values (' + b + ')', d);
      await konek.close();
      return results1.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_data(
      Map data_insert, List data_insertd, Map data_where, String tabel) async {
    //Untuk Update Header
    dynamic x = '';
    var q = 0;
    data_insert.forEach((k, v) {
      if (q == 0) {
        x = k + " = '" + v + "'";
      } else {
        x = x + ', ' + k + " = '" + v + "'";
      }
      q++;
    });

    dynamic z = '';
    q = 0;
    data_where.forEach((k, v) {
      if (q == 0) {
        z = k + " = '" + v + "'";
      } else {
        z = x + ' and ' + k + " = '" + v + "'";
      }
      q++;
    });
    /////////////////////////////////////
    try {
      var konek = await m_koneksi.koneksi();
      await konek.query(
          "delete from $table_detail where no_bukti ='${data_insert['no_bukti']}' ;");

      var results1 = await konek.query("update $tabel set $x where $z ;");

      var datax = await konek.query(
          "select b.no_id from $tabel a,${tabel}d b where a.no_id=b.id and $z;");
      List datad = datax.toList();

      dynamic dtx = '';
      dynamic dty = '';
      datad.forEach((e) async {
        dtx = e['no_id'];
        dty = data_insertd.indexWhere((element) => element['no_id'] == dtx);
        if (dty != '') {
          q = 0;
          data_insertd[dty].forEach((k, v) {
            if (q == 0) {
              x = k + " = '" + v + "'";
            } else {
              x = x + ', ' + k + " = '" + v + "'";
            }
            q++;
          });
          await konek.query("update ${tabel}d set $x where no_id='$dtx' ;");
        } else {
          await konek.query("delete from ${tabel}d where no_id='$dtx' ;");
        }
      });

      data_insertd.forEach((element) async {
        if (element['no_id'] == '0') {
          q = 0;
          element.forEach((k, v) {
            if (q == 0) {
              x = k;
              z = "'$v'";
            } else {
              x = x + ',' + k;
              z = z + ",'$v'";
            }
            q++;
          });
          await konek
              .query('insert into ${tabel}d (' + x + ') values (' + z + ')');
        }
      });
      await konek.close();
      return results1.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countOrderPembelian(String date) async {
    var konek = await m_koneksi.koneksi();
    var result = await konek
        .query("SELECT no_bukti FROM $table where tanggal like '$date%';");
    await konek.close();
    return result.toList();
  }

  Future<List> get_no_bukti(String kode) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where no_bukti = '$kode';");
    await konek.close();
    return results2.toList();
  }

  Future<List> data_index(String tabel, String whr) async {
    print(whr);
    var konek = await m_koneksi.koneksi();
    var results2 = await konek
        .query("select * from $tabel where $whr order by tg_smp desc");
    await konek.close();
    return results2.toList();
  }

  Future<List> data_lap(String query) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query(query);
    await konek.close();
    return results2.toList();
  }

  Future<List> select_order_pembelian_aktif(String cari, String sales,
      String supplier, String start_date, String end_date) async {
    var konek = await m_koneksi.koneksi();
    String filter_extra = "";
    if (sales.isNotEmpty) {
      filter_extra = " and sales = '$sales' ";
    }
    if (supplier.isNotEmpty) {
      filter_extra += " and supplier = '$supplier' ";
    }
    var results2 = await konek.query(
        "select * from $table where (no_bukti like '%$cari%' or supplier like '%$cari%' or sales like '%$cari%') $filter_extra and status = '1' and tanggal between '$start_date' and '$end_date';");
    await konek.close();
    return results2.toList();
  }

  Future<List> select_order_pembelian_detail(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek
        .query("select * from $table_detail where no_bukti = '$no_bukti';");
    await konek.close();
    return results2.toList();
  }

  Future<List> update_total_used(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results = await konek.query(
        "update $table set total_used = total_used + 1 where no_bukti = '$no_bukti';");
    await konek.close();
    return results.toList();
  }
}
