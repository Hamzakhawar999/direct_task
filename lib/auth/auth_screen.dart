import 'package:direct_task_web/provider_flow/widgets/ProviderNavScaffold.dart';
import 'package:direct_task_web/widgets/web_nav_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:direct_task_web/auth/forgot_password_screen.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

/// ================= COLORS =================
const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);
const Color kBg = Color(0xFFF9F9FB);

/// ================= ROLE SESSION =================
enum AppUserType { user, provider }

class AppSession {
  static AppUserType? selectedUserType;
}

/// ================= AUTH SCREEN =================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool hidePassword = true;
  bool hideConfirm = true;
  bool agree = true;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  /// ================= TOP NAV =================
                  WebNavbar(currentIndex: -1, onTap: (_) {}),

                  /// ================= CENTER CONTENT =================
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: SizedBox(
                        width: 380,
                        child: _authCard(),
                      ),
                    ),
                  ),

                  /// ================= FOOTER =================
                  const FooterSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= AUTH CARD =================
  Widget _authCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ================= TABS =================
          Row(
            children: [
              _tab('Sign In', isLogin, () => setState(() => isLogin = true)),
              _tab('Sign Up', !isLogin, () => setState(() => isLogin = false)),
            ],
          ),

          const SizedBox(height: 24),

          /// ================= FORM =================
          if (!isLogin) _inputField('Name', nameCtrl),
          if (!isLogin) const SizedBox(height: 14),

          _inputField('Email Address', emailCtrl),
          const SizedBox(height: 14),

          _passwordField(
            label: 'Password',
            controller: passCtrl,
            hide: hidePassword,
            onToggle: () => setState(() => hidePassword = !hidePassword),
            hint: isLogin ? null : '8+ characters',
          ),

          if (!isLogin) const SizedBox(height: 14),

          if (!isLogin)
            _passwordField(
              label: 'Confirm Password',
              controller: confirmCtrl,
              hide: hideConfirm,
              onToggle: () => setState(() => hideConfirm = !hideConfirm),
            ),

          if (isLogin)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const TextWidget(
                  'Forget Password',
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            ),

          if (!isLogin) const SizedBox(height: 10),

          if (!isLogin)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: agree,
                  activeColor: kPrimary,
                  onChanged: (v) => setState(() => agree = v ?? true),
                ),
                const Expanded(
                  child: TextWidget(
                    'Are you agree to Clickon Terms of Condition and Privacy Policy.',
                    fontSize: 12,
                    color: kGrey,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 18),

          _primaryButton(isLogin ? 'SIGN IN' : 'SIGN UP'),

          const SizedBox(height: 20),

          Row(
            children: const [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextWidget('or', fontSize: 12),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SocialIcon('assets/images/facebook.png'),
              SizedBox(width: 14),
              _SocialIcon('assets/images/google.png'),
              SizedBox(width: 14),
              _SocialIcon('assets/images/apple.png'),
            ],
          ),
        ],
      ),
    );
  }

  // ================= BUTTON =================
  Widget _primaryButton(String text) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isLogin) {
          if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Enter email & password')),
            );
            return;
          }

          if (AppSession.selectedUserType == AppUserType.provider) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ProviderNavScaffold(currentIndex: 0),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => WebNavScaffold(currentIndex: 0),
              ),
            );
          }
        }
      },
      child: Container(
        height: 46,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // ================= HELPERS =================
  Widget _tab(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            TextWidget(
              text,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: active ? Colors.black : kGrey,
            ),
            const SizedBox(height: 8),
            Container(
              height: 2,
              color: active ? kPrimary : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(label, fontSize: 12),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool hide,
    required VoidCallback onToggle,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(label, fontSize: 12),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: hide,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: IconButton(
              icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
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
        ),
      ],
    );
  }
}

/// ================= SOCIAL ICON =================
class _SocialIcon extends StatelessWidget {
  final String path;
  const _SocialIcon(this.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kBorder),
      ),
      child: Center(
        child: Image.asset(path, height: 18),
      ),
    );
  }
}