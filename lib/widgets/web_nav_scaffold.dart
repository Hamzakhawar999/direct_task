import 'package:direct_task_web/user_flow/request/requestScreen.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:flutter/material.dart';
import 'package:direct_task_web/user_flow/home/landing_screen.dart';
import 'package:direct_task_web/user_flow/servicee/service_page.dart';

class WebNavScaffold extends StatefulWidget {
  final int currentIndex;

  const WebNavScaffold({super.key, required this.currentIndex});

  @override
  State<WebNavScaffold> createState() => _WebNavScaffoldState();
}

class _WebNavScaffoldState extends State<WebNavScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _onNavTap(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  late final List<Widget> _pages = [
    LandingScreen(onNavTap: _onNavTap), // ✅ CONNECTED
    const ServicePage(),
    const RequestScreen(),
    const ServicePage(),
    const ServicePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isHome = _currentIndex == 0;

    return Scaffold(
      body: Column(
        children: [
          if (!isHome)
            WebNavbar(
              currentIndex: _currentIndex,
              onTap: _onNavTap,
            ),

          Expanded(child: _pages[_currentIndex]),
        ],
      ),
    );
  }
}