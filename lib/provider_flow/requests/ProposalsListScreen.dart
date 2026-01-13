import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_web_navbar.dart';
import 'package:direct_task_web/provider_flow/requests/RequestDetailsScreen.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFF48C5A);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBlue = Color(0xFF4C4FA1);

class ProposalsListScreen extends StatelessWidget {
  const ProposalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          /// NAVBAR
          ProviderWebNavbar(
            showBack: true,
            onBack: () => Navigator.pop(context),
            currentIndex: 0,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Center(
                    child: SizedBox(
                      width: isDesktop ? 1100 : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 0 : 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _requestSummary(isDesktop),
                            const SizedBox(height: 32),
                            _proposalHeader(),
                            const SizedBox(height: 20),
                            _proposalGrid(context, isDesktop, isTablet),
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

  /// ================= REQUEST SUMMARY =================
  Widget _requestSummary(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _summaryItems(),
                )
              : Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  children: _summaryItems(),
                ),
          const SizedBox(height: 16),
          const TextWidget(
            'Need Plumber for service',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),
          const TextWidget(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            fontSize: 13,
            color: kGrey,
          ),
        ],
      ),
    );
  }

  List<Widget> _summaryItems() {
    return [
      _meta('Date', '23 Mar 2024'),
      _meta('Budget', '\$40'),
      _meta('Time', '08:00 AM'),
      _meta('Require', 'Plumber'),
      Column(
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
      ),
    ];
  }

  Widget _meta(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title, fontSize: 12, color: kBlue),
        const SizedBox(height: 4),
        TextWidget(value, fontSize: 14, fontWeight: FontWeight.w600),
      ],
    );
  }

  /// ================= HEADER =================
  Widget _proposalHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextWidget(
          'Proposals',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: kPrimary,
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: const TextWidget(
            'Stop Taking Proposal',
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// ================= PROPOSAL GRID =================
  Widget _proposalGrid(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 2 : 1,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isDesktop
            ? 2.9
            : isTablet
                ? 2.6
                : 1.9,
      ),
      itemBuilder: (_, __) {
        return _providerCard(context, isDesktop);
      },
    );
  }

  /// ================= PROVIDER CARD =================
  Widget _providerCard(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _card(),
      child: isDesktop
          ? Row(
              children: _providerCardChildren(context),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _providerCardChildren(context),
            ),
    );
  }

  List<Widget> _providerCardChildren(BuildContext context) {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          'assets/images/cleaner1.png',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 16, height: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextWidget(
                  'Provider Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  '\$40',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kPrimary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const TextWidget(
              'Plumber  ★★★★★ 7.5 · 154 orders',
              fontSize: 12,
              color: kGrey,
            ),
            const SizedBox(height: 8),
            const TextWidget(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              fontSize: 12,
              color: kGrey,
              maxLines: 2,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RequestDetailsScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 36,
                  width: 120,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const TextWidget(
                    'Accept',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
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