import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_lapstocka {
  String baseUrl = base_url;

  Future<List> data_lap(String PER, String TGL_1, String TGL_2) async {
    var data_whr = {
      "per": PER,
      "tgla": TGL_1,
      "tglb": TGL_2,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_stocka"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }

  Future print_data(String PER, String TGL_1, String TGL_2) async {
    await http.post(
      Uri.parse(
          "http://26.162.162.191/KMBS/KMBS/kmbs_php/report/Laporan_Stockbhn.php"),
      body: {"PER": PER, "TGL_1": TGL_1, "TGL_2": TGL_2},
    );
  }
}
