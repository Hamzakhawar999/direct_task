import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title,
            fontSize: 14,
            color: Colors.white,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 18,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}