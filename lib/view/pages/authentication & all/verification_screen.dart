import 'package:fahim_try_ecommerce/controllers/auth_controller.dart';
import 'package:fahim_try_ecommerce/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../helpers/time_formetter.dart';

class VerificationScreen extends StatefulWidget {
  final String userName;
  final bool isResettingPasswrod;
  const VerificationScreen({
    super.key,
    required this.userName,
    this.isResettingPasswrod = false,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _pinPutController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _authController.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _authController.dispostTimer();
    super.dispose();
  }

  void onClick() async {
    final auth = Get.find<AuthController>();

    final message = await auth.verifyAfterSignup(
      widget.userName,
      _pinPutController.text.trim(),
    );

    if (message == "success") {
      Get.snackbar("Success", "User verifyed successfully");
    } else {
      Get.snackbar("Something went wrong", message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 45),
          Align(
            alignment: AlignmentGeometry.topLeft,
            child: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.grey[200]),
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Forgot Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          SvgPicture.asset("assets/icons/Forgot.svg"),
          SizedBox(height: 60),
          Form(
            key: _formKey,
            child: Center(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: _pinPutController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'enter a valid code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 130),
                    _authController.enableResend.value
                        ? TextButton(
                            onPressed: () {
                              _authController.startTimer();
                            },
                            child: Text("Resend Code"),
                          )
                        : RichText(
                            text: TextSpan(
                              text: formatTime(
                                _authController.secondsRemaining.value,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: " resend code.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => Get.find<AuthController>().isLoading.value
                ? Center(child: CircularProgressIndicator())
                : CustomButton(
                    title: "Confirm Code",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Get.toNamed("/newpasswordScreen");
                        onClick();
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
