import 'package:fahim_try_ecommerce/utils/app_constants.dart';
import 'package:http/http.dart' as http;

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
}
