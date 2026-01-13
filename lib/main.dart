import 'package:direct_task_web/auth/select_role_web.dart';
import 'package:direct_task_web/provider_flow/widgets/ProviderNavScaffold.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:direct_task_web/widgets/web_nav_scaffold.dart';

void main() {
  runApp(const DirectTaskApp());
}

class DirectTaskApp extends StatelessWidget {
  const DirectTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Direct Task',
          theme: ThemeData(useMaterial3: true),
         home: const SelectRoleWebScreen(),
        );
      },
    );
  }
}