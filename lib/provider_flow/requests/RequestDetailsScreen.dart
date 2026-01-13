import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_web_navbar.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFF48C5A);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBlue = Color(0xFF4C4FA1);

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;
    final bool isMobile = width < 768;

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          ProviderWebNavbar(
            showBack: true,
            onBack: () => Navigator.pop(context),
            currentIndex: 0,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: isMobile ? 32 : 80),

                  Center(
                    child: SizedBox(
                      width: isDesktop ? 1200 : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 0 : 16,
                        ),
                        child: Column(
                          children: [
                            _topSection(isDesktop),
                            const SizedBox(height: 48),
                            _ratingSection(isDesktop),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TOP SECTION =================
  Widget _topSection(bool isDesktop) {
    if (isDesktop) {
      /// DESKTOP — UNCHANGED
      return Row(
        children: [
          Expanded(child: _imageCard()),
          const SizedBox(width: 24),
          Expanded(child: _detailsCard()),
        ],
      );
    }

    /// MOBILE / TABLET — STACKED
    return Column(
      children: [
        _imageCard(),
        const SizedBox(height: 24),
        _detailsCard(),
      ],
    );
  }

  Widget _imageCard() {
    return Container(
      height: 496,
      decoration: _card(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/images/uncle.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _detailsCard() {
    return Container(
      height: 496,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            '\$18/hr',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: kPrimary,
          ),
          const SizedBox(height: 18),
          const TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
            'when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            fontSize: 14,
            color: kGrey,
            height: 1.6,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 52,
              width: 260,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const TextWidget(
                'Accept',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= RATING SECTION =================
  Widget _ratingSection(bool isDesktop) {
    if (isDesktop) {
      /// DESKTOP — UNCHANGED
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _ratingCard()),
          const SizedBox(width: 24),
          Expanded(child: _providerCard()),
        ],
      );
    }

    /// MOBILE / TABLET — STACKED
    return Column(
      children: [
        _ratingCard(),
        const SizedBox(height: 24),
        _providerCard(),
      ],
    );
  }

  Widget _ratingCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            '4.4 ★',
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 4),
          const TextWidget(
            '923 Ratings\nand 257 Reviews',
            fontSize: 13,
            color: kGrey,
          ),
          const SizedBox(height: 20),

          _ratingRow(5, 0.67, '67%'),
          _ratingRow(4, 0.20, '20%'),
          _ratingRow(3, 0.07, '7%'),
          _ratingRow(2, 0.02, '2%'),
          _ratingRow(1, 0.00, '0%'),

          const SizedBox(height: 24),

          _reviewTile(),
          const SizedBox(height: 12),
          _reviewTile(),

          const SizedBox(height: 24),

          Center(
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const TextWidget(
                'See More',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _providerCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Service: Cleaner',
            fontSize: 12,
            color: kPrimary,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextWidget(
                'Service provider Name',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              TextWidget(
                '\$18/hr',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kPrimary,
              ),
            ],
          ),
          const SizedBox(height: 6),
          const TextWidget(
            '★★★★★  9.3  ·  32 reviews',
            fontSize: 13,
            color: kGrey,
          ),
          const SizedBox(height: 16),
          const TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            fontSize: 14,
            color: kGrey,
            height: 1.6,
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================
  Widget _ratingRow(int star, double value, String percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 40, child: TextWidget('$star ★', fontSize: 12)),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              color: kBlue,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: TextWidget(percent, fontSize: 12, color: kGrey),
          ),
        ],
      ),
    );
  }

  Widget _reviewTile() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/Ellipse 2449.png'),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget('Jon Doe', fontSize: 13, fontWeight: FontWeight.w600),
                SizedBox(height: 4),
                TextWidget('★★★★★', fontSize: 12, color: kPrimary),
                SizedBox(height: 6),
                TextWidget(
                  'Lorem Ipsum is simply dummy text of the printing industry.',
                  fontSize: 12,
                  color: kGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _card() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      );
}