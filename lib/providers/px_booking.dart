import 'package:doctor_website/api/notify/hx_notify.dart';
import 'package:doctor_website/api/post/hx_post.dart';
import 'package:doctor_website/constant/constants.dart';
import 'package:doctor_website/models/booking.dart';
import 'package:doctor_website/models/booking_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PxBooking extends ChangeNotifier {
  final BookingApi service;
  final NotificationsApi notificationsService;

  PxBooking({
    required this.service,
    required this.notificationsService,
  }) {
    _initBooking();
  }

  static Booking? _booking;
  Booking? get booking => _booking;

  void _initBooking() {
    if (_booking == null) {
      _booking =
          Booking.empty(const String.fromEnvironment(AppConstants.DOC_ID));
      notifyListeners();
    }
  }

  void verifyBooking() {
    final condition = _booking != null &&
        _booking!.doc_id.isNotEmpty &&
        _booking!.clinic_id != null &&
        _booking!.schedule_id != null &&
        _booking!.date != null &&
        _booking!.name != null &&
        _booking!.phone != null;
    if (condition) {
      return;
    } else {
      throw UnimplementedError();
    }
  }

  void setBooking({
    String? clinic_id,
    String? schedule_id,
    String? date,
    String? name,
    String? phone,
  }) {
    _booking = _booking?.copyWith(
      clinic_id: clinic_id ?? _booking?.clinic_id,
      schedule_id: schedule_id ?? _booking?.schedule_id,
      date: date ?? _booking?.date,
      name: name ?? _booking?.name,
      phone: phone ?? _booking?.phone,
    );
    notifyListeners();
  }

  Future<void> createBooking(BookingNotification bookingNotification) async {
    if (_booking != null) {
      await service.createBooking(booking!);
      await notificationsService.notifyBooking(bookingNotification);
      _booking = null;
      notifyListeners();
    }
    _initBooking();
  }

  void resetBooking() {
    _booking = null;
    notifyListeners();
    _initBooking();
  }
}
