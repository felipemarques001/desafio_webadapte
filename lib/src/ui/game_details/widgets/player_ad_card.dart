import 'package:desafio_webadapte/src/data/models/player_ad.dart';
import 'package:desafio_webadapte/src/ui/core/themes/device_type.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class PlayerAdCard extends StatelessWidget {
  final PlayerAd ad;
  final double cardWidth;
  final TextStyle labelTextStyle;
  final TextStyle fieldTextStyle;
  final double dialogCloseIconSize;
  final double dialogCheckIconSize;
  final double discordUsernameFontSize;
  final TextStyle dialogTitleTextStyle;
  final TextStyle dialogSubtitleTextStyle;

  const PlayerAdCard({
    super.key,
    required this.ad,
    required this.cardWidth,
    required this.labelTextStyle,
    required this.fieldTextStyle,
    required this.dialogCloseIconSize,
    required this.dialogCheckIconSize,
    required this.dialogTitleTextStyle,
    required this.dialogSubtitleTextStyle,
    required this.discordUsernameFontSize,
  });

  factory PlayerAdCard.fromDeviceType({
    required PlayerAd playerAd,
    required DeviceType deviceType,
  }) {
    late final double cardWidth;
    late final TextStyle labelTextStyle;
    late final TextStyle fieldTextStyle;
    late final double dialogCloseIconSize;
    late final double dialogCheckIconSize;
    late final double discordUsernameFontSize;
    late final TextStyle dialogTitleTextStyle;
    late final TextStyle dialogSubtitleTextStyle;

    if (deviceType == DeviceType.phone) {
      labelTextStyle = PhoneTextStyles.bodyMedium.copyWith(
        color: AppColors.lightGrey,
      );
      cardWidth = 190;
      fieldTextStyle = PhoneTextStyles.strongBodyMedium;
      discordUsernameFontSize = 16;
      dialogCloseIconSize = 20;
      dialogCheckIconSize = 64;
      dialogTitleTextStyle = PhoneTextStyles.headlineMedium;
      dialogSubtitleTextStyle = PhoneTextStyles.strongBodyLarge;
    }

    if (deviceType == DeviceType.tablet) {
      labelTextStyle = TabletTextStyles.bodyMedium.copyWith(
        color: AppColors.lightGrey,
      );
      cardWidth = 230;
      fieldTextStyle = TabletTextStyles.strongBodyMedium;
      discordUsernameFontSize = 18;
      dialogCloseIconSize = 30;
      dialogCheckIconSize = 80;
      dialogTitleTextStyle = TabletTextStyles.strongHeadlineSmall;
      dialogSubtitleTextStyle = TabletTextStyles.strongBodyMedium;
    }

    return PlayerAdCard(
      ad: playerAd,
      cardWidth: cardWidth,
      labelTextStyle: labelTextStyle,
      fieldTextStyle: fieldTextStyle,
      dialogCloseIconSize: dialogCloseIconSize,
      dialogCheckIconSize: dialogCheckIconSize,
      discordUsernameFontSize: discordUsernameFontSize,
      dialogTitleTextStyle: dialogTitleTextStyle,
      dialogSubtitleTextStyle: dialogSubtitleTextStyle,
    );
  }

  String getYearsGameTimeText() {
    final int years = ad.yearsGameTime;

    if (years == 0) {
      return 'Primeiro ano';
    }

    if (years == 1) {
      return '1 ano';
    }

    return '$years anos';
  }

  String getDaysAvaibilityText() {
    return ad.daysAvailability == 1 ? '1 dia' : '${ad.daysAvailability} dias'; 
  }

  String getHoursAvaibilityText() {
    late final String startHoursAsString;
    late final String endHoursAsString;

    if (ad.startHoursAvailability == 0) {
      startHoursAsString = '00';
    } else {
      startHoursAsString = ad.startHoursAvailability.toString();
    }

    if (ad.endHoursAvailability == 0) {
      endHoursAsString = '00';
    } else {
      endHoursAsString = ad.endHoursAvailability.toString();
    }

    return '${startHoursAsString}h - ${endHoursAsString}h';
  }

  Column createField({required String labelText, required String fieldValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: labelTextStyle),
        Text(fieldValue, style: fieldTextStyle),
        const SizedBox(height: 10),
      ],
    );
  }

  void showDiscordDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.blackPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          size: dialogCloseIconSize,
                          color: AppColors.zinc500,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline_outlined,
                    size: dialogCheckIconSize,
                    color: AppColors.emerald400,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text('Let’s play!', style: dialogTitleTextStyle),
                      Text(
                        'Agora é só começar a jogar!',
                        style: dialogSubtitleTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        'Adicione no Discord',
                        style: dialogSubtitleTextStyle.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.zinc900,
                        ),
                        child: Center(
                          child: Text(
                            ad.discordUsername,
                            style: TextStyle(
                              height: 2.6,
                              fontSize: discordUsernameFontSize,
                              fontWeight: FontWeight.w400,
                              color: AppColors.zinc200,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.blackPurple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createField(labelText: 'Nome', fieldValue: ad.playerName),
          createField(
            labelText: 'Tempo de Jogo',
            fieldValue: getYearsGameTimeText(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Disponibilidade', style: labelTextStyle),
              Row(
                children: [
                  Text(getDaysAvaibilityText(), style: fieldTextStyle),
                  const SizedBox(width: 5),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.zinc500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(getHoursAvaibilityText(), style: fieldTextStyle),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chamada de áudio?', style: labelTextStyle),
              Text(
                ad.audioCall ? 'Sim' : 'Não',
                style: fieldTextStyle.copyWith(
                  color: ad.audioCall ? AppColors.emerald400 : AppColors.red400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => showDiscordDialog(context: context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.violet500,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/icons/game_controller.png'),
                Text(
                  'Conectar',
                  style: fieldTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
