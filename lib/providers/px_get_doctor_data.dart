import 'package:doctor_website/api/get/hx_main.dart';
import 'package:doctor_website/models/server_response_model.dart';
import 'package:flutter/material.dart';

class PxGetDoctorData extends ChangeNotifier {
  static ServerResponseModel? _model;
  ServerResponseModel? get model => _model;

  final HxMain service;

  PxGetDoctorData({required this.service}) {
    _getDoctorData();
  }

  Future<void> _getDoctorData() async {
    if (_model == null) {
      _model = await service.fetchModelById();
      notifyListeners();
    }
  }
}
