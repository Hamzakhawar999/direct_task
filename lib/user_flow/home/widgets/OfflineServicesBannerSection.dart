import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class OfflineServicesBannerSection extends StatelessWidget {
  const OfflineServicesBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final bool isTablet = width >= 768 && width < 1100;

    return SizedBox(
      width: double.infinity,
      height: 896, // 🔒 EXACT height
      child: Stack(
        children: [
          /// ================= PURPLE BACKGROUND =================
          Positioned.fill(
            child: Container(
              color: const Color(0xFF4F53A6),
            ),
          ),

          /// ================= WAVE BACKGROUND =================
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: Image.asset(
                'assets/images/wave_bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// ================= CONTENT (20px FROM TOP) =================
          Positioned(
            top: 70, // ✅ EXACT requirement
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      'Our ',
                      fontSize: isMobile ? 32 : isTablet ? 42 : 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    TextWidget(
                      'Offline ',
                      fontSize: isMobile ? 32 : isTablet ? 42 : 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF08A5D),
                    ),
                    TextWidget(
                      'Services',
                      fontSize: isMobile ? 32 : isTablet ? 42 : 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// SUBTITLE
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: TextWidget(
                    'Reliable on-ground services delivered by trusted professionals '
                    '— digital plus human collaboration.',
                    fontSize: isMobile ? 14 : 16,
                    height: 1.4,
                    color: Colors.white.withOpacity(0.9),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}