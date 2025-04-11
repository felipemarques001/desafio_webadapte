import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_logo.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppBar buildAppBar() {
    return AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent);
  }

  Container buildBody({
    required BuildContext context,
    required DeviceType deviceType,
  }) {
    late final String backgroundPath;

    if (deviceType == DeviceType.phone) {
      backgroundPath = 'assets/images/phone_background.png';
    }

    if (deviceType == DeviceType.tablet) {
      backgroundPath = 'assets/images/tablet_background.png';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundPath),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomLogo(),
    );
  }

  Scaffold buildSplashScreenToPhone({required BuildContext context}) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: buildBody(context: context, deviceType: DeviceType.phone),
    );
  }

  Scaffold buildSplashScreenToTablet({required BuildContext context}) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: buildBody(context: context, deviceType: DeviceType.tablet),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: buildSplashScreenToPhone(context: context),
      tablet: buildSplashScreenToTablet(context: context),
    );
  }
}
