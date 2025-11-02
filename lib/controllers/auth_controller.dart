import 'dart:async';
import 'dart:convert';
import 'package:fahim_try_ecommerce/model/user.dart';
import 'package:fahim_try_ecommerce/utils/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool isRememberMe = false;
  RxBool isLoading = RxBool(false);
  Rxn<User> userInfo = Rxn<User>();

  ApiClient api = ApiClient();

  Future<String> login(String username, String password) async {
    isLoading(true);
    try {
      final res = await api.post("/auth/login/", {
        "username": username,
        "password": password,
      });
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

  Future<String> signup(
    String firstName,
    String email,
    String username,
    String password,
  ) async {
    isLoading(true);
    try {
      final res = await api.post("/auth/signup/", {
        "username": username,
        "email": email,
        "password": password,
        "first_name": firstName,
      });
      final body = jsonDecode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        userInfo.value = User.fromJson(body['data']);

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

  Future<String> verifyAfterSignup(String username, String otp) async {
    isLoading(true);
    try {
      final response = await api.post("/auth/verify/$username/", {"otp": otp});

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        //Success
        return "success";
      } else {
        //Failed
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
