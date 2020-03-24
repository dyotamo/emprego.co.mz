import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:prov/model.dart';

Future<List<CompanyModel>> fetchCompanies(page) async {
  var uri = Uri.https('ymarket.herokuapp.com', '/company/',
      {'page': '${page + 1}', 'limit': '20'});

  var response = await http.get(uri);
  return compute(_parseJson, response.body);
}

Future<List<CompanyModel>> searchCompanies(query) async {
  var uri =
      Uri.https('ymarket.herokuapp.com', '/company/', {'name': '%$query%'});

  var response = await http.get(uri);
  return compute(_parseJson, response.body);
}

List<CompanyModel> _parseJson(body) {
  List list = jsonDecode(body)['resources'];
  return list.map((json) => CompanyModel.fromJson(json)).toList();
}
