import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class OfflineServicesSection extends StatelessWidget {
  const OfflineServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final bool isTablet = width >= 768 && width < 1100;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 8.h : 12.h,
      ),
      child: Column(
        children: [
          /// ================= TITLE =================
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: isMobile ? 18.sp : 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
              children: const [
                TextSpan(text: 'Our '),
                TextSpan(
                  text: 'Offline ',
                  style: TextStyle(color: Color(0xFFFF7F5D)),
                ),
                TextSpan(text: 'Services'),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          SizedBox(
            width: isMobile ? 90.w : 55.w,
            child: TextWidget(
              'Powerful digital solutions designed to help your business grow, '
              'scale, and succeed in the online world.',
              fontSize: isMobile ? 12 : 11.sp,
              height: 1.6,
              color: const Color(0xFF5C5E5E),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: isMobile ? 6.h : 8.h),

          /// ================= CONTENT =================
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 0),
                child: isMobile
                    ? const _MobileContent()
                    : _DesktopContent(isTablet: isTablet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= DESKTOP / TABLET =================
class _DesktopContent extends StatelessWidget {
  final bool isTablet;

  const _DesktopContent({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT LIST
        SizedBox(
          width: isTablet ? 420 : 480,
          child: const _ServiceList(),
        ),

        SizedBox(width: isTablet ? 48 : 80),

        /// RIGHT IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.asset(
            'assets/images/offline_services.png',
            width: isTablet ? 420 : 520,
            height: isTablet ? 420 : 480,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

/// ================= MOBILE =================
class _MobileContent extends StatelessWidget {
  const _MobileContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Image.asset(
            'assets/images/offline_services.png',
            height: 280,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 40),

        const _ServiceList(),
      ],
    );
  }
}

/// ================= SERVICE LIST =================
class _ServiceList extends StatelessWidget {
  const _ServiceList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ServiceRow(title: 'Logo Maker'),
        _ServiceRow(title: 'Web Design'),
        _ServiceRow(title: 'App Development', isActive: true),
        _ServiceRow(title: 'SEO (Search Engine Optimization)'),
        _ServiceRow(title: 'Q&A / Expert Support'),
      ],
    );
  }
}

/// ================= SERVICE ROW =================
class _ServiceRow extends StatelessWidget {
  final String title;
  final bool isActive;

  const _ServiceRow({
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.4.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEAEAEA)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextWidget(
              title,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? const Color(0xFFFF7F5D)
                  : const Color(0xFF1E1E1E),
            ),
          ),

          if (isActive)
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7F5D),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/icon.png',
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            )
          else
            Image.asset(
              'assets/images/icon.png',
              width: 22,
              height: 22,
              color: const Color(0xFF5B5EA6),
            ),
        ],
      ),
    );
  }
}