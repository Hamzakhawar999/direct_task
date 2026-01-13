import 'package:flutter/material.dart';
import 'package:direct_task_web/provider_flow/orders/ProviderOrderDetailsScreen.dart'
    hide OrderStatus, kPrimary;
import 'package:direct_task_web/provider_flow/orders/order_status.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/user_flow/booking/booking_details_screen.dart'
    show kPrimary;

/// ================= CONSTANTS =================
const Color kBg = Color(0xFFF9F9FB);
const Color kBlue = Color(0xFF4C4FA1);
const Color kTextGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);

enum ProviderOrderTab { requests, ongoing, previous }

class ProviderOrdersActiveScreen extends StatefulWidget {
  const ProviderOrdersActiveScreen({super.key});

  @override
  State<ProviderOrdersActiveScreen> createState() =>
      _ProviderOrdersActiveScreenState();
}

class _ProviderOrdersActiveScreenState
    extends State<ProviderOrdersActiveScreen> {
  ProviderOrderTab activeTab = ProviderOrderTab.requests;

  final List<Map<String, dynamic>> orders = [
    {"status": OrderStatus.pending, "paid": false, "date": null},
    {"status": OrderStatus.accepted, "paid": false, "date": null},
    {"status": OrderStatus.accepted, "paid": true, "date": "12 Jun 2025"},
    {"status": OrderStatus.accepted, "paid": true, "date": "14 Jun 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _filteredOrders();
    final width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _toggle(isDesktop),
          const SizedBox(height: 28),

          /// 🔥 GRID FIX (WEB UNTOUCHED)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredOrders.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop || isTablet ? 2 : 1,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isDesktop
                  ? 460 / 166
                  : isTablet
                      ? 440 / 180
                      : 360 / 200,
            ),
            itemBuilder: (_, index) {
              return _orderCard(filteredOrders[index]);
            },
          ),
        ],
      ),
    );
  }

  /// ================= TAB FILTER =================
  List<Map<String, dynamic>> _filteredOrders() {
    switch (activeTab) {
      case ProviderOrderTab.requests:
        return orders
            .where((o) => o["status"] == OrderStatus.pending)
            .toList();
      case ProviderOrderTab.ongoing:
        return orders
            .where((o) =>
                o["status"] == OrderStatus.accepted && o["paid"] == false)
            .toList();
      case ProviderOrderTab.previous:
        return orders.where((o) => o["paid"] == true).toList();
    }
  }

  /// ================= TOGGLE =================
  Widget _toggle(bool isDesktop) {
    if (isDesktop) {
      return Row(
        children: [
          _tab('Requests', ProviderOrderTab.requests),
          const SizedBox(width: 12),
          _tab('Ongoing Orders', ProviderOrderTab.ongoing),
          const SizedBox(width: 12),
          _tab('Previous Orders', ProviderOrderTab.previous),
        ],
      );
    }

    /// 📱 MOBILE / TABLET ONLY
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _tab('Requests', ProviderOrderTab.requests),
        const SizedBox(height: 12),
        _tab('Ongoing Orders', ProviderOrderTab.ongoing),
        const SizedBox(height: 12),
        _tab('Previous Orders', ProviderOrderTab.previous),
      ],
    );
  }

  Widget _tab(String title, ProviderOrderTab tab) {
    final bool active = activeTab == tab;

    return GestureDetector(
      onTap: () => setState(() => activeTab = tab),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: active ? kBlue : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kBorder),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          title,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: active ? Colors.white : kTextGrey,
        ),
      ),
    );
  }

  /// ================= ORDER CARD (FULLY RESTORED) =================
  Widget _orderCard(Map<String, dynamic> order) {
    final OrderStatus status = order["status"];
    final bool paid = order["paid"] ?? false;
    final String? date = order["date"];

    final String badgeText = activeTab == ProviderOrderTab.previous
        ? (date ?? '')
        : status == OrderStatus.pending
            ? 'Pending'
            : 'Request Accepted';

    Widget action;

    if (activeTab == ProviderOrderTab.requests) {
      action = _softButton('Request Sent');
    } else if (activeTab == ProviderOrderTab.ongoing) {
      action = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProviderOrderDetailsScreen(
                status: status,
                isPaid: paid,
              ),
            ),
          );
        },
        child: _blueButton('Click to Confirm Order'),
      );
    } else {
      action = Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProviderOrderDetailsScreen(
                      status: status,
                      isPaid: paid,
                    ),
                  ),
                );
              },
              child: _primaryButton('Message'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _outlineBlueButton('Review')),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/cleaner1.png',
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      'Provider Name',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    _badge(badgeText),
                  ],
                ),
                const SizedBox(height: 6),
                const TextWidget(
                  'Plumber',
                  fontSize: 12,
                  color: kTextGrey,
                ),
                const SizedBox(height: 8),
                const TextWidget(
                  'Lorem Ipsum is simply dummy text of the printing industry.',
                  fontSize: 12,
                  color: kTextGrey,
                  maxLines: 2,
                ),
                const Spacer(),
                action,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= HELPERS =================
  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextWidget(
        text,
        fontSize: 11,
        color: kBlue,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _primaryButton(String text) => _btn(text, kPrimary, Colors.white);
  Widget _blueButton(String text) => _btn(text, kBlue, Colors.white);
  Widget _softButton(String text) =>
      _btn(text, kPrimary.withOpacity(0.15), kPrimary);

  Widget _btn(String text, Color bg, Color fg) {
    return Container(
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextWidget(
        text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: fg,
      ),
    );
  }
}

Widget _outlineBlueButton(String text) {
  return Container(
    height: 34,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kBlue),
    ),
    child: TextWidget(
      text,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: kBlue,
    ),
  );
}