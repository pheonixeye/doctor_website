import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:doctor_website/config/const.dart';
import 'package:http/http.dart' as http;

class HxBooking {
  static Future addBooking(Booking booking) async {
    final Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/booking',
    );
    var body = jsonEncode(booking.toJson());

    var response = await http.post(
      uri,
      body: body,
      headers: Environment().config.HEADERS,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  static Future fetchBookings(int page) async {
    final Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/booking/$page',
    );

    var response = await http.get(
      uri,
      headers: Environment().config.HEADERS,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }
}
