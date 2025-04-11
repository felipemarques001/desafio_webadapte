import 'package:desafio_webadapte/src/data/models/game.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final BuildContext context;
  final GameSummary gameSummary;
  final double cardWidth;

  const GameCard({
    super.key,
    required this.context,
    required this.gameSummary,
    required this.cardWidth,
  });

  factory GameCard.fromDeviceType({
    required BuildContext context,
    required GameSummary gameSummary,
    required DeviceType deviceType,
  }) {
    late final double cardWidth;

    if (deviceType == DeviceType.phone) {
      final double displayWidth = MediaQuery.of(context).size.width;
      final double displayHeight = MediaQuery.of(context).size.height;
      final Orientation displayOrientation = MediaQuery.of(context).orientation;

      cardWidth =
          displayOrientation == Orientation.landscape
              ? displayHeight * 0.6
              : displayWidth * 0.7;
    }

    if (deviceType == DeviceType.tablet) {
      cardWidth = 210;
    }

    return GameCard(
      context: context,
      gameSummary: gameSummary,
      cardWidth: cardWidth,
    );
  }

  void navigateToGameDetailsScreen() {
    Navigator.of(
      context,
    ).pushNamed('/game-details', arguments: {'gameId': gameSummary.id});
  }

  String getAdsText() {
    if (gameSummary.adsQuantity == 0) {
      return 'Sem anúncios';
    }

    if (gameSummary.adsQuantity == 1) {
      return '1 anúncio';
    }

    return '${gameSummary.adsQuantity} anúncios';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToGameDetailsScreen,
      child: SizedBox(
        width: cardWidth,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(gameSummary.imageSrc),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0),
                      AppColors.black.withValues(alpha: 0.5),
                      AppColors.black.withValues(alpha: 0.8),
                      AppColors.black.withValues(alpha: 1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameSummary.name,
                        style: PhoneTextStyles.headlineSmall,
                      ),
                      Text(getAdsText(), style: PhoneTextStyles.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
