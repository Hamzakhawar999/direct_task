import 'package:flutter/material.dart';
import 'widgets/hero_section.dart';
import 'widgets/services_section.dart';
import 'widgets/why_choose_section.dart';
import 'widgets/OfflineServicesSection.dart';
import 'widgets/OfflineServicesBannerSection.dart';
import 'widgets/OurServiceProvidersSection.dart';
import 'widgets/OurPricingPlansSection.dart';
import 'widgets/blog_section.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

class LandingScreen extends StatelessWidget {
  final Function(int)? onNavTap;

  const LandingScreen({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(onNavTap: onNavTap),
          WhyChooseSection(),
          ServicesSection(),
          OfflineServicesSection(),
          OfflineServicesBannerSection(),
          OurServiceProvidersSection(),
          OurPricingPlansSection(),
          BlogsSection(),
          FooterSection(),
        ],
      ),
    );
  }
}