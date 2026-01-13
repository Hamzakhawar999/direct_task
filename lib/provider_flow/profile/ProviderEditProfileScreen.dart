import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_side_nav.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);

class ProviderEditProfileScreen extends StatelessWidget {
  const ProviderEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= SIDENAV =================
         

          const SizedBox(width: 40),

          /// ================= MAIN CONTENT =================
          Expanded(
            child: Center(
              child: SizedBox(
                width: 942, // 🔒 EXACT FIGMA WIDTH
                child: Container(
                  height: 508, // 🔒 EXACT FIGMA HEIGHT
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ================= HEADER =================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        child: const TextWidget(
                          'EDIT PROFILE',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      /// HEADER DIVIDER (FIGMA)
                      Container(
                        height: 1,
                        color: kBorder,
                      ),

                      /// ================= BODY =================
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// PROFILE IMAGE
                                const CircleAvatar(
                                  radius: 52,
                                  backgroundImage: AssetImage(
                                    'assets/images/Ellipse 2449.png',
                                  ),
                                ),

                                const SizedBox(width: 32),

                                /// FORM
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _field(
                                        label: 'Full Name',
                                        value: 'Ali Akbar',
                                      ),
                                      const SizedBox(height: 16),
                                      _field(
                                        label: 'Email',
                                        value: 'aliakbar@gmail.com',
                                      ),
                                      const SizedBox(height: 16),
                                      _field(
                                        label: 'Phone Number',
                                        value: '+1-202-555-0118',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            /// ================= SAVE BUTTON =================
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 48,
                                width: 260,
                                decoration: BoxDecoration(
                                  color: kPrimary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    TextWidget(
                                      'Save',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12),
                                    CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 14,
                                        color: kPrimary,
                                      ),
                                    ),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }

  /// ================= INPUT FIELD =================
  static Widget _field({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          label,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: TextWidget(
            value,
            fontSize: 13,
            color: kGrey,
          ),
        ),
      ],
    );
  }
}