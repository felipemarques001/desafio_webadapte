import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_circular_progress_indicator.dart';
import 'package:desafio_webadapte/src/ui/home/view_models/home_view_model.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/game_card.dart';
import 'package:flutter/material.dart';

class PhoneHomeScreen extends StatefulWidget {
  const PhoneHomeScreen({super.key});

  @override
  State<PhoneHomeScreen> createState() => _PhoneHomeScreenState();
}

class _PhoneHomeScreenState extends State<PhoneHomeScreen> {
  final _viewModel = HomeViewModel();

  SafeArea buildBody({required double displayWidth, required double displayHeight}) {
    final Orientation displayOrientation = MediaQuery.of(context).orientation;
    final bool isDeviceInLandscape = displayOrientation == Orientation.landscape;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: isDeviceInLandscape ? displayWidth * 0.15 : displayHeight * 0.15,
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Encontre o seu duo!', style: PhoneTextStyles.headlineMedium),
                Text(
                  'Selecione o game que deseja jogar...',
                  style: PhoneTextStyles.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: SizedBox(
              height: isDeviceInLandscape ? displayWidth * 0.35 :displayHeight * 0.5,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _viewModel.gameSummaryList.length,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  return GameCard.fromDeviceType(
                    context: context,
                    gameSummary: _viewModel.gameSummaryList[index],
                    deviceType: DeviceType.phone,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() => setState(() {}));
    _viewModel.getGameSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: displayHeight,
          ),
          child: Container(
            width: displayWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/phone_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:
                _viewModel.isGameSummaryListLoading
                    ? CustomCircularProgressIndicator()
                    : buildBody(displayWidth: displayWidth, displayHeight: displayHeight),
          ),
        ),
      ),
    );
  }
}
