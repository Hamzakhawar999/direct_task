import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_web_navbar.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFF48C5A);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBlue = Color(0xFF4C4FA1);

class PreviousRequestDetailsScreen extends StatelessWidget {
  const PreviousRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          /// 🔙 TOP NAV (UNCHANGED)
          ProviderWebNavbar(
            showBack: true,
            onBack: () => Navigator.pop(context),
            currentIndex: 0,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 48),

                  Center(
                    child: SizedBox(
                      width: isDesktop ? 1000 : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 0 : 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _topInfoCard(isDesktop),
                            const SizedBox(height: 32),

                            const TextWidget(
                              'Proposal',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimary,
                            ),
                            const SizedBox(height: 12),

                            _proposalCard(),
                            const SizedBox(height: 24),

                            _providerCard(isDesktop),
                            const SizedBox(height: 40),

                            _chatButton(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 160),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= TOP INFO CARD =================
  Widget _topInfoCard(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// META ROW
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _metaItem('Date', '23 Mar 2024'),
                    _metaItem('Budget', '\$40'),
                    _metaItem('Time', '08:00 AM'),
                    _metaItem('Require', 'Plumber'),
                    _statusColumn(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 24,
                      runSpacing: 16,
                      children: [
                        _metaItem('Date', '23 Mar 2024'),
                        _metaItem('Budget', '\$40'),
                        _metaItem('Time', '08:00 AM'),
                        _metaItem('Require', 'Plumber'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _statusColumn(),
                  ],
                ),

          const SizedBox(height: 18),

          const TextWidget(
            'Need Plumber for service',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          const TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
            fontSize: 13,
            color: kGrey,
          ),
        ],
      ),
    );
  }

  Widget _statusColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: kPrimary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const TextWidget(
            'Pay through Cash',
            fontSize: 11,
            color: kPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        const TextWidget(
          'Posted 1 hour ago',
          fontSize: 11,
          color: kGrey,
        ),
      ],
    );
  }

  Widget _metaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(label, fontSize: 12, color: kBlue),
        const SizedBox(height: 4),
        TextWidget(
          value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  /// ================= PROPOSAL CARD =================
  Widget _proposalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _card(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            '\$18/hr',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: kPrimary,
          ),
          SizedBox(height: 12),
          TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
            fontSize: 14,
            color: kGrey,
            height: 1.6,
          ),
        ],
      ),
    );
  }

  /// ================= PROVIDER CARD =================
  Widget _providerCard(bool isDesktop) {
    if (isDesktop) {
      /// DESKTOP — UNCHANGED
      return _providerRow();
    }

    /// MOBILE / TABLET — STACKED
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/cleaner1.png',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        _providerInfo(),
      ],
    ).container(_card(), padding: const EdgeInsets.all(20));
  }

  Widget _providerRow() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _card(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/images/cleaner1.png',
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: _providerInfo()),
        ],
      ),
    );
  }

  Widget _providerInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          'Provider Name',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 4),
        TextWidget(
          '\$998.00',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kPrimary,
        ),
        SizedBox(height: 6),
        TextWidget(
          '★★★★★  7.5 · 154 orders',
          fontSize: 12,
          color: kGrey,
        ),
        SizedBox(height: 10),
        TextWidget(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          fontSize: 13,
          color: kGrey,
        ),
        SizedBox(height: 8),
        TextWidget(
          'View details',
          fontSize: 13,
          color: kPrimary,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  /// ================= CHAT BUTTON =================
  Widget _chatButton() {
    return Center(
      child: Container(
        height: 52,
        width: 260,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.center,
        child: const TextWidget(
          'Chat',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// ================= CARD DECORATION =================
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

/// SMALL EXTENSION (NO UI CHANGE)
extension on Widget {
  Widget container(BoxDecoration decoration, {EdgeInsets? padding}) {
    return Container(
      decoration: decoration,
      padding: padding,
      child: this,
    );
  }
}