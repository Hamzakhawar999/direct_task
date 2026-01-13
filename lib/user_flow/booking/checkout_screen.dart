import 'package:direct_task_web/user_flow/booking/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

/// ================= CONSTANTS =================
const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A5B);
const Color kBlue = Color(0xFF4C4FA1);
const Color kGrey = Color(0xFF8A8A8A);
const Color kBorder = Color(0xFFE6E6E6);

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          /// ================= NAVBAR =================
          WebNavbar(
            showBack: true,
            currentIndex: -1,
            onTap: (_) {},
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// ================= MAIN CONTENT =================
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 24 : 16,
                        ),
                        child: isDesktop
                            ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _CheckoutItemCard()),
                                  SizedBox(width: 32),
                                  _SummaryColumn(),
                                ],
                              )
                            : const Column(
                                children: [
                                  _CheckoutItemCard(),
                                  SizedBox(height: 24),
                                  _SummaryColumn(),
                                ],
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
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

/// ================= LEFT CARD =================
class _CheckoutItemCard extends StatelessWidget {
  const _CheckoutItemCard();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: isDesktop
          ? _desktopRow()
          : _mobileColumn(),
    );
  }

  /// ================= DESKTOP =================
  Widget _desktopRow() {
    return SizedBox(
      height: 230,
      child: Row(
        children: [
          _image(),
          const SizedBox(width: 20),
          Expanded(child: _details()),
          _removeButton(),
        ],
      ),
    );
  }

  /// ================= MOBILE / TABLET =================
  Widget _mobileColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image(),
        const SizedBox(height: 16),
        _details(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: _removeButton(),
        ),
      ],
    );
  }

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/images/provider.jpg',
        width: 180,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          'Provider Name',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 6),
        const TextWidget(
          '\$998.00',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 6),

        Row(
          children: const [
            Icon(Icons.star, size: 14, color: Colors.orange),
            Icon(Icons.star, size: 14, color: Colors.orange),
            Icon(Icons.star, size: 14, color: Colors.orange),
            Icon(Icons.star, size: 14, color: Colors.orange),
            Icon(Icons.star_half, size: 14, color: Colors.orange),
            SizedBox(width: 6),
            TextWidget('7.5', fontSize: 12, color: kGrey),
            SizedBox(width: 10),
            TextWidget('154 orders', fontSize: 12, color: kGrey),
          ],
        ),

        const SizedBox(height: 10),

        const TextWidget(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
          fontSize: 13,
          color: kGrey,
          maxLines: 3,
        ),

        const SizedBox(height: 8),

        const TextWidget(
          'View details',
          fontSize: 13,
          color: kPrimary,
        ),
      ],
    );
  }

  Widget _removeButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextWidget(
        'Remove',
        fontSize: 13,
        color: kPrimary,
      ),
    );
  }
}

/// ================= RIGHT COLUMN =================
class _SummaryColumn extends StatelessWidget {
  const _SummaryColumn();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return SizedBox(
      width: isDesktop ? 302 : double.infinity,
      child: Column(
        children: const [
          _CouponCard(),
          SizedBox(height: 20),
          _SummaryCard(),
        ],
      ),
    );
  }
}

/// ================= COUPON =================
class _CouponCard extends StatelessWidget {
  const _CouponCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Have a coupon?',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorder),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextWidget(
                      'Add coupon',
                      fontSize: 14,
                      color: kGrey,
                    ),
                  ),
                ),
                Container(width: 1, color: kBorder),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextWidget(
                    'Apply',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SUMMARY =================
class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _row('Subtotal:', '\$1403.97'),
          const SizedBox(height: 10),
          _row('Discount:', '- \$60.00', color: Colors.red),
          const SizedBox(height: 10),
          _row('Tax:', '+ \$14.00', color: Colors.green),
          const Divider(height: 30),
          _row(
            'Total:',
            '\$1357.97',
            isBold: true,
            valueSize: 22,
          ),
          const SizedBox(height: 20),

          /// CHECKOUT BUTTON
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentScreen()),
              );
            },
            child: Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextWidget(
                'Checkout',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// PAYMENT ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _payIcon('assets/images/amex.png'),
              _payIcon('assets/images/mastercard.png'),
              _payIcon('assets/images/paypal.png'),
              _payIcon('assets/images/visa.png'),
              _payIcon('assets/images/applepay.png'),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _row(
    String label,
    String value, {
    Color color = Colors.black,
    bool isBold = false,
    double valueSize = 16,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(label, fontSize: 15),
        TextWidget(
          value,
          fontSize: valueSize,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          color: color,
        ),
      ],
    );
  }

  static Widget _payIcon(String path) {
    return Container(
      width: 44,
      height: 28,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Image.asset(path, fit: BoxFit.contain),
    );
  }
}