import 'package:flutter/material.dart';
import 'package:direct_task_web/provider_flow/Subscriptions/provider_subscription_screen.dart';
import 'package:direct_task_web/provider_flow/chat/provider_chat_screen.dart';
import 'package:direct_task_web/provider_flow/profile/ProviderChangePasswordScreen.dart';
import 'package:direct_task_web/provider_flow/profile/ProviderEditProfileScreen.dart';
import 'package:direct_task_web/provider_flow/orders/provider_orders_screen.dart';
import 'package:direct_task_web/provider_flow/requests/all_requests_screen.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_side_nav.dart';
import 'package:direct_task_web/provider_flow/widgets/provider_web_navbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

class ProviderNavScaffold extends StatefulWidget {
  final int currentIndex;

  const ProviderNavScaffold({
    super.key,
    required this.currentIndex,
  });

  @override
  State<ProviderNavScaffold> createState() => _ProviderNavScaffoldState();
}

class _ProviderNavScaffoldState extends State<ProviderNavScaffold> {
  late int _index;

  final List<Widget> _pages = const [
    ProviderOrdersActiveScreen(), // 0 → Orders
    AllTaskListScreen(),          // 1 → Requests
    ProviderChatScreen(),         // 2 → Chat
    ProviderSubscriptionScreen(), // 3 → Subscription
    ProviderEditProfileScreen(),  // 4 → Edit Profile
    ProviderChangePasswordScreen(), // 5 → Change Password
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.currentIndex;
  }

  void _onSidebarTap(int index) {
    if (_index == index) return;
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Column(
        children: [
          /// 🟦 TOP NAVBAR (UNCHANGED)
          const ProviderWebNavbar(currentIndex: 0),

          /// 🟧 BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: isDesktop ? 32 : 20),

                  /// ================= MAIN CONTENT =================
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 0 : 16,
                        ),
                        child: isDesktop
                            /// 🖥 DESKTOP → SAME ROW LAYOUT (UNTOUCHED)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProviderSideNav(
                                    activeIndex: _index,
                                    onTap: _onSidebarTap,
                                    activeRoute: '',
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(child: _pages[_index]),
                                ],
                              )

                            /// 📱 MOBILE / TABLET → STACKED (RESPONSIVE ONLY)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProviderSideNav(
                                    activeIndex: _index,
                                    onTap: _onSidebarTap,
                                    activeRoute: '',
                                  ),
                                  const SizedBox(height: 20),
                                  _pages[_index],
                                ],
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: isDesktop ? 120 : 64),

                  /// 🟪 FOOTER (FULL WIDTH)
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