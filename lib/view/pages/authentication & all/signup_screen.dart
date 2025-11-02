import 'package:fahim_try_ecommerce/view/base/custom_button.dart';
import 'package:fahim_try_ecommerce/view/pages/authentication%20&%20all/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../base/custom_textfromfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onClick() async {
    final message = await AuthController().signup(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _usernameCtrl.text.trim(),
      _passCtrl.text,
    );

    if (message == "success") {
      Get.to(() => VerificationScreen(userName: _usernameCtrl.text.trim()));
    } else {
      final snack = Get.snackbar("Something went wrong", message);
      Get.showSnackbar(snack.snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: 45),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 152),
                CustomTextFromField(
                  controller: _nameCtrl,
                  hintText: "Enter Your First Name",
                  lebelText: "First Name",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your valid User Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFromField(
                  controller: _usernameCtrl,
                  hintText: "Enter Your Username",
                  lebelText: "Username",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your valid User Name";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                CustomTextFromField(
                  controller: _passCtrl,
                  obscureText: true,
                  hintText: "Enter Your Password",
                  lebelText: "Password",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your valid password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFromField(
                  controller: _emailCtrl,
                  hintText: "Enter Your Email",
                  lebelText: "Email Address",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Remember Me"),
                    Spacer(),
                    Switch(
                      value: Get.find<AuthController>().isRememberMe,
                      onChanged: controller.onRememberMeChanged,
                      activeTrackColor: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 160),
                CustomButton(
                  title: 'Sign up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onClick();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
