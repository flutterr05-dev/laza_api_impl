import 'package:fahim_try_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routs/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    jumpToNextPage();
    super.initState();
  }

  jumpToNextPage() async {
    final prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 3), () {
      if (prefs.getString("access_token") != null) {
        Get.offAllNamed(Routes.mainScreen);
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(child: SvgPicture.asset("assets/icons/Logo.svg")),
    );
  }
}
