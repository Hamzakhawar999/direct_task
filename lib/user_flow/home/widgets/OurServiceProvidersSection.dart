import 'package:direct_task_web/user_flow/servicee/provider_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class OurServiceProvidersSection extends StatelessWidget {
  const OurServiceProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width < 1100) crossAxisCount = 2;
    if (width < 768) crossAxisCount = 1;

    final bool isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          /// ================= HEADER =================
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
              ),
              child: isMobile
                  ? _mobileHeader()
                  : _desktopHeader(),
            ),
          ),

          SizedBox(height: isMobile ? 40 : 64),

          /// ================= GRID =================
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 20 : 32,
                  mainAxisSpacing: isMobile ? 20 : 32,
                  childAspectRatio: isMobile ? 0.82 : 0.78,
                ),
                itemBuilder: (_, __) => const ProviderCardItem(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= DESKTOP HEADER =================
  Widget _desktopHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// TITLE + SUBTITLE
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  TextWidget(
                    'Our Service ',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E1E),
                  ),
                  TextWidget(
                    'Providers',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF7F5D),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextWidget(
                'Browse and connect with verified service providers offering both '
                'online and offline services — trusted, skilled, and ready to help.',
                fontSize: 16,
                height: 1.6,
                color: Color(0xFF5C5E5E),
              ),
            ],
          ),
        ),

        _ctaButton(),
      ],
    );
  }

  /// ================= MOBILE HEADER =================
  Widget _mobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            TextWidget(
              'Our Service ',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1E1E),
            ),
            TextWidget(
              'Providers',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF7F5D),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const TextWidget(
          'Browse and connect with verified service providers offering both '
          'online and offline services — trusted, skilled, and ready to help.',
          fontSize: 15,
          height: 1.6,
          color: Color(0xFF5C5E5E),
        ),
        const SizedBox(height: 20),
        _ctaButton(),
      ],
    );
  }

  /// ================= CTA =================
  Widget _ctaButton() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF48C5A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextWidget(
            'See All Providers',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 14,
              color: Color(0xFFF48C5A),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PROVIDER CARD =================
class ProviderCardItem extends StatelessWidget {
  const ProviderCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProviderDetailsScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/images/provider_sample.png',
                height: isMobile ? 180 : 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextWidget(
                'Provider Name',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  TextWidget(
                    'Cleaner',
                    fontSize: 13,
                    color: Color(0xFF4F53A6),
                  ),
                  Spacer(),
                  TextWidget(
                    '\$18/hr',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF48C5A),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.star, size: 14, color: Color(0xFFFFB703)),
                  SizedBox(width: 6),
                  TextWidget(
                    '4.5 (4 reviews)',
                    fontSize: 13,
                    color: Color(0xFF5C5E5E),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 14,
                    color: Color(0xFFF48C5A),
                  ),
                  SizedBox(width: 6),
                  TextWidget(
                    '5 waiting in line jobs',
                    fontSize: 13,
                    color: Color(0xFF5C5E5E),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}