// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_laphutbahan {
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String TGL_1, String TGL_2, String sup_a, String sup_b) async {
    var data_whr = {
      "tgl_a": TGL_1,
      "tgl_b": TGL_2,
      "sup_a": sup_a,
      "sup_b": sup_b,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_hutbahan"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }
}
