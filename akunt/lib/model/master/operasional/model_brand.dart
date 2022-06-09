import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_brand {
  String baseUrl = base_url;

  Future<List> modal_brand(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_brand"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
