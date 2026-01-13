import 'package:flutter/material.dart';
import 'package:direct_task_web/provider_flow/widgets/ProviderNavScaffold.dart';

void handleProviderNav(BuildContext context, int index) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => ProviderNavScaffold(currentIndex: index),
    ),
  );
}