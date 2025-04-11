import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/game_details/view_models/game_details_view_model.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_circular_progress_indicator.dart';
import 'package:desafio_webadapte/src/ui/game_details/widgets/player_ad_card.dart';
import 'package:flutter/material.dart';

class PhoneGameDetailsScreen extends StatefulWidget {
  final int gameId;

  const PhoneGameDetailsScreen({super.key, required this.gameId});

  @override
  State<PhoneGameDetailsScreen> createState() => _PhoneGameDetailsScreenState();
}

class _PhoneGameDetailsScreenState extends State<PhoneGameDetailsScreen> {
  final _viewModel = GameDetailsViewModel();

  SafeArea buildBody({
    required double displayWidth,
    required double displayHeight,
    required bool isDeviceInLandscape,
  }) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: displayWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.zinc300,
                    iconSize: isDeviceInLandscape ? 30 : 25,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    // width: ,
                    height: isDeviceInLandscape ? displayHeight * 0.15 : displayWidth * 0.12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              width: displayWidth,
              height: isDeviceInLandscape ? displayWidth * 0.22 : displayHeight * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(_viewModel.game.imageSrc),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _viewModel.game.name,
                  style: PhoneTextStyles.headlineMedium,
                ),
                Text(
                  'Conecte-se e comece a jogar!',
                  style: PhoneTextStyles.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SizedBox(
              height: 290,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _viewModel.game.ads.length,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  return PlayerAdCard.fromDeviceType(
                    playerAd: _viewModel.game.ads[index],
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

    _viewModel.addListener(() {
      setState(() {});
    });

    _viewModel.getGameDetails(gameId: widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;
    final double displayHeight = MediaQuery.of(context).size.height;
    final Orientation deviceOrientation = MediaQuery.of(context).orientation;
    final bool isDeviceInLandscape = deviceOrientation == Orientation.landscape;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: displayHeight),
          child: Container(
            width: displayWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/phone_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:
                _viewModel.isLoading
                    ? CustomCircularProgressIndicator()
                    : buildBody(
                      displayWidth: displayWidth,
                      displayHeight: displayHeight,
                      isDeviceInLandscape: isDeviceInLandscape,
                    ),
          ),
        ),
      ),
    );
  }
}
