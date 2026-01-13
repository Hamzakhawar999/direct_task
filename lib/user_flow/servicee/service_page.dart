import 'package:flutter/material.dart';
import 'package:direct_task_web/user_flow/servicee/widgets/service_page_body.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ServicePageBody(),
          FooterSection(),
        ],
      ),
    );
  }
}