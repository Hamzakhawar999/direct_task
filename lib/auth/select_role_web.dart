import 'dart:async';
import 'package:direct_task_web/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/app_user_type.dart' hide AppSession, AppUserType;
import '../widgets/text_widget.dart';
import '../widgets/WebNavbar.dart';

const Color kUserColor = Color(0xFFFF8A65);
const Color kProviderColor = Color(0xFF4C4FA1);
const Color kBg = Color(0xFFF9F9FB);

class SelectRoleWebScreen extends StatefulWidget {
  const SelectRoleWebScreen({super.key});

  @override
  State<SelectRoleWebScreen> createState() => _SelectRoleWebScreenState();
}

class _SelectRoleWebScreenState extends State<SelectRoleWebScreen> {
  int selectedType = 0; // 1 = User, 2 = Provider

  void _selectType(int type) {
    setState(() => selectedType = type);

    /// ✅ SAVE ROLE (UNCHANGED)
    AppSession.selectedUserType =
        type == 1 ? AppUserType.user : AppUserType.provider;

    Timer(const Duration(milliseconds: 400), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, __, ___) {
        return Scaffold(
          backgroundColor: kBg,
          body: Column(
            children: [
              /// ================= NAVBAR =================
              WebNavbar(currentIndex: -1, onTap: (_) {}),

              /// ================= BODY =================
              Expanded(
                child: Stack(
                  children: [
                    /// 🔹 BACKGROUND IMAGE (UNCHANGED)
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/pricing_bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    /// 🔹 CONTENT
                    Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double maxWidth =
                              constraints.maxWidth > 900
                                  ? 900
                                  : constraints.maxWidth;

                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: maxWidth),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      'Get Your Service 😊',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),

                                    SizedBox(height: 5.h),

                                    /// USER ROLE
                                    _roleCard(
                                      isSelected: selectedType == 1,
                                      color: kUserColor,
                                      title: 'LOOKING FOR SERVICE',
                                      description:
                                          'Find trusted professionals for your daily needs.',
                                      icon: Icons.person_outline,
                                      onTap: () => _selectType(1),
                                    ),

                                    SizedBox(height: 3.h),

                                    /// PROVIDER ROLE
                                    _roleCard(
                                      isSelected: selectedType == 2,
                                      color: kProviderColor,
                                      title: 'SERVICE PROVIDER',
                                      description:
                                          'Offer your services and grow your business.',
                                      icon: Icons.work_outline,
                                      onTap: () => _selectType(2),
                                    ),

                                    SizedBox(height: 6.h),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= ROLE CARD =================
  Widget _roleCard({
    required bool isSelected,
    required Color color,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 100.w > 900 ? 700 : 100.w,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Row(
          children: [
            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 28, color: Colors.white),
                  const SizedBox(height: 14),
                  TextWidget(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  TextWidget(
                    description,
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ],
              ),
            ),

            /// ARROW
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}