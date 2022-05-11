import 'package:akunt/mysql/koneksi_mysql.dart';

class model_barang {
  static String table = 'master_barang';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<List> data_barang() async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query('select * from ' + table);
    await konek.close();
    return results2.toList();
  }

  Future<List> insert_data_barang(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query(
        'insert into ' +
            table +
            ' (id,kd_brg,na_brg,harga_beli,harga_jual,satuan,stok) values (?, ?, ?, ?, ?, ?, ?)',
        [
          0,
          data_insert['kd_brg'],
          data_insert['na_brg'],
          data_insert['harga_beli'],
          data_insert['harga_jual'],
          data_insert['satuan'],
          data_insert['stok'],
        ]);
    await konek.close();
    return results2.toList();
  }

  Future<List> get_data_barang(String kd_brg) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where kd_brg = '$kd_brg';");
    await konek.close();
    return results2.toList();
  }

  Future<List> serach_barang(String kd_brg) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query(
        "select * from $table where kd_brg like '%$kd_brg%' or na_brg like '%$kd_brg%';");
    await konek.close();
    return results2.toList();
  }

  Future<List> update_barang_by_id(Map data_insert) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek.query("update $table set "
        "na_brg ='${data_insert['na_brg']}',"
        " kd_brg = '${data_insert['kd_brg']}',"
        " harga_beli = '${data_insert['harga_beli']}',"
        " harga_jual = '${data_insert['harga_jual']}',"
        " satuan = '${data_insert['satuan']}',"
        " stok = '${data_insert['stok']}' "
        " where id = '${data_insert['id']}'");
    await konek.close();
    return results2.toList();
  }

  Future<List> delete_barang_byKode(String kd_brg) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("delete from $table where kd_brg = '$kd_brg';");
    await konek.close();
    return results2.toList();
  }
}
