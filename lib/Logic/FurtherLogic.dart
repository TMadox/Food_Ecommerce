import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:test_store/Logic/StateManagement.dart';

class FutherLogic {
  Future<void> readJson(BuildContext context) async {
    final String citiesResponse =
        await rootBundle.loadString('Files/cities.json');
    final String governatesResponse =
        await rootBundle.loadString("Files/governorates.json");
    final cities = await json.decode(citiesResponse);
    final governates = await json.decode(governatesResponse);
    context
        .read(generalmanagment)
        .setCitiesandGovernates(cities[2]["data"], governates[2]["data"]);
  }
}
