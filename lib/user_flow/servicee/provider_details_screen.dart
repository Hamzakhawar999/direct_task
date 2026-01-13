import 'package:direct_task_web/user_flow/booking/booking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/user_flow/home/widgets/OurServiceProvidersSection.dart';

class ProviderDetailsScreen extends StatelessWidget {
  const ProviderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Column(
        children: [
          /// ================= NAVBAR =================
          WebNavbar(
            showBack: true,
            onBack: () => Navigator.pop(context),
            currentIndex: -1,
            onTap: (_) {},
          ),

          /// ================= CONTENT =================
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 48 : 16,
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        /// ================= TOP =================
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1320),
                            child: isDesktop
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Expanded(
                                        child: _ProviderImage(height: 496),
                                      ),
                                      SizedBox(width: 24),
                                      Expanded(
                                        child: _ProviderInfoCard(
                                          forceHeight: 496,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: const [
                                      _ProviderImage(),
                                      SizedBox(height: 24),
                                      _ProviderInfoCard(),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        /// ================= BOTTOM =================
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1320),
                            child: isDesktop
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Expanded(child: _ReviewsSection()),
                                      SizedBox(width: 24),
                                      Expanded(
                                        child: _OtherServicesSection(
                                          isDesktop: true,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: const [
                                      _ReviewsSection(),
                                      SizedBox(height: 24),
                                      _OtherServicesSection(
                                        isDesktop: false,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ================= FOOTER =================
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= IMAGE =================
class _ProviderImage extends StatelessWidget {
  final double? height;
  const _ProviderImage({this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: height != null
          ? SizedBox(
              height: height,
              width: double.infinity,
              child: Image.asset(
                'assets/images/provider_sample.png',
                fit: BoxFit.cover,
              ),
            )
          : AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                'assets/images/provider_sample.png',
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}

/// ================= INFO CARD =================
class _ProviderInfoCard extends StatelessWidget {
  final double? forceHeight;
  const _ProviderInfoCard({this.forceHeight});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Container(
      constraints: isDesktop && forceHeight != null
          ? BoxConstraints.tightFor(height: forceHeight)
          : const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextWidget(
            'Service: Cleaner',
            fontSize: 13,
            color: Color(0xFFF48C5A),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10),

          Row(
            children: const [
              Expanded(
                child: TextWidget(
                  'Service provider Name',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextWidget(
                '\$18/hr',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF48C5A),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: const [
              Icon(Icons.star, size: 18, color: Color(0xFFFFB703)),
              Icon(Icons.star, size: 18, color: Color(0xFFFFB703)),
              Icon(Icons.star, size: 18, color: Color(0xFFFFB703)),
              Icon(Icons.star, size: 18, color: Color(0xFFFFB703)),
              Icon(Icons.star_half, size: 18, color: Color(0xFFFFB703)),
              SizedBox(width: 10),
              TextWidget('9.3', fontSize: 14),
              SizedBox(width: 6),
              TextWidget('•', color: Colors.grey),
              SizedBox(width: 6),
              Icon(Icons.chat_bubble_outline,
                  size: 16, color: Colors.grey),
              SizedBox(width: 6),
              TextWidget('32 reviews',
                  fontSize: 13, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 22),

          const TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            fontSize: 15,
            height: 1.6,
            color: Color(0xFF9A9A9A),
          ),

          const SizedBox(height: 28),

          /// BUTTONS (CENTERED – DESKTOP & MOBILE SAFE)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingDetailsScreen(),
                    ),
                  );
                },
                child: const _PrimaryButton(
                  title: 'Set Schedule',
                  color: Color(0xFFF48C5A),
                  showArrow: true,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingDetailsScreen(),
                    ),
                  );
                },
                child: const _PrimaryButton(
                  title: 'Chat With Provider',
                  color: Color(0xFF4C4FA1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ================= BUTTON =================
class _PrimaryButton extends StatelessWidget {
  final String title;
  final Color color;
  final bool showArrow;

  const _PrimaryButton({
    required this.title,
    required this.color,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          if (showArrow) ...[
            const SizedBox(width: 12),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 16,
                color: Color(0xFFF48C5A),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// ================= REVIEWS =================
class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              TextWidget('4.4', fontSize: 36, fontWeight: FontWeight.w700),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.amber, size: 26),
            ],
          ),
          SizedBox(height: 4),
          TextWidget(
            '923 Ratings and 257 Reviews',
            fontSize: 13,
            color: Colors.grey,
          ),
          SizedBox(height: 24),
          _ReviewItem(),
          SizedBox(height: 16),
          _ReviewItem(),
          SizedBox(height: 24),
          Center(child: _SeeMoreButton()),
        ],
      ),
    );
  }
}

/// ================= OTHER SERVICES =================
class _OtherServicesSection extends StatelessWidget {
  final bool isDesktop;
  const _OtherServicesSection({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          'Other Services',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 2 : (width > 600 ? 2 : 1),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: isDesktop ? 0.75 : 0.9,
          ),
          itemBuilder: (_, __) => const ProviderCardItem(),
        ),
      ],
    );
  }
}

/// ================= REVIEW ITEM =================
class _ReviewItem extends StatelessWidget {
  const _ReviewItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TextWidget('Jon Doe', fontSize: 14, fontWeight: FontWeight.w600),
          SizedBox(height: 4),
          TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            fontSize: 12.5,
            color: Colors.grey,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

/// ================= SEE MORE =================
class _SeeMoreButton extends StatelessWidget {
  const _SeeMoreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: const Color(0xFFF48C5A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TextWidget(
            'See More',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}