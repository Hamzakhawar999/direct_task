import 'package:direct_task_web/widgets/NavItem.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class HeroSection extends StatelessWidget {
  final Function(int)? onNavTap;

  const HeroSection({
    super.key,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 768;
        final bool isTablet =
            constraints.maxWidth >= 768 && constraints.maxWidth < 1100;

        return SizedBox(
          width: double.infinity,
          height: isMobile ? 100.h : 90.h,
          child: Stack(
            children: [
              /// ================= BACKGROUND =================
              Positioned.fill(
                child: Image.asset(
                  'assets/images/hero_bg.png',
                  fit: BoxFit.cover,
                ),
              ),

              /// ================= CONTENT =================
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6.w : 7.w,
                  vertical: isMobile ? 6.h : 4.h,
                ),
                child: Column(
                  children: [
                    /// ================= NAVBAR =================
                    _Navbar(
                      isMobile: isMobile,
                      onNavTap: onNavTap,
                    ),

                    SizedBox(height: isMobile ? 6.h : 8.h),

                    /// ================= HERO BODY =================
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: isMobile
                            ? const _MobileHeroContent()
                            : _DesktopHeroContent(
                                isTablet: isTablet,
                              ),
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
}

/// ================= DESKTOP / TABLET CONTENT =================
class _DesktopHeroContent extends StatelessWidget {
  final bool isTablet;

  const _DesktopHeroContent({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: isTablet ? 60.w : 728,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),

              /// HEADLINE
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: isTablet ? 42 : 60,
                    fontWeight: FontWeight.w600,
                    height: 1.22,
                    letterSpacing: -0.8,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Services ',
                      style: TextStyle(color: Color(0xFFFF7F5D)),
                    ),
                    TextSpan(
                      text: 'Made Simple\n',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Online ',
                      style: TextStyle(color: Color(0xFFFF7F5D)),
                    ),
                    TextSpan(
                      text: '& At Your Doorstep',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// SUBTITLE
              const TextWidget(
                'Book trusted professionals for offline services or '
                'get expert digital solutions online. One platform, '
                'endless possibilities.',
                fontSize: 16,
                height: 1.6,
                color: Color(0xFFEAEAEA),
              ),

              const SizedBox(height: 36),

              /// CTA
              const _PrimaryCTA(),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

/// ================= MOBILE CONTENT =================
class _MobileHeroContent extends StatelessWidget {
  const _MobileHeroContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 32,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
            children: [
              TextSpan(
                text: 'Services ',
                style: TextStyle(color: Color(0xFFFF7F5D)),
              ),
              TextSpan(
                text: 'Made Simple\n',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'Online ',
                style: TextStyle(color: Color(0xFFFF7F5D)),
              ),
              TextSpan(
                text: '& At Your Doorstep',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),

        SizedBox(height: 3.h),

        const TextWidget(
          'Book trusted professionals for offline services or '
          'get expert digital solutions online.',
          fontSize: 14,
          height: 1.6,
          color: Color(0xFFEAEAEA),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h),

        const _PrimaryCTA(),
      ],
    );
  }
}

/// ================= CTA BUTTON =================
class _PrimaryCTA extends StatelessWidget {
  const _PrimaryCTA();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: const BoxDecoration(color: Color(0xFFF08A5D)),
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
    );
  }
}

/// ================= NAVBAR =================
class _Navbar extends StatelessWidget {
  final bool isMobile;
  final Function(int)? onNavTap;

  const _Navbar({
    required this.isMobile,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/logo.png', height: 26),
        const Spacer(),

        if (!isMobile)
          Row(
            children: [
              NavItem(
                title: 'Home',
                isActive: true,
                onTap: () => onNavTap?.call(0),
              ),
              const SizedBox(width: 28),
              NavItem(
                title: 'Services',
                onTap: () => onNavTap?.call(1),
              ),
              const SizedBox(width: 28),
              NavItem(
                title: 'Requests',
                onTap: () => onNavTap?.call(2),
              ),
              const SizedBox(width: 28),
              NavItem(
                title: 'About',
                onTap: () => onNavTap?.call(3),
              ),
              const SizedBox(width: 28),
              NavItem(
                title: 'Contact',
                onTap: () => onNavTap?.call(4),
              ),
            ],
          ),

        const Spacer(),

        if (!isMobile)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
    );
  }
}