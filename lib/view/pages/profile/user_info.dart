// lib/presentation/account/account_information_view.dart
import 'package:fahim_try_ecommerce/controllers/user_controller.dart';
import 'package:fahim_try_ecommerce/view/pages/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../controllers/user_controller.dart'; // Apnar controller path

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Controller Find/Initialization (Assuming it's ready)
    // final UserController controller = Get.put(UserController());
    final Color primaryColor = const Color(0xFF9386E8);

    // Mock data for display (Replace with actual controller data)
    final Map<String, String> userData = {
      'Name': 'Zakaria Rabby',
      'Email': 'name@example.com',
      'Phone Number': '0123654789',
      'Country': 'Bangladesh',
      'City': 'Sylhet',
      'Address': 'Chhatak, Sunamgonj 12/8AB',
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Account Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- Profile Image ---
            const _ProfilePicture(imageUrl: 'assets/images/profile.png'),
            const SizedBox(height: 30),

            // --- User Data Fields (Read-Only) ---
            ...userData.entries
                .map(
                  (entry) => _InfoField(
                    label: entry.key,
                    value:
                        entry.value, // Replace with controller.RxString.value
                  ),
                )
                .toList(),

            const SizedBox(height: 40),

            // --- Edit Button ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                // onPressed: controller.openEditView, // 🔑 Controller method call
                onPressed: () => Get.to(() => EditProfile()),
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                label: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// --- Helper Widgets for Screen 20 (Read-Only) ---
// ----------------------------------------------------------------------

class _InfoField extends StatelessWidget {
  final String label;
  final String value;

  const _InfoField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Divider(color: Colors.grey.shade200, height: 15),
        ],
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  final String imageUrl;

  const _ProfilePicture({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200, width: 3),
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          // Placeholder icon if the image asset is not found
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.person, size: 60, color: Colors.grey),
        ),
      ),
    );
  }
}
// ----------------------------------------------------------------------