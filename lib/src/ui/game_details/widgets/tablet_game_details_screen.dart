import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_circular_progress_indicator.dart';
import 'package:desafio_webadapte/src/ui/game_details/view_models/game_details_view_model.dart';
import 'package:desafio_webadapte/src/ui/game_details/widgets/player_ad_card.dart';
import 'package:flutter/material.dart';

class TabletGameDetailsScreen extends StatefulWidget {
  final int gameId;

  const TabletGameDetailsScreen({super.key, required this.gameId});

  @override
  State<TabletGameDetailsScreen> createState() =>
      _TabletGameDetailsScreenState();
}

class _TabletGameDetailsScreenState extends State<TabletGameDetailsScreen> {
  final _viewModel = GameDetailsViewModel();

  AppBar? buildAppBar() {
    return AppBar(
      foregroundColor: AppColors.zinc300,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        padding: EdgeInsets.only(left: 30),
        icon: Icon(Icons.arrow_back_ios_new),
        iconSize: 40,
        onPressed: () => Navigator.pop(context),
      ),
      toolbarHeight: 85,
      centerTitle: true,
      title: Image.asset('assets/images/logo.png', width: 150),
    );
  }

  SafeArea buildBody({
    required double displayWidth,
    required double displayHeight,
  }) {
    final orientation = MediaQuery.of(context).orientation;
    final isDeviceInLandscape = orientation == Orientation.landscape;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85.0),
            child: SizedBox(
              width: displayWidth,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _viewModel.game.name,
                        style: TabletTextStyles.headlineMedium,
                      ),
                      Text(
                        'Conecte-se e comece a jogar!',
                        style: TabletTextStyles.strongHeadlineSmall.copyWith(
                          color: AppColors.zinc400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize:
                        isDeviceInLandscape
                            ? MainAxisSize.min
                            : MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: displayWidth * 0.45,
                        height: displayHeight * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(_viewModel.game.imageSrc),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 85),
            child: SizedBox(
              height: 360,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _viewModel.game.ads.length,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  return PlayerAdCard.fromDeviceType(
                    playerAd: _viewModel.game.ads[index],
                    deviceType: DeviceType.tablet,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() => setState(() {}));
    _viewModel.getGameDetails(gameId: widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;
    final displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _viewModel.isLoading ? null : buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: displayWidth,
          height: displayHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tablet_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child:
              _viewModel.isLoading
                  ? CustomCircularProgressIndicator()
                  : buildBody(
                    displayWidth: displayWidth,
                    displayHeight: displayHeight,
                  ),
        ),
      ),
    );
  }
}
