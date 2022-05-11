// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_lapkartustk_bhn {
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String per, String kode1, String kode2) async {
    print(per);
    var data_whr = {
      "per": per,
      "kode1": kode1,
      "kode2": kode2,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_kartustk_bhn"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }
}
