import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class BlogsSection extends StatelessWidget {
  const BlogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.white)),

        Positioned.fill(
          child: Image.asset(
            'assets/images/group-4.png',
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 48 : 10.h,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                ),
                child: Column(
                  children: [
                    /// ---------- TITLE ----------
                    Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            TextWidget(
                              'Learn ',
                              fontSize: isMobile ? 26 : 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            TextWidget(
                              'Our ',
                              fontSize: isMobile ? 26 : 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF08A5D),
                            ),
                            TextWidget(
                              'Latest News',
                              fontSize: isMobile ? 26 : 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            TextWidget(
                              'From ',
                              fontSize: isMobile ? 26 : 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            TextWidget(
                              'Blogs',
                              fontSize: isMobile ? 26 : 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF08A5D),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: isMobile ? 16 : 2.h),

                    /// ---------- SUBTITLE ----------
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 55.w,
                      ),
                      child: TextWidget(
                        'Stay updated with expert insights, professional cleaning tips, '
                        'and the latest trends from our trusted service community.',
                        fontSize: isMobile ? 14 : 12.5.sp,
                        height: 1.6,
                        color: const Color(0xFF5C5E5E),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: isMobile ? 36 : 7.h),

                    /// ---------- RESPONSIVE BLOG GRID ----------
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int columns = 3;
                        if (constraints.maxWidth < 1100) columns = 2;
                        if (constraints.maxWidth < 700) columns = 1;

                        final cardWidth =
                            (constraints.maxWidth - ((columns - 1) * 32)) /
                                columns;

                        return Wrap(
                          spacing: 32,
                          runSpacing: isMobile ? 32 : 48,
                          children: [
                            BlogCard(
                              width: cardWidth,
                              image: 'assets/images/blog1.png',
                              tag: 'Ware Accessories',
                              title:
                                  'Myths About Professional Cleaning Services — Debunked!',
                            ),
                            BlogCard(
                              width: cardWidth,
                              image: 'assets/images/blog2.png',
                              tag: 'Power Tools',
                              title:
                                  'How to Choose the Right Cleaning Service for Your Home',
                            ),
                            BlogCard(
                              width: cardWidth,
                              image: 'assets/images/blog3.png',
                              tag: 'Power Tools',
                              title:
                                  'Moving Out? Here’s Why You Need a Move-Out Cleaning Service',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= BLOG CARD =================
class BlogCard extends StatelessWidget {
  final String image;
  final String tag;
  final String title;
  final double width;

  const BlogCard({
    super.key,
    required this.image,
    required this.tag,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 391 / 312, // 🔒 preserved
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF08A5D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextWidget(
                    tag,
                    fontSize: isMobile ? 11 : 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 12 : 1.4.h),

          /// META
          Row(
            children: [
              TextWidget(
                'JUL 02, 2025',
                fontSize: isMobile ? 11 : 11.sp,
                color: const Color(0xFF9E9E9E),
              ),
              const SizedBox(width: 12),
              TextWidget(
                'BY ADMIN',
                fontSize: isMobile ? 11 : 11.sp,
                color: const Color(0xFF9E9E9E),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 12 : 1.6.h),

          /// TITLE
          TextWidget(
            title,
            fontSize: isMobile ? 15 : 14.sp,
            fontWeight: FontWeight.bold,
            height: 1.4,
            color: const Color(0xFF1E1E1E),
          ),

          SizedBox(height: isMobile ? 14 : 1.8.h),

          /// READ MORE
          Row(
            children: const [
              TextWidget(
                'Read More',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: Color(0xFFF08A5D),
              ),
            ],
          ),
        ],
      ),
    );
  }
}