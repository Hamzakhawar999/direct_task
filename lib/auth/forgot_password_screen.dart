import 'package:direct_task_web/auth/SetNewPasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);
const Color kBg = Color(0xFFF9F9FB);

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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

              /// ================= WHITE AUTH SECTION =================
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Center(
                  child: _forgotCard(context),
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
  // ================= CARD =================

  Widget _forgotCard(BuildContext context) {
    return Container(
      width: 500,
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
          const Center(
            child: TextWidget(
              'Forget Password',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          const Center(
            child: TextWidget(
              'Enter the email address or mobile phone number\nassociated with your Clicon account.',
              fontSize: 12,
              color: kGrey,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          const TextWidget('Email Address', fontSize: 12),
          const SizedBox(height: 6),

          TextField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: kBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: kBorder),
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// SEND CODE
         InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SetNewPasswordScreen(),
      ),
    );
  },
  borderRadius: BorderRadius.circular(6),
  child: Container(
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
          'SEND CODE',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward, color: Colors.white, size: 16),
      ],
    ),
  ),
),

          const SizedBox(height: 18),

          /// LINKS
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const TextWidget(
                    'Already have account? Sign In',
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),
                const TextWidget(
                  'Don’t have account? Sign Up',
                  fontSize: 12,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 10),

          const TextWidget(
            'You may contact Customer Service for help restoring access to your account.',
            fontSize: 11,
            color: kGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}