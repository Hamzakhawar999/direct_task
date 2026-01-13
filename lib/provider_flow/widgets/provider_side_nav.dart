import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

const Color kPrimary = Color(0xFFF48C5A);
const Color kGrey = Color(0xFF7A7A7A);

class ProviderSideNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const ProviderSideNav({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required String activeRoute,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return SizedBox(
      width: isDesktop ? 260 : double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            if (isDesktop)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _item(0, "Orders", Icons.layers_outlined),
              _item(1, "Requests", Icons.shopping_cart_outlined),
              _item(2, "Chats", Icons.chat),
              _item(3, "subscriptions", Icons.card_membership),
              _item(4, "Profile", Icons.person_outline),
              _item(5, "EdirProfile", Icons.edit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int index, String title, IconData icon) {
    final bool active = index == activeIndex;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: active ? kPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? Colors.white : kGrey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextWidget(
                title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : kGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}