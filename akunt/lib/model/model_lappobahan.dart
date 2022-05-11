// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_lappobahan {
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String TGL_1, String TGL_2, String NAMAS_A, String NAMAS_B, String BAHAN_A, String BAHAN_B) async {
    var data_whr = {
      "tgl_a": TGL_1,
      "tgl_b": TGL_2,
      "namas_a": NAMAS_A,
      "namas_b": NAMAS_B,
      "bahan_a": BAHAN_A,
      "bahan_b": BAHAN_B,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_pobahan"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }
}
