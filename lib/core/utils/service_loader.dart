import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fedis_mockup_demo/home/home_data/models/ServicesDataModel.dart';

Future<Service?> loadSignupService() async {
  final String jsonString = await rootBundle.loadString('assets/services/services.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final services = (jsonMap['services'] as List)
      .map((s) => Service.fromJson(s))
      .toList();

  return services.isNotEmpty ? services.first : null;
}