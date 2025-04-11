import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_circular_progress_indicator.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_logo.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_snack_bar.dart';
import 'package:desafio_webadapte/src/ui/home/view_models/home_view_model.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/game_card.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/player_form.dart';
import 'package:flutter/material.dart';

class TabletHomeScreen extends StatefulWidget {
  const TabletHomeScreen({super.key});

  @override
  State<TabletHomeScreen> createState() => _TabletHomeScreenState();
}

class _TabletHomeScreenState extends State<TabletHomeScreen> {
  final _viewModel = HomeViewModel();
  final ScrollController _scrollListController = ScrollController();

  void scrollListToLeft() {
    final double listPosition = _scrollListController.offset;
    final double maxListWidth = _scrollListController.position.maxScrollExtent;
    final double displacement = listPosition - (180 + 20);

    _scrollListController.animateTo(
      displacement.clamp(0.0, maxListWidth),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollListToRight() {
    final double listPosition = _scrollListController.offset;
    final double maxListWidth = _scrollListController.position.maxScrollExtent;
    final double displacement = listPosition + 180 + 20;

    _scrollListController.animateTo(
      displacement.clamp(0.0, maxListWidth),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  SafeArea buildBody({required double deviceWidth}) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          CustomLogo(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu ', style: TabletTextStyles.headlineLarge),
              ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: [
                        Color(0xFF9572FC),
                        Color(0xFF43E7AD),
                        Color(0xFFE2D45C),
                      ],
                    ).createShader(bounds),
                child: Text('duo', style: TabletTextStyles.headlineLarge),
              ),
              Text(' está aqui.', style: TabletTextStyles.headlineLarge),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    onPressed: scrollListToLeft,
                    iconSize: 48,
                    color: AppColors.zinc400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: SizedBox(
                    height: 240,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _viewModel.gameSummaryList.length,
                      controller: _scrollListController,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return GameCard.fromDeviceType(
                          context: context,
                          gameSummary: _viewModel.gameSummaryList[index],
                          deviceType: DeviceType.tablet,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: scrollListToRight,
                    iconSize: 48,
                    color: AppColors.zinc400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: Column(
              children: [
                Container(
                  width: deviceWidth,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9572FC),
                        Color(0xFF43E7AD),
                        Color(0xFFE2D45C),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: AppColors.blackPurple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Não encontrou seu duo?',
                            style: TabletTextStyles.headlineSmall,
                          ),
                          Text(
                            'Publique um anúncio para encontrar novos players!',
                            style: TabletTextStyles.strongBodySmall,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: showPlayerFormDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.violet500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        icon: Icon(
                          Icons.zoom_in_rounded,
                          size: 24,
                          color: AppColors.white,
                        ),
                        label: Text(
                          'Publicar anúncio',
                          style: TabletTextStyles.strongBodySmall.copyWith(
                            height: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showPlayerFormDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.blackPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: 550,
            // height: 900,
            child: SingleChildScrollView(
              child: PlayerForm(viewModel: _viewModel),
            ),
          ),
        );
      },
    );
  }

  void viewModelListener() {
    setState(() { });

    if (_viewModel.playerAdCreationErrorMessage.isNotEmpty) {
      CustomSnackBar(
        isError: true, 
        context: context,
        message: _viewModel.playerAdCreationErrorMessage,
      ).showSnackBar();
    }

    if (_viewModel.isPlayerAdCreated) {
      CustomSnackBar(
        isError: false, 
        context: context,
        message: 'Anúncio publicado com sucesso!',
      ).showSnackBar();
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(viewModelListener);
    _viewModel.getGameSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tablet_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child:
              _viewModel.isGameSummaryListLoading
                  ? CustomCircularProgressIndicator()
                  : buildBody(deviceWidth: deviceWidth),
        ),
      ),
    );
  }
}
