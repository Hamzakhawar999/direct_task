import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final bool isTablet = screenWidth >= 768 && screenWidth < 1100;

    return SizedBox(
      width: double.infinity,

      /// ✅ HEIGHT FIX (DESKTOP / MOBILE SAFE)
      height: isMobile
          ? 1100
          : isTablet
              ? 980
              : 900,

      child: Stack(
        children: [
          /// ================= BACKGROUND IMAGE =================
          Positioned.fill(
            child: Image.asset(
              'assets/images/group-3.png',
              fit: BoxFit.cover,
            ),
          ),

          /// ================= WHITE OVERLAY =================
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.92),
            ),
          ),

          /// ================= CONTENT =================
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 0, 
                  vertical: isMobile ? 60 : 120,
                ),
                child: isMobile
                    ? _MobileContent()
                    : _DesktopContent(isTablet: isTablet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= DESKTOP / TABLET =================
class _DesktopContent extends StatelessWidget {
  final bool isTablet;

  const _DesktopContent({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // ✅ critical
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// LEFT IMAGE
        SizedBox(
          width: isTablet ? 480 : 600, // ✅ REDUCED
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              'assets/images/why_choose_main.png',
              height: isTablet ? 480 : 600,
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: isTablet ? 48 : 80),

        /// RIGHT CONTENT
        SizedBox(
          width: isTablet ? 420 : 520,
          child: _TextContent(
            titleSize: isTablet ? 40 : 48,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

/// ================= MOBILE =================
class _MobileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Image.asset(
            'assets/images/why_choose_main.png',
            height: 320,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 40),
        _TextContent(
          titleSize: 32,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// ================= TEXT CONTENT =================
class _TextContent extends StatelessWidget {
  final double titleSize;
  final TextAlign textAlign;

  const _TextContent({
    required this.titleSize,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          textAlign == TextAlign.center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        /// TITLE
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: Colors.black,
            ),
            children: const [
              TextSpan(text: 'Why Will '),
              TextSpan(
                text: 'You Choose\n',
                style: TextStyle(color: Color(0xFFFF7F5D)),
              ),
              TextSpan(text: 'Our Services?'),
            ],
          ),
        ),

        const SizedBox(height: 24),

        /// DESCRIPTION
        TextWidget(
          'We bring trusted offline professionals and expert online '
          'services together on one platform — making it easy, fast, '
          'and reliable to get the help you need.',
          fontSize: 16,
          height: 1.6,
          color: const Color(0xFF666666),
          textAlign: textAlign,
        ),

        const SizedBox(height: 32),

        _bullet('Trusted Professionals'),
        _bullet('Fast & Easy Booking'),
        _bullet('All-in-One Platform'),
        _bullet('Reliable Support'),

        const SizedBox(height: 40),

        /// CTA BUTTON
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            color: const Color(0xFFF08A5D),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                TextWidget(
                  'Explore Services',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Icon(Icons.arrow_forward, size: 16, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFFFF7F5D),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.white),
          ),
          const SizedBox(width: 12),
          TextWidget(text, fontSize: 16, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}