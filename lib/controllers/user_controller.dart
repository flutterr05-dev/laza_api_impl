import 'dart:convert';

import 'package:fahim_try_ecommerce/model/user.dart';
import 'package:fahim_try_ecommerce/utils/api_client.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final api = ApiClient();
  Rx<bool> isLoading = Rx<bool>(false);
  Rxn<User> userInfo = Rxn();

  Future<String> getUserProfile() async {
    isLoading(true);
    try {
      final response = await api.get("/auth/profile/", authRequired: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        userInfo.value = User.fromJson(body["data"]);
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

  Future<String> updateUserProfile(Map<String, String> changes) async {
    isLoading(true);
    try {
      final response = await api.put(
        "/auth/profile/",
        changes,
        authRequired: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        userInfo.value = User.fromJson(body["data"]);
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
}
