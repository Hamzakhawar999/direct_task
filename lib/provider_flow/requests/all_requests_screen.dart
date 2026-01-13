import 'package:direct_task_web/provider_flow/requests/ProposalsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/provider_flow/requests/RequestDetailsScreen.dart';
import 'package:direct_task_web/provider_flow/requests/PreviousRequestDetailsScreen.dart';

/// ================= CONSTANTS =================
const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A65);
const Color kBlue = Color(0xFF4C4FA1);
const Color kGrey = Color(0xFF7A7A7A);

class AllTaskListScreen extends StatefulWidget {
  const AllTaskListScreen({super.key});

  @override
  State<AllTaskListScreen> createState() => _AllTaskListScreenState();
}

class _AllTaskListScreenState extends State<AllTaskListScreen> {
  /// ✅ SINGLE SOURCE OF TRUTH
  bool isOngoing = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;

    return Container(
      color: kBg,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _toggleTabs(),
              const SizedBox(height: 30),

              /// ================= TASK GRID =================
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isDesktop
                      ? 3.4
                      : isTablet
                          ? 3.2
                          : 2.9,
                ),
                itemBuilder: (_, __) {
                  return _taskCard(
                    isOngoing: isOngoing,
                    isPrevious: !isOngoing,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= TOGGLE =================
  Widget _toggleTabs() {
    return Row(
      children: [
        _tabButton(
          title: 'Ongoing Requests',
          active: isOngoing,
          onTap: () => setState(() => isOngoing = true),
        ),
        const SizedBox(width: 12),
        _tabButton(
          title: 'Previous Requests',
          active: !isOngoing,
          onTap: () => setState(() => isOngoing = false),
        ),
      ],
    );
  }

  Widget _tabButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        decoration: BoxDecoration(
          color: active ? kBlue : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: active ? kBlue : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          title,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: active ? Colors.white : kGrey,
        ),
      ),
    );
  }

  /// ================= TASK CARD =================
  Widget _taskCard({
    required bool isOngoing,
    required bool isPrevious,
  }) {
    return GestureDetector(
      onTap: () {
        if (isOngoing) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProposalsListScreen(),
            ),
          );
        } else if (isPrevious) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PreviousRequestDetailsScreen(),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  'Need plumber For Service',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const TextWidget(
                    'Budget: \$100',
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const TextWidget(
              'Posted 1 hour ago',
              fontSize: 12,
              color: kPrimary,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),
            const TextWidget(
              'Lorem Ipsum is simply dummy text of the printing industry.',
              fontSize: 12.5,
              color: kGrey,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}