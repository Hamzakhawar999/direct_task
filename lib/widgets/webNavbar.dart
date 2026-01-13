import 'package:direct_task_web/widgets/NavItem.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WebNavbar extends StatelessWidget {
  /// ACTIVE TAB INDEX (0 = Home, 1 = Services, etc)
  final int currentIndex;

  /// OPTIONAL NAV HANDLER
  /// If null → navbar becomes static (auth screens, etc)
  final Function(int)? onTap;

  /// OPTIONAL BACK BUTTON
  final bool showBack;
  final VoidCallback? onBack;

  const WebNavbar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: const Color(0xFF4F53A6),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 6.w : 7.w,
          vertical: 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Row(
              children: [
                /// 🔙 BACK BUTTON
                if (showBack)
                  GestureDetector(
                    onTap: onBack,
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                /// LOGO
                Image.asset('assets/images/logo.png', height: 26),

                const Spacer(),

                /// CENTER NAV (ONLY IF onTap PROVIDED)
                if (!isMobile && !showBack && onTap != null)
                  Row(
                    children: [
                      NavItem(
                        title: 'Home',
                        isActive: currentIndex == 0,
                        onTap: () => onTap!(0),
                      ),
                      const SizedBox(width: 28),
                      NavItem(
                        title: 'Services',
                        isActive: currentIndex == 1,
                        onTap: () => onTap!(1),
                      ),
                      const SizedBox(width: 28),
                      NavItem(
                        title: 'Requests',
                        isActive: currentIndex == 2,
                        onTap: () => onTap!(2),
                      ),
                      const SizedBox(width: 28),
                      NavItem(
                        title: 'About',
                        isActive: currentIndex == 3,
                        onTap: () => onTap!(3),
                      ),
                      const SizedBox(width: 28),
                      NavItem(
                        title: 'Contact',
                        isActive: currentIndex == 4,
                        onTap: () => onTap!(4),
                      ),
                    ],
                  ),

                const Spacer(),

                /// CTA BUTTON
                if (!isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7F5D),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const TextWidget(
                      'Get Started',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}