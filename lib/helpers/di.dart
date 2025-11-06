import 'package:fahim_try_ecommerce/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

void init(){
  Get.put(AuthController());
  Get.put(UserController());
}