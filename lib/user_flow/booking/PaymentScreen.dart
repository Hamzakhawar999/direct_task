import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

/// ================= CONSTANTS =================
const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFF48C5A);
const Color kBlue = Color(0xFF4C4FA1);
const Color kBorderGrey = Color(0xFFD1D1D1);
const Color kHintGrey = Color(0xFF9E9E9E);
const Color kTextGrey = Color(0xFF7A7A7A);

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedMethod = 0;
  bool paymentSuccess = false;

  final nameCtrl = TextEditingController();
  final cardCtrl = TextEditingController();
  final monthCtrl = TextEditingController();
  final yearCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();

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
                  SizedBox(height: isDesktop ? 60 : 32),

                  /// ================= MAIN =================
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 24 : 16,
                        ),
                        child: paymentSuccess
                            ? _successView(isDesktop)
                            : isDesktop
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _paymentMethodCard(isDesktop),
                                      const SizedBox(width: 32),
                                      _orderSummaryCard(isDesktop),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _paymentMethodCard(isDesktop),
                                      const SizedBox(height: 24),
                                      _orderSummaryCard(isDesktop),
                                    ],
                                  ),
                      ),
                    ),
                  ),

                  SizedBox(height: isDesktop ? 120 : 64),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= SUCCESS VIEW =================
  Widget _successView(bool isDesktop) {
    return Container(
      width: isDesktop ? 543 : double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 56 : 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 3),
            ),
            child: const Icon(Icons.check,
                color: Colors.green, size: 36),
          ),

          const SizedBox(height: 26),

          const TextWidget(
            'Your order is successfully placed',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          const TextWidget(
            'Pellentesque sed lectus nec tortor tristique accumsan quis dictum risus.',
            fontSize: 13,
            color: kTextGrey,
            textAlign: TextAlign.center,
            height: 1.6,
          ),

          const SizedBox(height: 36),

          Wrap(
            spacing: 14,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _outlineButton('GO TO DASHBOARD'),
              _filledButton('VIEW ORDER'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _outlineButton(String title) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimary),
      ),
      alignment: Alignment.center,
      child: TextWidget(
        title,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: kPrimary,
      ),
    );
  }

  Widget _filledButton(String title) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextWidget(
        title,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  /// ================= PAYMENT METHOD =================
  Widget _paymentMethodCard(bool isDesktop) {
    return Container(
      width: isDesktop ? 642 : double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Select Payment Method',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _methodButton(0, 'Credit Card', Icons.credit_card),
              _methodButton(1, 'Bank Transfer', Icons.sync_alt),
              _methodButton(2, 'Paypal', Icons.paypal),
            ],
          ),

          const SizedBox(height: 28),
          _label('Name on Card'),
          const SizedBox(height: 6),
          _input(nameCtrl, 'Name'),

          const SizedBox(height: 18),
          _label('Card Number'),
          const SizedBox(height: 6),
          _input(cardCtrl, 'XXXX XXXX XXXX XXXX',
              icon: Icons.credit_card),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(child: _input(monthCtrl, 'Select Month')),
              const SizedBox(width: 12),
              Expanded(child: _input(yearCtrl, 'Select Year')),
              const SizedBox(width: 12),
              Expanded(child: _input(cvvCtrl, 'CVV',
                  icon: Icons.info_outline)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return TextWidget(text,
        fontSize: 13, fontWeight: FontWeight.w500);
  }

  Widget _methodButton(int index, String title, IconData icon) {
    final active = selectedMethod == index;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => setState(() => selectedMethod = index),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: active ? kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorderGrey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 18,
                color: active ? Colors.white : kTextGrey),
            const SizedBox(width: 8),
            TextWidget(
              title,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: active ? Colors.white : kTextGrey,
            ),
          ],
        ),
      ),
    );
  }

  /// ================= SUMMARY =================
  Widget _orderSummaryCard(bool isDesktop) {
    return Container(
      width: isDesktop ? 439 : double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: kBorderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Order Summary',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TextWidget('Provider Name', fontSize: 15),
              TextWidget('\$998',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kPrimary),
            ],
          ),

          const SizedBox(height: 12),

          const TextWidget(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            fontSize: 13,
            color: kTextGrey,
            height: 1.6,
          ),

          const SizedBox(height: 24),

          GestureDetector(
            onTap: () {
              setState(() => paymentSuccess = true);
            },
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimary),
              ),
              alignment: Alignment.center,
              child: const TextWidget(
                'Pay Now',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INPUT =================
  Widget _input(
    TextEditingController controller,
    String hint, {
    IconData? icon,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorderGrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 13, color: kHintGrey),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (icon != null)
            Icon(icon, size: 18, color: kHintGrey),
        ],
      ),
    );
  }
}