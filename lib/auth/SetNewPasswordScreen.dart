import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);
const Color kBg = Color(0xFFF9F9FB);

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  bool hidePassword = true;
  bool hideConfirm = true;

  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: kBg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// ================= NAVBAR =================
                WebNavbar(
                  currentIndex: -1,
                  onTap: (i) {},
                ),

                /// ================= WHITE CONTENT =================
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Center(
                    child: _resetCard(),
                  ),
                ),

                /// ================= FOOTER =================
                const FooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= RESET CARD =================

  Widget _resetCard() {
    return Container(
      width: 420, // 🔒 FIGMA WIDTH
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          const Center(
            child: TextWidget(
              'Reset Password',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          /// DESCRIPTION
          const Center(
            child: TextWidget(
              'Duis sagittis molestie tellus, at eleifend sapien\n'
              'pellentesque quis. Fusce lorem nunc,\n'
              'fringilla sit amet nunc.',
              fontSize: 12,
              color: kGrey,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 26),

          /// PASSWORD
          const TextWidget('Password', fontSize: 12),
          const SizedBox(height: 6),
          _passwordField(
            controller: passwordCtrl,
            hide: hidePassword,
            hint: '8+ characters',
            onToggle: () {
              setState(() => hidePassword = !hidePassword);
            },
          ),

          const SizedBox(height: 16),

          /// CONFIRM PASSWORD
          const TextWidget('Confirm Password', fontSize: 12),
          const SizedBox(height: 6),
          _passwordField(
            controller: confirmCtrl,
            hide: hideConfirm,
            onToggle: () {
              setState(() => hideConfirm = !hideConfirm);
            },
          ),

          const SizedBox(height: 22),

          /// BUTTON
          Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextWidget(
                  'RESET PASSWORD',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PASSWORD FIELD =================

  Widget _passwordField({
    required TextEditingController controller,
    required bool hide,
    required VoidCallback onToggle,
    String? hint,
  }) {
    return TextField(
      controller: controller,
      obscureText: hide,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            hide ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: kGrey,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: kBorder),
        ),
      ),
    );
  }
}