import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_clinic_services.dart';

class PxServicesGet extends ChangeNotifier {
  List<ClinicService>? _services;
  List<ClinicService>? get services => _services;

  Future fetchServices(String category) async {
    if (_services != null) {
      _services = null;
      notifyListeners();
    }
    var s = await HxClinicServices.fetchClinicServicesByCategory(category);
    _services = ClinicService.serviceList(s);
    notifyListeners();
  }
}
