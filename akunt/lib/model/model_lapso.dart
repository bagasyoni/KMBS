// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_lapso {
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String TGL_1, String TGL_2, String cus_a, String cus_b,
      String brg_a, String brg_b) async {
    var data_whr = {
      "tgl_a": TGL_1,
      "tgl_b": TGL_2,
      "cus_a": cus_a,
      "cus_b": cus_b,
      "brg_a": brg_a,
      "brg_b": brg_b,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_so"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }
}
