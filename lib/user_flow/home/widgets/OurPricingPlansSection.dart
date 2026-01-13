import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class OurPricingPlansSection extends StatelessWidget {
  const OurPricingPlansSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 768;
        final bool isTablet =
            constraints.maxWidth >= 768 && constraints.maxWidth < 1200;

        return SizedBox(
          width: double.infinity,

          // ✅ FIX: mobile = flexible height, desktop unchanged
          height: isMobile
              ? null
              : isTablet
                  ? 1250
                  : 920,

          child: Stack(
            children: [
              /// ================= BACKGROUND =================
              Positioned.fill(
                child: Image.asset(
                  'assets/images/pricing_bg.png',
                  fit: BoxFit.cover,
                ),
              ),

              /// ================= CONTENT =================
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Column(
                    mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      const SizedBox(height: 96),

                      /// ================= TITLE =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            'Our ',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                          TextWidget(
                            'Pricing ',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF7F5D),
                          ),
                          TextWidget(
                            'Plans',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// ================= SUBTITLE =================
                      SizedBox(
                        width: isMobile ? 90.w : 55.w,
                        child: const TextWidget(
                          'Simple and transparent pricing — choose a plan or service '
                          'that fits your needs, with no hidden charges.',
                          fontSize: 16,
                          height: 1.6,
                          color: Color(0xFF5C5E5E),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 64),

                      /// ================= CARDS =================
                      if (!isMobile && !isTablet)
                        /// ================= DESKTOP (UNCHANGED) =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            PricingPlanCard(
                              title: 'Customer Plan',
                              price: '\$66.0',
                            ),
                            SizedBox(width: 32),
                            PricingPlanCard(
                              title: 'Provider Plan',
                              price: '\$66.0',
                            ),
                            SizedBox(width: 32),
                            ProviderCard(),
                          ],
                        )
                      else if (isTablet)
                        /// ================= TABLET =================
                        Column(
                          children: const [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PricingPlanCard(
                                  title: 'Customer Plan',
                                  price: '\$66.0',
                                ),
                                SizedBox(width: 32),
                                PricingPlanCard(
                                  title: 'Provider Plan',
                                  price: '\$66.0',
                                ),
                              ],
                            ),
                            SizedBox(height: 48),
                            ProviderCard(),
                          ],
                        )
                      else
                        /// ================= MOBILE (FIXED) =================
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              PricingPlanCard(
                                title: 'Customer Plan',
                                price: '\$66.0',
                              ),
                              SizedBox(height: 32),
                              PricingPlanCard(
                                title: 'Provider Plan',
                                price: '\$66.0',
                              ),
                              SizedBox(height: 32),
                              ProviderCard(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ================= PRICING CARD =================
class PricingPlanCard extends StatelessWidget {
  final String title;
  final String price;

  const PricingPlanCard({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 553, // 🔒 EXACT SAME HEIGHT
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const TextWidget(
              'Our foundation plan offers essential features '
              'at affordable price breaking the bank.',
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF5C5E5E),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextWidget(
                  price,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF7F5D),
                ),
                const SizedBox(width: 8),
                const TextWidget(
                  '/ Per Month',
                  fontSize: 14,
                  color: Color(0xFF5C5E5E),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _feature('All Cleaning Tasks'),
            _feature('Deep Cleaning & Sanitization'),
            _feature('Green Cleaning Products Provided'),
            _feature('Advanced Cleaning Technology'),
            _feature('Scheduled Maintenance Plans'),
            _feature('24/7 Customer Support'),
            const Spacer(),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF48C5A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextWidget(
                    'Purchase Now',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle,
              size: 18, color: Color(0xFFFF7F5D)),
          const SizedBox(width: 10),
          Expanded(
            child: TextWidget(text, fontSize: 14),
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
    return SizedBox(
      width: 367,
      height: 553,
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