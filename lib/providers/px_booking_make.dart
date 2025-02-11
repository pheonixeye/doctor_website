// ignore_for_file: unnecessary_getters_setters

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_booking.dart';

class PxBookingMake extends ChangeNotifier {
  Clinic? _clinic;
  Schedule? _day;
  String? _date;
  String? _ptName;
  String? _ptPhone;

  Clinic? get clinic => _clinic;

  void setclinic(Clinic? value) {
    _clinic = value;
    notifyListeners();
  }

  Schedule? get day => _day;

  void setDay(value) {
    _day = value;
    notifyListeners();
  }

  String? get date => _date;

  void setdate(value) {
    _date = value;
    notifyListeners();
  }

  String? get ptName => _ptName;

  void setptName(value) {
    _ptName = value;
    notifyListeners();
  }

  String? get ptPhone => _ptPhone;

  void setptPhone(value) {
    _ptPhone = value;
    notifyListeners();
  }

  Booking? _booking;
  Booking? get booking => _booking;

  void setbooking() {
    _booking = Booking(
      clinicId: clinic!.id!,
      day: day!,
      date: date!,
      ptName: ptName!,
      ptPhone: ptPhone!,
      attended: false,
    );
    notifyListeners();
  }

  void nullifyValues() {
    _clinic = null;
    _date = null;
    _day = null;
    _ptName = null;
    _ptPhone = null;
    _booking = null;
    notifyListeners();
  }

  Future addBooking() async {
    await HxBooking.addBooking(booking!);
  }
}
