// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class model_lappakai {
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String TGL1, String TGL2) async {
    var data_whr = {
      "tgla": TGL1,
      "tglb": TGL2,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lap_pakai"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }
}
