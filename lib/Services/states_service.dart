import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/Worldstats.dart';

class StateServices {
  Future<Worldstats> getWorldStat() async {
    final response = await http.get(Uri.parse(AppUrl.worldstateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Worldstats.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> getCountryStat() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("error");
    }
  }
}
