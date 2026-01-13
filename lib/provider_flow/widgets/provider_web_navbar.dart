import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

/// ================= CONSTANTS =================
const Color kNavBg = Color(0xFF4C4FA1);
const Color kPrimary = Color(0xFFF48C5A);
const Color kNavText = Colors.white;

class ProviderWebNavbar extends StatelessWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final int currentIndex;
  final Function(int)? onTap;

  const ProviderWebNavbar({
    super.key,
    this.showBack = false,
    this.onBack,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Container(
      height: 76,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 16),
      color: kNavBg,
      child: Row(
        children: [
          /// ================= LEFT =================
          Row(
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack,
                ),

              const SizedBox(width: 6),

              const TextWidget(
                'DirectTask',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ],
          ),

          const Spacer(),

          /// ================= CENTER NAV (WEB ONLY) =================
          if (onTap != null && isDesktop)
            Row(
              children: [
                _navItem('Home', 0),
                _navItem('Services', 1),
                _navItem('Requests', 2),
                _navItem('About', 3),
                _navItem('Contact', 4),
              ],
            ),

          const Spacer(),

          /// ================= RIGHT =================
          Row(
            children: [
              /// Notification
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0x66FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 12),

              /// Provider Profile Chip
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: const [
                    TextWidget(
                      'William Jack',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(
                        'assets/images/user.png',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= NAV ITEM =================
  Widget _navItem(String title, int index) {
    final active = currentIndex == index;

    return InkWell(
      onTap: () => onTap?.call(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: active ? 24 : 0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}