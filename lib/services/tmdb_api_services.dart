import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class TmdbApiServices {

  /// Use this to check API Key availability
  static Future<bool> getConfiguration() async {
    try {
      http.Response res = await http.get(
        Uri.parse(
            "${Constants.BASE_URL}/configuration?${Constants.API_KEY_QUERY}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (res.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
