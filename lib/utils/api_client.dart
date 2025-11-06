import 'package:fahim_try_ecommerce/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool authRequired = false,
  }) async {
    final url = Uri.parse(AppConstants.baseUrl + endpoint);
    http.Response response = await http.post(url, body: body);

    return response;
  }

  Future<http.Response> get(
    String endpoint, {
    bool authRequired = false,
  }) async {
    final url = Uri.parse(AppConstants.baseUrl + endpoint);
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {};
    if (authRequired) {
      headers.addAll({
        "Authorization": "Bearer ${prefs.getString("access_token")}",
      });
    }
    final response = await http.get(url, headers: headers);

    return response;
  }

  Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool authRequired = false,
  }) async {
    final url = Uri.parse(AppConstants.baseUrl + endpoint);
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {};
    if (authRequired) {
      headers.addAll({
        "Authorization": "Bearer ${prefs.getString("access_token")}",
      });
    }
    http.Response response = await http.put(url, body: body, headers: headers);

    return response;
  }
}
