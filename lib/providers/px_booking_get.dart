// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_booking.dart';
import 'package:doctor_website_models/doctor_website__models.dart';

class PxBookingGet extends ChangeNotifier {
  List<Booking>? _bookings;
  List<Booking>? get bookings => _bookings;

  int _page = 0;
  int get page => _page;

  Future fetchBookings() async {
    var b = await HxBooking.fetchBookings(page);
    _bookings = Booking.bookingList(b);
    notifyListeners();
  }

  Future nextPage() async {
    _page++;
    notifyListeners();
    await fetchBookings();
  }

  Future zeroPage() async {
    _page = 0;
    notifyListeners();
    await fetchBookings();
  }

  Future previousPage() async {
    if (_page <= 0) {
      return;
    } else {
      _page--;
      notifyListeners();
      await fetchBookings();
    }
    notifyListeners();
    await fetchBookings();
  }
}
