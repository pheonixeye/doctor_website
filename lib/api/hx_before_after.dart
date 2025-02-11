import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_website/config/const.dart';

class HxBeforeAfter {
  static Future addBeforeAfter(
    BeforeAfter item,
  ) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/beforeafter',
    );
    var body = jsonEncode(item.toJson());
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

  static Future getBeforeAfter(
    String categoryId,
  ) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/beforeafter/$categoryId',
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

  static Future deleteBeforeAfter(
    String id,
  ) async {
    Uri uri = Uri(
      scheme: Environment().config.SCHEME,
      host: Environment().config.HOST,
      port: Environment().config.PORT,
      path: '/${Initials.i_}/beforeafter',
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
}
