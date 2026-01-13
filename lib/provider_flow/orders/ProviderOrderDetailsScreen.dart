import 'package:direct_task_web/provider_flow/widgets/provider_web_navbar.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';
import 'package:direct_task_web/provider_flow/orders/order_status.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kBlue = Color(0xFF4C4FA1);
const Color kPrimary = Color(0xFFFF8A65);
const Color kGrey = Color(0xFF7A7A7A);

class ProviderOrderDetailsScreen extends StatefulWidget {
  final OrderStatus status;
  final bool isPaid;

  const ProviderOrderDetailsScreen({
    super.key,
    required this.status,
    required this.isPaid,
  });

  @override
  State<ProviderOrderDetailsScreen> createState() =>
      _ProviderOrderDetailsScreenState();
}

class _ProviderOrderDetailsScreenState
    extends State<ProviderOrderDetailsScreen> {
  bool showReview = false;
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          Column(
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
                      const SizedBox(height: 32),

                      Center(
                        child: SizedBox(
                          width: isDesktop ? 1200 : double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 0 : 16,
                            ),
                            child: Column(
                              children: [
                                _bookingInfoCard(isDesktop),
                                const SizedBox(height: 20),
                                _providerCard(isDesktop),
                                const SizedBox(height: 32),
                                _bottomButton(isDesktop),
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

          if (showReview) _reviewPopup(),
        ],
      ),
    );
  }

  // ================= BOOKING INFO =================
  Widget _bookingInfoCard(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: isDesktop
                    ? Row(
                        children: [
                          _infoColumn("Date", "23 Mar 2024"),
                          _infoColumn("Budget", "\$40"),
                          _infoColumn("Start time", "08:00 AM"),
                          _infoColumn("End time", "10:00 AM"),
                        ],
                      )
                    : Wrap(
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          _infoColumn("Date", "23 Mar 2024"),
                          _infoColumn("Budget", "\$40"),
                          _infoColumn("Start time", "08:00 AM"),
                          _infoColumn("End time", "10:00 AM"),
                        ],
                      ),
              ),
              _statusChip(),
            ],
          ),
          const SizedBox(height: 16),
          const TextWidget(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            fontSize: 13,
            color: kGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(label, fontSize: 12, color: kBlue),
          const SizedBox(height: 4),
          TextWidget(value, fontSize: 14, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }

  Widget _statusChip() {
    final bool isPending = widget.status == OrderStatus.pending;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF1FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextWidget(
            isPending ? "Pending" : "Request Accepted",
            fontSize: 12,
            color: kBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: kPrimary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TextWidget(
            "Pay through Cash",
            fontSize: 12,
            color: kPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ================= PROVIDER CARD =================
  Widget _providerCard(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: isDesktop
          ? Row(
              children: [
                _providerImage(),
                const SizedBox(width: 20),
                Expanded(child: _providerInfo()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _providerImage(),
                const SizedBox(height: 16),
                _providerInfo(), // ❗ NO Expanded here
              ],
            ),
    );
  }

  Widget _providerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/images/cleaner1.png',
        width: 160,
        height: 160,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _providerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TextWidget("Provider Name",
            fontSize: 16, fontWeight: FontWeight.w700),
        SizedBox(height: 6),
        TextWidget("\$998.00",
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kPrimary),
        SizedBox(height: 6),
        TextWidget("★★★★★  7.5 · 154 orders",
            fontSize: 12, color: kGrey),
        SizedBox(height: 10),
        TextWidget(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          fontSize: 13,
          color: kGrey,
        ),
        SizedBox(height: 10),
        TextWidget("View details",
            fontSize: 13,
            color: kPrimary,
            fontWeight: FontWeight.w600),
      ],
    );
  }

  // ================= BUTTONS =================
  Widget _bottomButton(bool isDesktop) {
    if (widget.isPaid) {
      return _buttonRow(
        isDesktop,
        _primaryButton("Message"),
        _outlineBlueButton("Review", () => setState(() => showReview = true)),
      );
    }

    if (widget.status == OrderStatus.pending) {
      return _primaryButton("Cancel Request");
    }

    return _buttonRow(
      isDesktop,
      _primaryButton("Confirm Booking"),
      _outlineBlueButton("Review", () => setState(() => showReview = true)),
    );
  }

  Widget _buttonRow(bool isDesktop, Widget a, Widget b) {
    return isDesktop
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 200, child: a),
              const SizedBox(width: 16),
              SizedBox(width: 200, child: b),
            ],
          )
        : Column(
            children: [
              SizedBox(width: double.infinity, child: a),
              const SizedBox(height: 14),
              SizedBox(width: double.infinity, child: b),
            ],
          );
  }

  Widget _primaryButton(String text) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: TextWidget(
        text,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget _outlineBlueButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kBlue),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          text,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: kBlue,
        ),
      ),
    );
  }

  // ================= REVIEW POPUP =================
  Widget _reviewPopup() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.45),
        alignment: Alignment.center,
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget("Reviews",
                  fontSize: 16, fontWeight: FontWeight.w700),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => IconButton(
                    icon: Icon(
                      Icons.star,
                      color: i < rating
                          ? const Color(0xFFFFC107)
                          : Colors.grey.shade300,
                    ),
                    onPressed: () => setState(() => rating = i + 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => setState(() => showReview = false),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: const TextWidget(
                    "Save",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
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
}