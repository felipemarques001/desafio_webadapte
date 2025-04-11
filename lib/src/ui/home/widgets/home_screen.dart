import 'package:desafio_webadapte/src/ui/core/widgets/responsive_widget.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/phone_home_screen.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/tablet_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: PhoneHomeScreen(),
      tablet: TabletHomeScreen(),
    );
  }
}
