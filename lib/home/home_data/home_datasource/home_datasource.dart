import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fedis_mockup_demo/home/home_data/models/ServicesDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

class HomeDataSource {
  final Dio dio;

  HomeDataSource(this.dio);

  Future<List<ProductDataModel>> readJsonData() async {
    // Load JSON string from assets
    final jsonString = await rootBundle.rootBundle.loadString('assets/services/services.json');

    // Decode JSON into a Map because it has a root key "services"
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Extract the list from the "services" key
    final List<dynamic> jsonList = jsonData['services'];

    // Convert each item to ProductDataModel
    return jsonList.map((e) => ProductDataModel.fromJson(e)).toList();
  }

}