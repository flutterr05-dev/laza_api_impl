import 'dart:async';
import 'dart:convert';
import 'package:fahim_try_ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool isRememberMe = false;
  RxBool isLoading = RxBool(false);

  Future<String> login(String username, String password) async {
    isLoading(true);
    try {
      final res = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/login/"),
        body: {"username": username, "password": password},
      );
      final body = jsonDecode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();

        prefs.setString("refresh_token", body['refresh']);
        prefs.setString("access_token", body['access']);

        return "success";
      } else {
        return body['message'] ?? "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  onRememberMeChanged(value) {
    isRememberMe = value;
    update();
  }

  RxInt secondsRemaining = 30.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  dispostTimer() {
    timer?.cancel();
    secondsRemaining.value = 30;
    enableResend.value = false;
  }

  void startTimer() {
    timer?.cancel();
    secondsRemaining.value = 30;
    enableResend.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
  }
}
