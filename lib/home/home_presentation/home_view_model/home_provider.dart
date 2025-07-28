import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/home/home_data/models/ServicesDataModel.dart';
import '../../home_data/home_datasource/home_datasource.dart';


class HomeProvider with ChangeNotifier {
  final HomeDataSource homeDataSource;

  HomeProvider({required this.homeDataSource});

  List<Service> _services = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Service> get services => _services;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchServices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _services = await HomeDataSource.loadServices();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
