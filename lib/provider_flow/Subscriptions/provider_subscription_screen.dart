import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_side_nav.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A65);
const Color kBlue = Color(0xFF4C4FA1);
const Color kGrey = Color(0xFF7A7A7A);

class ProviderSubscriptionScreen extends StatelessWidget {
  const ProviderSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= SIDENAV =================
         

          const SizedBox(width: 40),

          /// ================= CONTENT =================
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 900, // 🔒 FIGMA WIDTH
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    const TextWidget(
                      'This is dummy data for subscription',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),

                    const SizedBox(height: 8),

                    const SizedBox(
                      width: 520,
                      child: TextWidget(
                        'We have several powerful plans to showcase your business '
                        'and get discovered as creative entrepreneurs.',
                        fontSize: 14,
                        height: 1.6,
                        color: kGrey,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 48),

                    /// PLANS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _MonthlyPlanCard(),
                        SizedBox(width: 32),
                        _YearlyPlanCard(),
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
class _MonthlyPlanCard extends StatelessWidget {
  const _MonthlyPlanCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 520,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              'Monthly',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 24),

            _feature('Lorem ipsum text here for test'),
            _feature('Lorem ipsum text here for test'),
            _featureDisabled('Set your rates'),
            _featureDisabled('Exclusive Deals'),
            _featureDisabled('Advanced Statistics'),

            const Spacer(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                TextWidget('\$123', fontSize: 28, fontWeight: FontWeight.bold),
                SizedBox(width: 6),
                TextWidget('/month', fontSize: 14, color: kGrey),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F1FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextWidget(
                'Choose',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feature(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            const Icon(Icons.check, size: 18, color: kPrimary),
            const SizedBox(width: 10),
            Expanded(child: TextWidget(text, fontSize: 14)),
          ],
        ),
      );

  Widget _featureDisabled(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: const [
            Icon(Icons.close, size: 18, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: TextWidget(
                'Advanced Statistics',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
}

class _YearlyPlanCard extends StatelessWidget {
  const _YearlyPlanCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 520, // 🔒 FIXED HEIGHT (CRITICAL – DO NOT REMOVE)
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  'Yearly',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextWidget(
                    'Save \$40',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kPrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _feature('Upload Video with HD Resolution'),
            _feature('Attachment & Post Scheduling'),
            _feature('Set your rates'),
            _feature('Exclusive Deals'),
            _featureDisabled('Advanced Statistics'),

            const Spacer(),

            /// PRICE
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                TextWidget(
                  '\$123',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(width: 6),
                TextWidget(
                  '/month',
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// CTA BUTTON
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextWidget(
                'Try 1 month',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= FEATURES =================

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(Icons.check, size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: TextWidget(
              text,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureDisabled(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(Icons.close, size: 18, color: Colors.white70),
          const SizedBox(width: 10),
          Expanded(
            child: TextWidget(
              text,
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}