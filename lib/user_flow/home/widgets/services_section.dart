import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1100;

    return Container(
      width: double.infinity,

      // ✅ FIX: only mobile needs height, desktop must be flexible
      constraints: BoxConstraints(
        minHeight: isDesktop ? 980 : 1100,
      ),

      child: Stack(
        children: [
          /// ================= BACKGROUND =================
          Positioned.fill(
            child: Image.asset(
              'assets/images/group-3.png',
              fit: BoxFit.cover,
            ),
          ),

          /// ================= WHITE OVERLAY =================
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.85)),
          ),

          /// ================= CONTENT =================
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isDesktop ? 8.h : 6.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ================= TITLE =================
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: isDesktop ? 48 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(text: 'We Are '),
                          TextSpan(
                            text: 'Provide The Best ',
                            style: TextStyle(color: Color(0xFFFF7F5D)),
                          ),
                          TextSpan(text: 'Services'),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),

                    SizedBox(
                      width: isDesktop ? 40.w : 85.w,
                      child: const TextWidget(
                        'Quality, convenience, and trusted solutions — all designed '
                        'to make your life and business easier.',
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF5C5E5E),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 7.h),

                    /// ================= SERVICE CARDS =================
                    Wrap(
                      spacing: 32,
                      runSpacing: 48,
                      alignment: WrapAlignment.center,
                      children: const [
                        ServiceImageCard(
                          image: 'assets/images/service_offline.png',
                          title: 'Offline Services At Your Doorstep',
                          description:
                              'The housekeepers we hired are professional who take pride '
                              'in doing excellent work and exceeding expectations.',
                        ),
                        ServiceImageCard(
                          image: 'assets/images/service_digital.png',
                          title: 'Digital Solutions For Your Business',
                          description:
                              'From logo design and web & app development to SEO and expert '
                              'Q&A — everything you need to grow online.',
                        ),
                        ProviderCard(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SERVICE IMAGE CARD =================
class ServiceImageCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ServiceImageCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.width < 768;

    final double cardWidth = isMobile ? 88.w : 360;
    final double cardHeight = isMobile ? 520 : 553;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// IMAGE
          ClipPath(
            clipper: BottomCenterNotchClipper(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                image,
                width: cardWidth,
                height: cardHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// GLASS CARD
          Positioned(
            left: 16,
            right: 16,
            bottom: 72,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B5EA6).withOpacity(0.78),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title,
                        fontSize: isMobile ? 15.sp : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.25),
                      ),
                      const SizedBox(height: 12),
                      TextWidget(
                        description,
                        fontSize: isMobile ? 13.sp : 14,
                        height: 1.6,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// CTA BUTTON
          Positioned(
            bottom: -28,
            right: 30,
            child: Image.asset(
              'assets/images/Link.png',
              width: 56,
              height: 56,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PROVIDER CARD =================
class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.width < 768;

    return SizedBox(
      width: isMobile ? 88.w : 367,
      height: isMobile ? 520 : 553,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.asset(
          'assets/images/provider_person.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// ================= CLIPPER =================
class BottomCenterNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double notchRadius = 32;
    final double centerX = size.width - 26 - notchRadius;
    final double bottom = size.height;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, bottom)
      ..lineTo(centerX + notchRadius, bottom)
      ..arcToPoint(
        Offset(centerX - notchRadius, bottom),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(0, bottom)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}