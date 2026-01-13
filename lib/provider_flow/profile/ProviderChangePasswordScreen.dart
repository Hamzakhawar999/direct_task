import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_side_nav.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);

class ProviderChangePasswordScreen extends StatefulWidget {
  const ProviderChangePasswordScreen({super.key});

  @override
  State<ProviderChangePasswordScreen> createState() =>
      _ProviderChangePasswordScreenState();
}

class _ProviderChangePasswordScreenState
    extends State<ProviderChangePasswordScreen> {
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  bool showCurrent = false;
  bool showNew = false;
  bool showConfirm = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1400; // 🔒 SAFE BREAKPOINT

    return Container(
      color: kBg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: isDesktop ? _desktopLayout() : _mobileLayout(),
    );
  }

  // ================= DESKTOP (UNCHANGED UI) =================

  Widget _desktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProviderSideNav(
          activeIndex: 4,
          onTap: (_) {},
          activeRoute: '',
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 942, // ✅ FIGMA WIDTH (DESKTOP ONLY)
              child: _card(isDesktop: true),
            ),
          ),
        ),
      ],
    );
  }

  // ================= MOBILE / TABLET =================

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _card(isDesktop: false),
        ),
      ),
    );
  }

  // ================= SHARED CARD =================

  Widget _card({required bool isDesktop}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 942),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: const TextWidget(
              'CHANGE PASSWORD',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          Container(height: 1, color: kBorder),

          /// BODY
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _passwordField(
                  label: 'Current Password',
                  controller: currentCtrl,
                  obscure: !showCurrent,
                  onToggle: () =>
                      setState(() => showCurrent = !showCurrent),
                ),
                const SizedBox(height: 16),

                _passwordField(
                  label: 'New Password',
                  hint: '8+ characters',
                  controller: newCtrl,
                  obscure: !showNew,
                  onToggle: () => setState(() => showNew = !showNew),
                ),
                const SizedBox(height: 16),

                _passwordField(
                  label: 'Confirm Password',
                  controller: confirmCtrl,
                  obscure: !showConfirm,
                  onToggle: () =>
                      setState(() => showConfirm = !showConfirm),
                ),

                const SizedBox(height: 40),

                /// SAVE BUTTON
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
    );
  }

  // ================= PASSWORD FIELD =================

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(label, fontSize: 13, fontWeight: FontWeight.w500),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle:
                        const TextStyle(fontSize: 13, color: kGrey),
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}