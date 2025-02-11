import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_clinic_services.dart';

class PxOneServiceGet extends ChangeNotifier {
  ClinicService? _service;
  ClinicService? get service => _service;

  Future fetchOneServiceFromServer(String id) async {
    var s = await HxClinicServices.fetchOneClinicService(id);
    _service = ClinicService.fromJson(s);
    notifyListeners();
  }
}
