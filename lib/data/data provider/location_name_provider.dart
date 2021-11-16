import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationNameProvider {
  Future<dynamic> getLocationName(double latitude, double longitude) async {
    var responce = await http
        .get(Uri.parse("https://geocode.xyz/$latitude,$longitude?json=1"));
    return jsonDecode(responce.body);
  }
}
