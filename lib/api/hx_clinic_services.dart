import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_website/config/const.dart';

class HxClinicServices {
  static Future addClinicService(ClinicService service) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices',
    );
    var body = jsonEncode(service.toJson());
    var response = await http.post(
      uri,
      body: body,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return response.body;
    }
  }

  static Future fetchOneClinicService(String id) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices/$id',
    );
    var response = await http.post(
      uri,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future fetchClinicServices() async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices',
    );
    var response = await http.get(
      uri,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future fetchClinicServicesByCategory(String category) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices/$category',
    );
    var response = await http.get(
      uri,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future deleteClinicService(String id) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices',
    );
    var body = jsonEncode({'_id': id});
    var response = await http.delete(
      uri,
      body: body,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return response.body;
    }
  }

  static Future updateClinicService(String id, String type, FaQ faq) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinicservices/$id',
    );
    var body = jsonEncode({
      'type': type,
      'faq': faq.toJson(),
    });
    var response = await http.put(
      uri,
      body: body,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return response.body;
    }
  }
}
