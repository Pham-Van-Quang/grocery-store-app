import 'package:flutter/material.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/views/home.dart';
import 'package:grocery_store_app/views/onboarding/onboarding.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshotData) {
        if (snapshotData.hasData) {
          return const Home(
            currentAddress: '',
          );
        } else {
          return const Onboarding();
        }
      },
      stream: Auth().authenStateChanges,
    );
  }
}
