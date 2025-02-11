import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_website/config/const.dart';

class HxClinic {
  static Future addClinicToServer({
    required Clinic clinic,
  }) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinics',
    );
    var body = jsonEncode(clinic.toJson());
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

  static Future fetchAllClinics() async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinics',
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

  static Future deleteClinic(String id) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinics/$id',
    );
    var response = await http.delete(
      uri,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future updateClinic({
    required String id,
    required String type,
    required String param,
    required dynamic value, // if object ==>> toJson,
    required String operation,
  }) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/clinics/$id',
    );

    var prebody = {
      'type': type,
      'param': param,
      'value': value,
      'operation': operation,
    };

    final body = jsonEncode(prebody);

    var response = await http.put(
      uri,
      body: body,
      headers: Environment().config.HEADERS,
    );
    if (response.statusCode == 401) {
      throw Exception(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
