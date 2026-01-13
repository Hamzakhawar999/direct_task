import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWeb = constraints.maxWidth >= 1200;

        // 🔒 FONT SIZES (mobile unchanged, web boosted)
        final double headingSize = isWeb ? 26 : 18.sp;
        final double bodySize = isWeb ? 14 : 11.sp;
        final double linkSize = isWeb ? 14 : 11.sp;
        final double contactSize = isWeb ? 15 : 11.sp;

        return SizedBox(
          width: double.infinity,
          height: 90.h, // 🔒 EXACT HEIGHT
          child: Stack(
            children: [
              /// BACKGROUND
              Positioned.fill(
                child: Image.asset(
                  'assets/images/footer_bg.png',
                  fit: BoxFit.cover,
                ),
              ),

              /// CONTENT
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),

                        /// NEWSLETTER
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: headingSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: const [
                              TextSpan(text: 'Join Our '),
                              TextSpan(
                                text: 'Newsletter Stay Up To Date',
                                style: TextStyle(
                                  color: Color(0xFFF08A5D),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 4.h),

                        /// EMAIL + BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: isWeb ? 420 : 36.w,
                              child: Container(
                                height: 6.5.h,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.centerLeft,
                                child: TextWidget(
                                  'Email address...',
                                  fontSize: isWeb ? 14 : 12.sp,
                                  color: const Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                            SizedBox(width: 1.8.w),
                            Container(
                              height: 6.h,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF08A5D),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  TextWidget(
                                    'Subscribe Now',
                                    fontSize: isWeb ? 14 : 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 1.w),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: isWeb ? 18 : 1.8.h,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 22.h),

                        /// FOOTER CONTENT
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// LEFT
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: isWeb ? 36 : 3.h,
                                  ),
                                  SizedBox(height: 2.h),
                                  TextWidget(
                                    'Professional cleaners for homes, offices, shops,\n'
                                    'and apartments. Fast, reliable, and eco-friendly\n'
                                    'cleaning solutions.',
                                    fontSize: bodySize,
                                    height: 1.6,
                                    color:
                                        Colors.white.withOpacity(0.9),
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    children: [
                                      Icon(Icons.play_circle,
                                          color: Colors.white,
                                          size: isWeb ? 20 : 2.2.h),
                                      SizedBox(width: 1.8.w),
                                      Icon(Icons.camera_alt,
                                          color: Colors.white,
                                          size: isWeb ? 20 : 2.2.h),
                                      SizedBox(width: 1.8.w),
                                      Icon(Icons.facebook,
                                          color: Colors.white,
                                          size: isWeb ? 20 : 2.2.h),
                                      SizedBox(width: 1.8.w),
                                      Icon(Icons.mail,
                                          color: Colors.white,
                                          size: isWeb ? 20 : 2.2.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 4.8.w),

                            /// CENTER
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  TextWidget('About Us',
                                      fontSize: linkSize,
                                      color: Colors.white),
                                  SizedBox(height: 1.2.h),
                                  TextWidget('Services',
                                      fontSize: linkSize,
                                      color: Colors.white),
                                  SizedBox(height: 1.2.h),
                                  TextWidget('Pricing',
                                      fontSize: linkSize,
                                      color: Colors.white),
                                  SizedBox(height: 1.2.h),
                                  TextWidget('Blog',
                                      fontSize: linkSize,
                                      color: Colors.white),
                                  SizedBox(height: 1.2.h),
                                  TextWidget('Contact Us',
                                      fontSize: linkSize,
                                      color: Colors.white),
                                ],
                              ),
                            ),

                            SizedBox(width: 4.8.w),

                            /// RIGHT
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    '+(084) 456-0789',
                                    fontSize: contactSize,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color(0xFFF08A5D),
                                  ),
                                  SizedBox(height: 2.h),
                                  TextWidget(
                                    'support@example.com',
                                    fontSize: contactSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 2.h),
                                  TextWidget(
                                    '5609 E Sprague Ave, Spokane Valley,\n'
                                    'WA 99212, USA',
                                    fontSize: bodySize,
                                    height: 1.6,
                                    color: Colors.white
                                        .withOpacity(0.9),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}